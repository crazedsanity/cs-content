<?php
/*
 * FILE INFORMATION: 
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedRevision$
 * $LastChangedBy$
 * 
 * HOW THE SYSTEM WORKS:::
 * 	TEMPLATE FILES:
 * 	Automatically loads templates based on the URL, and optionally includes scripts in the includes directory.
 * 
 * 		MAIN SECTION:
 *	 		For the main section, i.e. "/content", it requires a template in a directory of that name beneath 
 * 			/templates, with a file called "index.content.tmpl"... i.e. /templatee/content/index.content.tmpl.
 * 		SUB SECTIONS:
 * 			For any subsection to be valid, i.e. "/content/members", it must have an associated template, i.e. 
 * 			"/templates/content/members.content.tmpl". If a subdirectory with an index.content.tmpl file exists, it will
 * 			be used instead of the file in the sub directory (i.e. "/templates/content/members/index.content.tmpl").
 * 		SUB SECTION TEMPLATE INHERITANCE:
 * 			All pages load the base set of "shared" templates, which are in the form "<section>.shared.tmpl" in
 * 			the root of the templates directory.
 * 	
 * 			Shared files within each directory, in the form "<section>.shared.tmpl", will be loaded for ANY subsection.
 *	 
 *	 		For any subsection, it inherits a previous section's templates in the following manner (any "content" 
 * 			templates are ignored for inheritance, as they're require for page load).
 * 				/content							---> /templates/content/index.*.tmpl
 *	 
 * 				/content/members					|--> /templates/content/index.*.tmpl
 * 													`--> /templates/content/members.*.tmpl
 *	 
 * 				/content/members/test				|--> /templates/content/index.*.tmpl
 * 													|--> /templates/content/members.*.tmpl
 * 													|--> /templates/content/members/index.*.tmpl
 * 													`--> /templates/content/members/test.*.tmpl
 * 	AUTOMATIC INCLUDES:
 * 	Much in the same way templates are included, so are scripts, from the /includes directory, though the logic
 * 	is decidedly simpler: all scripts must have the extension of ".inc", and must have either the section's name
 * 	as the first part of the filename, or "shared".  Shared scripts will be loaded for ALL subsections.
 * 
 * 		INCLUDES INHERITANCE:
 * 			The template inheritance scheme is as laid-out below.  The content system will go as far into the
 * 			includes directory as it can for the given section, regardless of if any intermediate files are missing.
 * 
 * 			It is important to note that the content system will NOT regard a section as valid if there are include
 * 			scripts but no templates.
 * 			
 * 				/content							|--> /includes/shared.inc
 * 													`--> /includes/content.inc
 * 
 * 				/content/members					|--> /includes/shared.inc
 * 													|--> /includes/content.inc
 * 													|--> /includes/content/shared.inc
 * 													`--> /includes/content/members.inc
 * 
 * 				/content/members/test				|--> /includes/shared.inc
 * 													|--> /includes/content.inc
 * 													|--> /includes/content/shared.inc
 * 													|--> /includes/content/members.inc
 * 													|--> /includes/content/members/shared.inc
 * 													|--> /includes/content/members/test.inc
 */

//TODO: remove this terrible little hack.
if(!isset($GLOBALS['SITE_ROOT'])) {
	//define where our scripts are located.
	$GLOBALS['SITE_ROOT'] = $_SERVER['DOCUMENT_ROOT'];
	$GLOBALS['SITE_ROOT'] = str_replace("/public_html", "", $GLOBALS['SITE_ROOT']);
}

require_once(dirname(__FILE__) ."/cs_globalFunctions.php");
require_once(dirname(__FILE__) ."/cs_fileSystemClass.php");
require_once(dirname(__FILE__) ."/cs_sessionClass.php");
require_once(dirname(__FILE__) ."/cs_genericPageClass.php");
require_once(dirname(__FILE__) ."/cs_tabsClass.php");
require_once(dirname(__FILE__) ."/../cs-versionparse/cs_version.abstract.class.php");

class contentSystem extends cs_versionAbstract {
	
	protected $baseDir			= NULL;			//base directory for templates & includes.			
	protected $section			= NULL;			//section string, derived from the URL.		
	protected $sectionArr		= array();		//array of items, for figuring out where templates & includes are.
	protected $fileSystemObj	= NULL;			//the object used to access the filesystem.
	protected $ignoredList		= array(		//array of files & folders that are implicitely ignored.
									'file'	=> array('.htaccess'),
									'dir'	=> array('.svn','CVS'
									)
								);
	protected $templateList		= array();
	protected $includesList		= array();
	public $templateObj		= NULL;
	protected $gfObj			= NULL;
	protected $tabs				= NULL;
	
	protected $finalSection;
	
	private $isValid=FALSE;
	private $reason=NULL;
	
	//------------------------------------------------------------------------
	/**
	 * The CONSTRUCTOR.  Duh.
	 */
	public function __construct($testOnly=FALSE) {
		if($testOnly === 'unit_test') {
			//It's just a test, don't do anything we might regret later.
			$this->isTest = TRUE;
		}
		else {
			$this->set_version_file_location(dirname(__FILE__) . '/VERSION');
			$this->get_version();
			$this->get_project();
			//make a cs_globalFunctions{} object.
			$this->gfObj = new cs_globalFunctions();
			
			//setup the section stuff...
			$repArr = array($_SERVER['SCRIPT_NAME'], "/");
			$_SERVER['REQUEST_URI'] = ereg_replace('^/', "", $_SERVER['REQUEST_URI']);
			
			//figure out the section & subsection stuff.
			$this->section = $this->clean_url($_SERVER['REQUEST_URI']);
			
			$this->initialize_locals();
		}
	}//end __construct()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Creates internal objects & prepares for later usage.
	 */
	private function initialize_locals() {
		//build the templating engine: this may cause an immediate redirect, if they need to be logged-in.
		//TODO: find a way to define this on a per-page basis.  Possibly have templateObj->check_login()
		//	run during the "finish" stage... probably using GenericPage{}->check_login().
		$this->templateObj = new cs_genericPage(FALSE, "main.shared.tmpl");
		
		//setup some default template vars.
		$this->templateObj->add_template_var('date', date('m-d-Y'));
		$this->templateObj->add_template_var('time', date('H:i:s'));
		
		$myUrl = '/';
		if(strlen($this->section) && $this->section !== 0) {
			$myUrl = '/'. $this->section;
		}
		$this->templateObj->add_template_var('CURRENT_URL', $myUrl);
		
		//create a fileSystem object.
		$this->fileSystemObj = new cs_fileSystemClass();
		
		//create a tabs object, in case they want to load tabs on the page.
		$this->tabs = new cs_tabs($this->templateObj);
		
		//check versions, make sure they're all the same.
		$myVersion = $this->get_version();
		if($this->templateObj->get_version() !== $myVersion) {
			throw new exception(__METHOD__ .": ". get_class($this->templateObj) ." has mismatched version (". $this->templateObj->get_version() ." does not equal ". $myVersion .")");
		}
		if($this->fileSystemObj->get_version() !== $myVersion) {
			throw new exception(__METHOD__ .": ". get_class($this->fileSystemObj) ." has mismatched version (". $this->fileSystemObj->get_version() ." does not equal ". $myVersion .")");
		}
		if($this->gfObj->get_version() !== $myVersion) {
			throw new exception(__METHOD__ .": ". get_class($this->gfObj) ." has mismatched version (". $this->gfObj->get_version() ." does not equal ". $myVersion .")");
		}
		if($this->tabs->get_version() !== $myVersion) {
			throw new exception(__METHOD__ .": ". get_class($this->tabs) ." has mismatched version (". $this->tabs->get_version() ." does not equal ". $myVersion .")");
		}
		
		//split apart the section so we can do stuff with it later.
		$this->parse_section();
		
		//get ready for when we have to load templates & such.
		$this->prepare();
	}//end initialize_locals()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	private function get_template_dirs() {
		if(is_array($this->sectionArr)) {
			$this->fileSystemObj->cd("/templates/". $this->baseDir);
			$retval = array();
			$retval[] = $this->fileSystemObj->cwd;
			foreach($this->sectionArr as $index=>$name) {
				if($this->fileSystemObj->cd($name)) {
					$retval[] = $this->fileSystemObj->cwd;
				}
				else {
					break;
				}
			}
		}
		else {
			throw new exception(__METHOD__ .": section array is invalid");
		}
		
		return($retval);
	}//end get_template_dirs()
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
							$redirectToUrl .= '?'. $destinationArg .'=/'. urlencode($_SERVER['REQUEST_URI']);
						}
						$this->gfObj->conditional_header($redirectToUrl, TRUE);
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
			$this->session = new cs_session;
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
		if($this->section === 0 || is_null($this->section) || !strlen($this->section)) {
			$this->section = "content/index";
		}
		$myArr = split('/', $this->section);
		
		//if we've got something in the array, keep going.
		if(is_array($myArr) && count($myArr) && ($myArr[0] !== 0)) {
			$this->baseDir = array_shift($myArr);
			$this->sectionArr = $myArr;
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
		if(!strlen($section)) {
			//TODO: remove the extra return statement (should only be one at the bottom of the method).
			return(NULL);
		}
		else {
			//check the string to make sure it doesn't begin or end with a "/"
			if($section[0] == '/') {
				$section = substr($section, 1, strlen($section));
			}
	
			//check the last char for a "/"...
			if($section[strlen($section) -1] == '/') {
				//last char is a '/'... kill it.
				$section = substr($section, 0, strlen($section) -1);
			}
	
			//if we've been sent a query, kill it off the string...
			if(preg_match('/\?/', $section)) {
				$section = split('\?', $section);
				$section = $section[0];
			}
	
			if(ereg("\.", $section)) {
				//disregard file extensions, but keep everything else...
				//	i.e. "index.php/yermom.html" becomes "index/yermom"
				$tArr = split('/', $section);
				foreach($tArr as $tSecName) {
					$temp = split("\.", $tSecName);
					if(strlen($temp[0]) > 1) {
						$tSecName = $temp[0];
					}
					$tSection = $this->gfObj->create_list($tSection, $tSecName, '/');
				}
				$section = $tSection;
			}
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
		if($this->fileSystemObj->cd('/includes')) {
			$this->load_includes();
		}
		$foundIncludes = count($this->includesList);
		
		//cd() in to the templates directory.
		$cdResult = $this->fileSystemObj->cd('/templates');
		$validatePageRes = $this->validate_page();
		if($foundIncludes || ($cdResult && $validatePageRes)) {
			
			//okay, get template directories & start loading
			$tmplDirs = $this->get_template_dirs();
			
			$this->load_shared_templates();
			foreach($tmplDirs as $myPath) {
				//load shared templates.
				$this->load_shared_templates($myPath);
			}
			
			//load templates for the main section.
			$this->load_main_templates();
			
			//load templates for the page.
			$this->load_page_templates();
			
			//now cd() all the way back.
			$this->fileSystemObj->cd('/');
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
		$valid = FALSE;
		//if we've got a non-basedir page, (instead of "/whatever", we have "/whatever/x"), see
		//	if there are templates that make it good... or just check the base template.
		if((count($this->sectionArr) > 0) && !((count($this->sectionArr) == 1) && ($this->sectionArr[0] == 'index'))) {
			//got more than just a baseDir url... see if the template is good.
			$finalLink = $this->gfObj->string_from_array($this->sectionArr, NULL, '/');
			$this->fileSystemObj->cd($this->baseDir);
			$mySectionArr = $this->sectionArr;
			$finalSection = array_pop($mySectionArr);
			$this->finalSection = $finalSection;
			if(count($mySectionArr) > 0) {
				foreach($mySectionArr as $dir) {
					if(!$this->fileSystemObj->cd($dir)) {
						break;
					}
				}
			}
			
			//check for the file & the directory...
			$indexFilename = $finalSection ."/index.content.tmpl";
			if(!strlen($finalSection)) {
				$indexFilename = 'index.content.tmpl';
			}
			
			$lsDir  = $this->fileSystemObj->ls($indexFilename);
			$lsDirVals = array_values($lsDir);
			$lsFile = $this->fileSystemObj->ls("$finalSection.content.tmpl");
			
			if(is_array(array_values($lsFile)) && is_array($lsFile[$finalSection .".content.tmpl"])) {
				//it's the file ("{finalSection}.content.tmpl", like "mySection.content.tmpl")
				$myIndex = $finalSection .".content.tmpl";
			}
			elseif(is_array(array_values($lsDir)) && (is_array($lsDir[$indexFilename]))) {
				$myIndex = $indexFilename;
			}
			else {
				//nothin' doin'.
				$myIndex = NULL;
			}
			
			//check the index file for validity... this is kind of a dirty hack... but it works.
			$checkMe = $this->fileSystemObj->ls($myIndex);
			if(!is_array($checkMe[$myIndex])) {
				unset($myIndex);
			}
			
			if(isset($myIndex)) {
				$valid = TRUE;
				$this->fileSystemObj->cd('/templates');
			}
			else {
				$this->reason = __METHOD__ .": couldn't find page template for ". $this->section;
			}
		}
		else {
			//if the baseDir is "help", this would try to use "/help/index.content.tmpl"
			$myFile = $this->baseDir .'/index.content.tmpl';
			$sectionLsData = $this->fileSystemObj->ls($myFile);
			
			//if the baseDir is "help", this would try to use "/help.content.tmpl"
			$sectionFile = $this->baseDir .'.content.tmpl';
			$lsData = $this->fileSystemObj->ls();
			
			if(isset($lsData[$sectionFile]) && is_array($lsData[$sectionFile])) {
				$valid = TRUE;
				$this->finalSection = $this->baseDir;
			}
			elseif(isset($sectionLsData[$myFile]) && $sectionLsData[$myFile]['type'] == 'file') {
				//we're good.
				$valid = TRUE;
				$this->finalSection = $this->baseDir;
			}
			else {
				$this->reason = __METHOD__ .": couldn't find base template.";
			}
		}
		$this->isValid = $valid;
		
		return($valid);
	}//end validate_page()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Loads the templates for the current page (performs template inheritance, too).
	 */
	private function load_page_templates() {
		//should already be in the proper directory, start looping through sectionArr,
		//	looking for templates.
		$mySectionArr = $this->sectionArr;
		
		$finalSection = $this->sectionArr[(count($this->sectionArr) -1)];
		foreach($mySectionArr as $index=>$value) {
			$tmplList = $this->arrange_directory_contents('name', 'section');
			if(isset($tmplList[$value])) {
				foreach($tmplList[$value] as $mySection=>$myTmpl) {
					// 
					$this->templateList[$mySection] = $myTmpl;
				}
			}
			if(!$this->fileSystemObj->cd($value)) {
				break;
			}
		}
		
		//load the final template(s).
		$finalTmplList = $this->arrange_directory_contents('name', 'section');
		if(isset($finalTmplList[$finalSection])) {
			foreach($finalTmplList[$finalSection] as $mySection => $myTmpl) {
				$this->templateList[$mySection] = $myTmpl;
			}
		}
		elseif(is_array($finalTmplList)) {
			foreach($finalTmplList as $mySection => $subArr) {
				foreach($subArr as $internalSection => $myTmpl) {
					$this->templateList[$mySection] = $myTmpl;
				}
			}
		}
		if($this->fileSystemObj->cd($finalSection)) {
			//load the index stuff.
			$tmplList = $this->arrange_directory_contents('name', 'section');
			if(isset($tmplList['index'])) {
				foreach($tmplList['index'] as $mySection => $myTmpl) {
					$this->templateList[$mySection] = $myTmpl;
				}
			}
			if(isset($tmplList[$this->baseDir]['content'])) {
				//load template for the main page (if $this->baseDir == "help", this would load "/help.content.tmpl" as content)
				$this->templateList['content'] = $tmplList[$this->baseDir]['content'];
			}
		}
	}//end load_page_templates()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * loads templates for the main section they're on.
	 */
	private function load_main_templates() {
		$this->fileSystemObj->cd('/templates');
		//check to see if the present section is valid.
		$this->fileSystemObj->cd($this->baseDir);
		$dirContents = $this->arrange_directory_contents('name', 'section');
		if(is_array($dirContents)) {
			foreach($dirContents as $mySection => $subArr) {
				foreach($subArr as $subIndex=>$templateFilename) {
					$this->templateList[$mySection] = $templateFilename;
				}
			}
		}
	}//end load_main_templates()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Loads any shared templates: these can be overwritten later.
	 */
	private function load_shared_templates($path=NULL) {
		
		if(!is_null($path)) {
			$this->fileSystemObj->cd($path);
		}
		else {
			$this->fileSystemObj->cd('/templates');
		}
		
		//pull a list of the files.
		$dirContents = $this->arrange_directory_contents();
		if(count($dirContents['shared'])) {
			
			foreach($dirContents['shared'] as $section => $template) {
				$this->templateList[$section] = $template;
			}
		}
	}//end load_shared_templates()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Pulls a list of files in the current directory, & arranges them by section & 
	 * 	name, or vice-versa.
	 */
	private function arrange_directory_contents($primaryIndex='section', $secondaryIndex='name') {
		$directoryInfo = $this->fileSystemObj->ls();
		$arrangedArr = array();
		if(is_array($directoryInfo)) {
			foreach($directoryInfo as $index=>$data) {
				$myType = $data['type'];
				if(($myType == 'file') && !in_array($index, $this->ignoredList[$myType])) {
					$filename = $this->gfObj->create_list($this->fileSystemObj->cwd, $index, '/');
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
		if(($this->fileSystemObj->cd($this->baseDir)) && is_array($this->sectionArr) && count($this->sectionArr) > 0) {
			
			foreach($this->sectionArr as $mySection) {
				//Run includes.
				$this->load_dir_includes($mySection);
				
				//attempt to cd() into the next directory, or die if we can't.
				if(!$this->fileSystemObj->cd($mySection)) {
					//no dice.  Break the loop.
					break;
				}
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
		$lsData = $this->fileSystemObj->ls();
		
		//attempt to load the shared includes file.
		if(isset($lsData['shared.inc']) && $lsData['shared.inc']['type'] == 'file') {
			$this->includesList[] = $this->fileSystemObj->realcwd .'/shared.inc';
		}
		
		//attempt to load the section's includes file.
		$myFile = $section .'.inc';
		if(isset($lsData[$myFile]) && $lsData[$myFile]['type'] == 'file') {
			$this->includesList[] = $this->fileSystemObj->realcwd .'/'. $myFile;
		}
		
		if(isset($lsData[$section]) && !count($this->sectionArr)) {
			$this->fileSystemObj->cd($section);
			$lsData = $this->fileSystemObj->ls();
			if(isset($lsData['index.inc'])) {
				$this->includesList[] = $this->fileSystemObj->realcwd .'/index.inc';
			}
		}
	}//end load_dir_includes()
	//------------------------------------------------------------------------
	
	
	
	//------------------------------------------------------------------------
	/**
	 * Called when something is broken.
	 */
	private function die_gracefully($details=NULL) {
		header('HTTP/1.0 404 Not Found');
		if($this->templateObj->template_file_exists('system/404.shared.tmpl')) {
			//Simple "Page Not Found" error... show 'em.
			$this->templateObj->add_template_var('main', $this->templateObj->file_to_string('system/404.shared.tmpl'));
			$this->templateObj->add_template_var('details', $details);
			$this->templateObj->add_template_var('datetime', date('m-d-Y H:i:s'));
			$this->templateObj->print_page();
			exit;
		}
		else {
			//TODO: make it *actually* die gracefully... the way it works now looks more like puke than grace.
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
		
		$page =& $this->templateObj;
		if(is_object($this->session)) {
			$page->session =& $this->session;
		}
		
		
		//if we loaded an index, but there is no "content", then move 'em around so we have content.
		if(isset($this->templateList['index']) && !isset($this->templateList['content'])) {
			$this->templateList['content'] = $this->templateList['index'];
			unset($this->templateList['index']);
		}
		
		foreach($this->templateList as $mySection => $myTmpl) {
			$myTmpl = preg_replace("/\/\//", "/", $myTmpl);
			$page->add_template_file($mySection, $myTmpl);
		}
		unset($mySection);
		unset($myTmpl);
		
		//make the "final section" available to scripts.
		$finalSection = $this->finalSection;
		$sectionArr = $this->sectionArr;
		array_unshift($sectionArr, $this->baseDir);
		$finalURL = $this->gfObj->string_from_array($sectionArr, NULL, '/');
		
		//now include the includes scripts, if there are any.
		if(is_array($this->includesList) && count($this->includesList)) {
			try {
				foreach($this->includesList as $myInternalIndex=>$myInternalScriptName) {
					$this->myLastInclude = $myInternalScriptName;
					include_once($this->myLastInclude);
				}
			}
			catch(exception $e) {
				$myRoot = preg_replace('/\//', '\\\/', $this->fileSystemObj->root);
				$displayableInclude = preg_replace('/^'. $myRoot .'/', '', $this->myLastInclude);
				$this->templateObj->set_message_wrapper(array(
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
		
		if(is_bool($this->templateObj->allow_invalid_urls() === TRUE) && $this->isValid === FALSE) {
			$this->isValid = $this->templateObj->allow_invalid_urls();
		}
		
		if($this->isValid === TRUE) {
			$page->print_page();
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
	
	
}//end contentSystem{}
?>