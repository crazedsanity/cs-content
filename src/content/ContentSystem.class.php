<?php

namespace crazedsanity\content;

use crazedsanity\filesystem\FileSystem;
use crazedsanity\content\GenericPage;
use crazedsanity\core\ToolBox;
use crazedsanity\dbsession\DBSession;
use crazedsanity\database\Database;
use Exception;

class ContentSystem {
	
	protected $baseDir			= NULL;			//base directory for templates & includes.			
	protected $section			= NULL;			//section string, derived from the URL.		
	protected $sectionArr		= array();		//array of items, for figuring out where templates & includes are.
	protected $fullSectionArr	= array();
	
	
	protected $tmplFs			= NULL;			//Object used to access the TEMPLATES filesystem
	protected $incFs 			= NULL;			//Object used to access the INCLUDES filesystem
	
	
	protected $ignoredList		= array(		//array of files & folders that are implicitely ignored.
									'file'	=> array('.htaccess'),
									'dir'	=> array('.svn','CVS'
									)
								);
	protected $templateList		= array();
	protected $includesList		= array();
	protected $afterIncludesList= array();
	public $templateObj		= NULL;
	protected $gfObj			= NULL;
	protected $tabs				= NULL;
	
	protected $finalSection;
	
	private $isValid=FALSE;
	private $reason=NULL;
	
	private $injectVars=array();
	public $templateSource = array();
	public $db;
	
	//------------------------------------------------------------------------
	/**
	 * The CONSTRUCTOR.  Duh.
	 */
	public function __construct($siteRoot=null, $section=null) {
		if(is_null($section)) {
			$section = $_SERVER['REQUEST_URI'];
		}
		$this->section = $this->clean_url($section);
		
		$this->initialize_locals($siteRoot);
	}//end __construct()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Creates internal objects & prepares for later usage.
	 */
	private function initialize_locals($siteRoot=null) {
		
		//create a session that gets stored in a database if they so desire...
		if(defined('SESSION_DBSAVE')) {
			ini_set('session.save_handler', 'user');
			
			//constant('DB_DSN'), constant('DB_USERNAME'), constant('DB_PASSWORD')
			if(defined('DB_DSN') && defined('DB_USERNAME') && defined('DB_PASSWORD')) {
				$this->db = new Database(constant('DB_DSN'), constant('DB_USERNAME'), constant('DB_PASSWORD'));
				$this->session = new DBSession(false, $this->db);
				$this->handle_session($this->session);
			}
			else {
				throw new exception(__METHOD__ .": cannot instantiate Session DB: no database connection values defined");
			}
		}
		
		$templateBaseDir = "templates";
		$includeBaseDir = "includes";
		$root = preg_replace(array('~/$~', '~/public_html$~', '~/html~'), '', $_SERVER['DOCUMENT_ROOT']);
		if(defined('CS_TEMPLATE_BASE_DIR')) {
			if(is_dir(constant('CS_TEMPLATE_BASE_DIR'))) {
				$templateBaseDir = constant('CS_TEMPLATE_BASE_DIR');
			}
			else {
				throw new exception(__METHOD__ .": invalid template directory (". constant('CS_TEMPLATE_BASE_DIR') .")");
			}
		}
		else {
			$templateBaseDir = $root .'/templates';
		}
		if(defined('CS_INCLUDE_BASE_DIR')) {
			if(is_dir(constant('CS_INCLUDE_BASE_DIR'))) {
				$includeBaseDir = constant('CS_INCLUDE_BASE_DIR');
			}
			else {
				throw new exception(__METHOD__ .": invalid includes directory (". constant('CS_INCLUDE_BASE_DIR') .")");
			}
		}
		else {
			$includeBaseDir = $root .'/includes';
		}
		
		if(!is_null($siteRoot) && is_dir($siteRoot)) {
			$root = $siteRoot;
		}
		elseif(defined('SITE_ROOT') && is_dir(constant('SITE_ROOT'))) {
			$root = constant('SITE_ROOT');
		}
		
		
		//create a fileSystem object for templates.
		$this->tmplFs = new FileSystem(preg_replace('~/+~', '/', $templateBaseDir));
		
		
		//create a fileSystem object for includes
		$this->incFs = new FileSystem(preg_replace('~/+~', '/', $includeBaseDir));
		
		$this->templateObj = new GenericPage(FALSE, $this->tmplFs->root ."/main.shared.tmpl");
		
		//setup some default template vars.
		$defaultVars = array(
			'date'			=> date('m-d-Y'),
			'time'			=> date('H:i:s'),
			'curYear'		=> date('Y'),
			'curDate'		=> date("F j, Y"),
			'curMonth'		=> date("m"),
			'timezone'		=> date("T"),
			'DOMAIN'		=> $_SERVER['SERVER_NAME'],
			//'PHP_SELF'		=> $_SERVER['SCRIPT_NAME'],		// --> set in finish().
			'REQUEST_URI'	=> $_SERVER['REQUEST_URI'],
			'FULL_URL'		=> $_SERVER['HTTP_HOST'] . $_SERVER['SCRIPT_NAME'],
			'error_msg'		=> ""
		);
		foreach($defaultVars as $k=>$v) {
			$this->templateObj->add_template_var($k, $v);
		}
		
		
		$myUrl = '/';
		if(strlen($this->section) && $this->section !== 0) {
			$myUrl = '/'. $this->section;
		}
		$this->templateObj->add_template_var('CURRENT_URL', $myUrl);
		
		if(defined('APPURL')) {
			//set the APPURL as a template var.
			$this->templateObj->add_template_var('APPURL', constant('APPURL'));
		}
		
		//split apart the section so we can do stuff with it later.
		$this->parse_section();
		
		//get ready for when we have to load templates & such.
		$this->prepare();
	}//end initialize_locals()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Call this to require that users accessing the given URL are authenticated; 
	 * if they're not, this will cause them to be redirected to another URL 
	 * (generally, so they can login).
	 */
	public function force_authentication($redirectToUrl, $destinationArg='loginDestination') {
		if(is_object($this->session) && method_exists($this->session, 'is_authenticated')) {
			if(strlen($redirectToUrl)) {
				$cleanedRedirect = $this->clean_url($redirectToUrl);
				if($this->section != $cleanedRedirect) {
					if(!$this->session->is_authenticated()) {
						//run the redirect.
						if(strlen($destinationArg)) {
							$redirectToUrl .= '?'. $destinationArg .'='. urlencode($_SERVER['REQUEST_URI']);
						}
						ToolBox::conditional_header($redirectToUrl, TRUE);
					}
				}
				else {
					throw new exception(__METHOD__ .": redirect url (". $redirectToUrl .") matches current URL");
				}
			}
			else {
				throw new exception(__METHOD__ .": failed to provide proper redirection URL");
			}
		}
		else {
			throw new exception(__METHOD__ .": cannot force authentication (missing method)");
		}
	}//end force_authentication()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Used to determine if contentSystem{} should handle creating the session.
	 */
	public function handle_session(&$sessionObj=NULL) {
		if(is_object($sessionObj)) {
			//they want us to use a different class... fine.
			$this->session = $sessionObj;
		}
		else {
			//use our own session handler.
			$this->session = new Session;
		}
		
		if(!method_exists($this->session, 'is_authenticated')) {
			throw new exception(__METHOD__ .": session class ('". get_class($this->session) ."') is missing method is_authenticated()");
		}
	}//end handle_session()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Rips apart the "section" string, setting $this->section and $this->sectionArr.
	 */
	private function parse_section() {
		
		//TODO::: this should be an OPTIONAL THING as to how to handle "/" (i.e. CSCONTENT_HANDLE_ROOTURL='content/index')
		if(($this->section === 0 || is_null($this->section) || !strlen($this->section)) && defined('DEFAULT_SECTION')) {
			$this->section = preg_replace('/^\//', '', constant('DEFAULT_SECTION'));
		}
		$myArr = explode('/', $this->section);
		
		//if we've got something in the array, keep going.
		if(is_array($myArr) && count($myArr) > 0) {
			$this->fullSectionArr = $myArr;
			$this->baseDir = array_shift($myArr);
			$this->sectionArr = $myArr;
		}
		else {
			throw new exception(__METHOD__ .": failed to get an array from section (". $this->section .")");
		}
	}//end parse_section()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Removes all the crap from the url, so we can figure out what section we
	 * 	need to load templates & includes for.
	 */
	private function clean_url($section=NULL) {
		if(!strlen($section) && strlen($this->section)) {
			//if argument wasn't given, use internal pointer.
			$section = $this->section;
		}

		//make sure we've still got something valid to work with.
		if(strlen($section)) {
			try {
				$section = ToolBox::clean_url($section);
			}
			catch(Exception $e) {
				//hide the exception and allow it to return NULL.
			}
		}
		else {
			$section = null;
		}
		return($section);
	}//end clean_url()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Retrieves the list of templates & includes in preparation for later work.
	 */
	private function prepare() {
		//attempt to load any includes...
		$this->load_includes();
		$foundIncludes = count($this->includesList);
		
		$validatePageRes = $this->validate_page();
		if($foundIncludes || $validatePageRes) {

			$myTestDir = "";
			$templates = $this->arrange_directory_contents('/', 'section', 'name');
			if(isset($templates['shared']) && count($templates['shared'])) {
				foreach($templates['shared'] as $var => $file) {
					$this->add_template($var, $file);
				}
			}

			$myIndex = 1;
			foreach($this->fullSectionArr as $index=>$value) {
				$myTestDir .= '/'. $value;

				$templates = $this->arrange_directory_contents($myTestDir, 'section', 'name');
				if(count($templates)) {
					if(isset($templates['shared'])) {
						foreach($templates['shared'] as $v=>$f) {
							$this->add_template($v, $f);
						}
					}

					if(isset($this->fullSectionArr[$myIndex])) {
						$this->load_page_templates($myTestDir, $this->fullSectionArr[$myIndex]);
					}
					else {
						$this->load_page_templates($myTestDir, 'index');
					}

					$myIndex ++;
				}
				else {
					break;
				}
			}
			//now cd() all the way back.
			$this->tmplFs->cd('/');
			$this->incFs->cd('/');
		}
		else {
			//couldn't find the templates directory, and no includes... it's dead.
			$this->die_gracefully(__METHOD__ .": unable to find the templates directory, or non-valid page [". $this->validate_page() ."]");
		}
	}//end prepare()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Ensures the page we're on would actually load, so other methods don't have to do
	 * 	so much extra checking.
	 */
	private function validate_page() {
		
		$this->tmplFs->cd('/');
		
		$valid = false;
		
		if((count($this->sectionArr) > 0) && !((count($this->sectionArr) == 1) && ($this->sectionArr[0] == 'index'))) {
			$mySectionArr = $this->sectionArr;
			$this->finalSection = array_pop($mySectionArr);
			$reasonText = "page template";
		}
		else {
			$this->finalSection = $this->baseDir;
			$reasonText = "base template";
		}
		
		$tmplFile1 = $this->section .".content.tmpl";
		$tmplFile2 = $this->section ."/index.content.tmpl";
		
		if(file_exists($this->tmplFs->realcwd ."/". $tmplFile2) || file_exists($this->tmplFs->realcwd ."/". $tmplFile1)) {
			$valid = true;
			$this->reason=null;
		}
		else {
			$valid = false;
			$this->reason=__METHOD__ .": couldn't find ". $reasonText;
		}
		$this->isValid = $valid;
		
		return($valid);
	}//end validate_page()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Loads the templates for the current page 
	 */
	private function load_page_templates($dir, $pageName) {
		$loadedPageTemplate = false;
		
		$templates = $this->arrange_directory_contents($dir, 'name', 'section');
		if(isset($templates[$pageName]) && isset($templates[$pageName]['content'])) {
			$this->add_template('content', $templates[$pageName]['content']);
			$loadedPageTemplate = true;
			unset($templates[$pageName]['content']);
		}
		elseif(isset($templates['index']) && isset($templates['index']['content'])) {
			$this->add_template('content', $templates['index']['content']);
			unset($templates['index']['content']);
			$loadedPageTemplate = true;
		}
		
		if($loadedPageTemplate) {
			//now load all 'content' templates (i.e. "*.content.tmpl" files).
			$xTemplates = $this->arrange_directory_contents($dir, 'section', 'name');
			if(isset($xTemplates['content'])) {
				//remove special ones.
				unset($xTemplates['content'][$pageName], $xTemplates['content']['index']);
				foreach($xTemplates['content'] as $v=>$f) {
					$this->add_template($v, $f);
				}
			}
		}
		
		return($loadedPageTemplate);
	}//end load_page_template()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Pulls a list of files in the current directory, & arranges them by section & 
	 * 	name, or vice-versa.
	 */
	private function arrange_directory_contents($dir, $primaryIndex='section', $secondaryIndex='name') {
		$fsObj = new FileSystem($this->tmplFs->root);
		if($fsObj->cd($dir)) {
			$directoryInfo = $fsObj->ls(null,false);
			$arrangedArr = array();
			if(is_array($directoryInfo)) {
				foreach($directoryInfo as $index=>$data) {
					$myType = $data['type'];
					if(($myType == 'file') && !in_array($index, $this->ignoredList[$myType])) {
						$filename = $this->gfObj->create_list($fsObj->cwd, $index, '/');
						$filename = preg_replace('/^\/templates/', '', $filename);
						$filename = preg_replace('/^\/\//', '/', $filename);
						//call another method to rip the filename apart properly, then arrange things as needed.
						$pieces = $this->parse_filename($index);
						$myPriIndex = $pieces[$primaryIndex];
						$mySecIndex = $pieces[$secondaryIndex];
						if(strlen($myPriIndex) && strlen($mySecIndex)) {
							//only load if it's got BOTH parts of the filename.
							$arrangedArr[$myPriIndex][$mySecIndex] = $filename;
						}
					}
				}
			}
		}
		else {
			$arrangedArr = array();
		}
		
		return($arrangedArr);
	}//end arrange_directory_contents()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Takes a filename (string) and breaks it down into the "type", "section", and
	 * 	"name".  I.E. for the filename "test.content.tmpl", type=tmpl, section="content",
	 * 	and "name"=test.
	 * TODO: set a way to define how the filenames are setup, so filenames can be "name.section.type" or "section.name.type".
	 */
	private function parse_filename($filename) {
		//break it into it's various parts.
		$myParts = explode('.', $filename);
		$retval = array();
		$count = count($myParts);
		if($count >= 3) {
			//"type" is the last element of the array, and "section" is the second-to-last.
			$type = array_pop($myParts);
			
			//define what types of files that are accepted: if it's not one of them, don't bother.
			$acceptedTypes = array("tmpl");
			if(in_array($type, $acceptedTypes)) {
				$section = array_pop($myParts);
				
				//just in case we want to allow templates with "."'s in them, rip off the 
				//	last two parts, and use what's left as the name.
				$stripThis = '.'. $section .'\.'. $type .'$';
				$name = preg_replace('/'. $stripThis .'/', '', $filename);
				
				$retval = array(
					'name'		=> $name,
					'section'	=> $section,
					'type' 		=> $type
				);
			}
		}
		
		return($retval);
	}//end parse_filename()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Finds all scripts in the /inlcudes directory, & adds them to the includesList array.
	 */
	private function load_includes() {
		
		//first load includes for the base directory.
		$this->load_dir_includes($this->baseDir);
		
		//okay, now loop through $this->sectionArr & see if we can include anything else.
		if(($this->incFs->cd($this->baseDir)) && is_array($this->sectionArr) && count($this->sectionArr) > 0) {
			
			
			//if the last item in the array is "index", disregard it...
			$loopThis = $this->sectionArr;
			$lastSection = $this->sectionArr[(count($this->sectionArr) -1)];
			if($lastSection == 'index') {
				array_pop($loopThis);
			}
			
			
			foreach($loopThis as $mySection) {
				//Run includes.
				$this->load_dir_includes($mySection);
				
				//attempt to cd() into the next directory, or die if we can't.
				if(!$this->incFs->cd($mySection)) {
					//no dice.  Break the loop.
					break;
				}
			}
		}
		
		//include the final shared & index files.
		$mySection = $this->section;
		if(preg_match('/\/index$/', $mySection)) {
			$mySection = preg_replace('/\/index$/','', $mySection);
		}
		if($this->incFs->cd('/'. $mySection)) {
			$lsData = $this->incFs->ls(null,false);
			if(isset($lsData['shared.inc']) && is_array($lsData['shared.inc'])) {
				$this->add_include('shared.inc');
			}
			if(isset($lsData['shared.after.inc']) && is_array($lsData['shared.after.inc'])) {
				$this->add_include('shared.after.inc',true);
			}
			if(isset($lsData['index.inc']) && is_array($lsData['index.inc'])) {
				$this->add_include('index.inc');
			}
		}
	}//end load_includes()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Attempts to add a shared include & the given section's include file: used 
	 * 	solely by load_includes().
	 */
	private function load_dir_includes($section) {
		$lsData = $this->incFs->ls(null,false);

		$addThese = array();
		
		//attempt to load the shared includes file.
		if(isset($lsData['shared.inc']) && $lsData['shared.inc']['type'] == 'file') {
			$this->add_include('shared.inc');
		}
		
		//add the shared "after" script.
		if(isset($lsData['shared.after.inc'])) {
			$addThese [] = 'shared.after.inc';
		}
		
		//attempt to load the section's includes file.
		$myFile = $section .'.inc';
		if(isset($lsData[$myFile]) && $lsData[$myFile]['type'] == 'file') {
			$this->add_include($myFile);
		}
		
		//add the section "after" script.
		if(isset($lsData[$section .'.after.inc'])) {
			$addThese [] = $section .'.after.inc';
		}
		
		if(is_array($addThese) && count($addThese)) {
			foreach($addThese as $f) {
				$this->add_include($f,true);
			}
		}
		
	}//end load_dir_includes()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Called when something is broken.
	 */
	private function die_gracefully($details=NULL) {
		if($this->templateObj->template_file_exists('system/404.shared.tmpl')) {
			if(isset($_SERVER['SERVER_PROTOCOL'])) {
				header('HTTP/1.0 404 Not Found');
			}
			//Simple "Page Not Found" error... show 'em.
			$this->templateObj->add_template_var('main', $this->templateObj->file_to_string('system/404.shared.tmpl'));
			
			//add the message box & required template vars to display the error.
			$this->templateObj->add_template_var('content', $this->templateObj->file_to_string('system/message_box.tmpl'));
			$this->templateObj->add_template_var('messageType', 'fatal');
			$this->templateObj->add_template_var('title', "Fatal Error");
			$this->templateObj->add_template_var('message', $details);
			
			
			$this->templateObj->add_template_var('datetime', date('m-d-Y H:i:s'));
			$this->templateObj->print_page();
			exit;
		}
		else {
			throw new exception(__METHOD__ .": Couldn't find 404 template, plus additional error... \nDETAILS::: $details" .
					"\nREASON::: ". $this->reason);
		}
	}//end die_gracefully()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * The super-magical method that includes files & finalizes things using 
	 * the given templating engine. 
	 * NOTE: the local variable "$page" is made so that the included scripts 
	 * can make calls to the templating engine, just like they used to.  It's 
	 * AWESOME.
	 */
	function finish() {
		//Avoid problems when REGISTER_GLOBALS is on...
		$badUrlVars = array('page', 'this');
		foreach($badUrlVars as $badVarName) {
			unset($_GET[$badVarName], $_POST[$badVarName]);
		}
		unset($badUrlVars, $badVarName);
		
		if(is_array($this->injectVars) && count($this->injectVars)) {
			$definedVars = get_defined_vars();
			foreach($this->injectVars as $myVarName=>$myVarVal) {
				if(!isset($definedVars[$myVarName])) {
					$$myVarName = $myVarVal;
				}
				else {
					throw new exception(__METHOD__ .": attempt to inject already defined var '". $myVarName ."'");
				}
			}
		}
		unset($definedVars, $myVarName, $myVarVal);
		
		if(isset($this->session) && is_object($this->session)) {
			$this->templateObj->session = $this->session;
		}
		
		
		//if we loaded an index, but there is no "content", then move 'em around so we have content.
		if(isset($this->templateObj->templateFiles['index']) && !isset($this->templateObj->templateFiles['content'])) {
			$this->add_template('content', $this->templateObj->templateFiles['index']);
		}
		
		//make the "final section" available to scripts.
		$finalSection = $this->finalSection;
		$sectionArr = $this->sectionArr;
		if(count($sectionArr) && $sectionArr[(count($sectionArr)-1)] == "") {
			array_pop($sectionArr);
		}
		$fullSectionArr = $this->fullSectionArr;
		array_unshift($sectionArr, $this->baseDir);
		$finalURL = $this->gfObj->string_from_array($sectionArr, NULL, '/');
		$this->templateObj->add_template_var('PHP_SELF', '/'. $this->gfObj->string_from_array($sectionArr, NULL, '/'));
		
		
		$page = $this->templateObj;
		
		//now include the includes scripts, if there are any.
		if(is_array($this->includesList) && count($this->includesList)) {
			try {
				foreach($this->includesList as $myInternalIndex=>$myInternalScriptName) {
					$this->myLastInclude = $myInternalScriptName;
					unset($myInternalScriptName, $myInternalIndex);
					include_once($this->myLastInclude);
				}
				
				//now load the "after" includes.
				if(is_array($this->afterIncludesList)) {
					foreach($this->afterIncludesList as $myInternalIndex=>$myInternalScriptName) {
						$this->myLastInclude = $myInternalScriptName;
						unset($myInternalScriptName, $myInternalIndex);
						include_once($this->myLastInclude);
					}
				}
			}
			catch(exception $e) {
				$myRoot = preg_replace('/\//', '\\\/', $this->incFs->root);
				$displayableInclude = preg_replace('/^'. $myRoot .'/', '', $this->myLastInclude);
				$page->set_message_wrapper(array(
					'title'		=> "Fatal Error",
					'message'	=> __METHOD__ .": A fatal error occurred while processing <b>". 
							$displayableInclude ."</b>:<BR>\n<b>ERROR</b>: ". $e->getMessage(),
					'type'		=> "fatal"
				));
				
				//try to pass the error on to the user's exception handler, if there is one.
				if(function_exists('exception_handler')) {
					exception_handler($e);
				}
			}
			unset($myInternalIndex);
			unset($myInternalScriptName);
		}
		
		if(is_bool($page->allow_invalid_urls() === TRUE) && $this->isValid === FALSE) {
			$this->isValid = $page->allow_invalid_urls();
		}
		
		if($this->isValid === TRUE) {
			if($page->printOnFinish === true) {
				$page->print_page();
			}
		}
		else {
			$this->die_gracefully($this->reason);
		}
	}//end finish()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Method for accessing the protected $this->sectionArr array.
	 */
	public function get_sectionArr() {
		//give 'em what they want.
		return($this->sectionArr);
	}//end get_sectionArr()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Method for accessing the protected member $this->finalSection.
	 */
	public function get_finalSection() {
		//give 'em what they want.
		return($this->finalSection);
	}//end get_finalSection()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Method for accessing "baseDir", only referenced as the base section.
	 */
	public function get_baseSection() {
		return($this->baseDir);
	}//end get_baseSection()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * The destructor... does nothing, right now.
	 */
	public function __destruct() {
	}//end __destruct()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Method that appends filenames to the list of include scripts.
	 */
	private final function add_include($file, $addAfter=false) {
		$myFile = preg_replace('/\/{2,}/', '/', $this->incFs->realcwd .'/'. $file);
		if(!is_numeric(array_search($myFile, $this->includesList))) {
			if($addAfter === true) {
				array_unshift($this->afterIncludesList, $myFile);
			}
			else {
				$this->includesList[] = $myFile;
			}
		}
	}//end add_include()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	private final function add_template($var, $file) {
		$file = preg_replace("/\/\//", "/", $file);
		$this->templateObj->add_template_file($var, $file);
	}//end add_template()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	public function inject_var($varName, $value) {
		$this->injectVars[$varName] = $value;
	}//end inject_var()
	//------------------------------------------------------------------------
	
	
}//end contentSystem{}
