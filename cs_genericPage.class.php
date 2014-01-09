<?php

class cs_genericPage extends cs_version {
	public $templateVars	= array();		//our copy of the global templateVars
	public $templateFiles	= array();		//our list of template files...
	public $templateRows	= array();		//array of block rows & their contents.
	public $mainTemplate;					//the default layout of the site
	public $unhandledVars=array();
	public $printOnFinish=true;
	
	private $tmplDir;
	private $libDir;
	private $siteRoot;
	
	private $allowInvalidUrls=NULL;
	
	//---------------------------------------------------------------------------------------------
	/**
	 * The constructor.
	 */
	public function __construct($restrictedAccess=TRUE, $mainTemplateFile=NULL) {
		
		//initialize stuff from our parent...
		parent::__construct();
		
		//initialize some internal stuff.
		$this->initialize_locals($mainTemplateFile);
		
		//if they need to be logged-in... 
		$this->check_login($restrictedAccess);
		
		if(!defined('CS-CONTENT_SESSION_NAME')) {
			define("CS-CONTENT_SESSION_NAME", ini_get('session.name'));
		}
	}//end __construct()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Initializes some internal objects, variables, and so on.
	 */
	protected function initialize_locals($mainTemplateFile) {
		
		//replace multiple slashes with a single one to avoid confusing other logic...
		$mainTemplateFile = preg_replace('/(\/){2,}/', '/', $mainTemplateFile);
		
		$showMatches=array();
		$numMatches = preg_match_all('/\//', $mainTemplateFile, $showMatches);
		if($numMatches == 1 && preg_match('/^/', $mainTemplateFile)) {
			$mainTemplateFile = preg_replace('/^\//', '', $mainTemplateFile);
		}
		
		if(isset($mainTemplateFile) && strlen($mainTemplateFile) && is_dir(dirname($mainTemplateFile)) && dirname($mainTemplateFile) != '.') {
			$this->siteRoot = dirname($mainTemplateFile);
			if(preg_match('/\//', $this->siteRoot) && preg_match('/templates/', $this->siteRoot)) {
				$this->siteRoot .= "/..";
			}
		}
		elseif(defined('SITE_ROOT') && is_dir(constant('SITE_ROOT'))) {
			$this->siteRoot = constant('SITE_ROOT');
		}
		elseif(is_dir($_SERVER['DOCUMENT_ROOT'] .'/templates')) {
			$this->siteRoot = $_SERVER['DOCUMENT_ROOT'] .'/templates';
		}
		else {
			throw new exception(__METHOD__ .": cannot locate siteRoot from main template file (". $mainTemplateFile .")");
		}
		$fs = new cs_fileSystem(dirname(__FILE__));
		$this->siteRoot = $fs->resolve_path_with_dots($this->siteRoot);
		$this->tmplDir = $this->siteRoot .'/templates';
		if(defined('CS_TEMPLATE_BASE_DIR')) {
			$this->tmplDir = constant('CS_TEMPLATE_BASE_DIR');
		}
		$this->libDir = $this->siteRoot .'/lib';
		
		if(!is_dir($this->tmplDir)) {
			throw new exception(__METHOD__ .": invalid templates folder (". $this->tmplDir ."), siteRoot=(". $this->siteRoot .")");
		}
		
		//if there have been some global template vars (or files) set, read 'em in here.
		if(isset($GLOBALS['templateVars']) && is_array($GLOBALS['templateVars']) && count($GLOBALS['templateVars'])) {
			foreach($GLOBALS['templateVars'] as $key=>$value) {
				$this->add_template_var($key, $value);
			}
		}
		if(isset($GLOBALS['templateFiles']) && is_array($GLOBALS['templateFiles'])) {
			foreach($GLOBALS['templateFiles'] as $key => $value) {
				$this->templateFiles[$key] = $value;
			}
		}
		unset($GLOBALS['templateVars'], $GLOBALS['templateFiles']);

		if(!preg_match('/^\//', $mainTemplateFile)) {
			$mainTemplateFile = $this->tmplDir ."/". $mainTemplateFile;
		}
		$this->mainTemplate=$mainTemplateFile; //load the default layout
	}//end initialize_locals()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Should just check to see if they've authenticated.  In reality, this 
	 * just performs blind redirection if $restrictedAccess is set (and if 
	 * redirecting is allowed).
	 */
	public function check_login($restrictedAccess) {
		if($restrictedAccess) {
			$myUri = $_SERVER['SCRIPT_NAME'];
			$doNotRedirectArr = array('/login.php', '/admin/login.php', '/index.php', '/admin.php',
				'/content', '/content/index.php'
			);
			$myUrlString="";
			$myGetArr = $_GET;
			if(is_array($myGetArr) && count($myGetArr) > 0) {
				unset($myGetArr['PHPSESSID']);
				unset($myGetArr[CS-CONTENT_SESSION_NAME]);
				$myUrlString = string_from_array($myGetArr, NULL, 'url');
			}
			
			//TODO: make the redirectHere variable dynamic--an argument, methinks.
			
			$redirectHere = '/login.php?destination='. $myUrlString;
				
			//Not exitting after conditional_header() is... bad, m'kay?
			$this->conditional_header($redirectHere, TRUE);
			exit;
		}
	}//end check_login()
	//---------------------------------------------------------------------------------------------



	//---------------------------------------------------------------------------------------------
	/**
	 * Remove all data from the special template var "content" (or optionally another ver).
	 * 
	 * @param $section		(str,optional) defines what template var to wip-out.
	 * @return (NULL)
	 */
	public function clear_content($section="content"){  
		$this->change_content(" ",$section);
	}//end clear_content()
	//---------------------------------------------------------------------------------------------



	//---------------------------------------------------------------------------------------------
	/**
	 * Change the content of a template to the given data.
	 * 
	 * @param $htmlString			(str) data to use.
	 * @param $section				(str,optional) define a different section.
	 * 
	 * @return (NULL)
	 */
	public function change_content($htmlString,$section="content"){ 
		$this->templateVars[$section] = $htmlString;
	}//end change_content()
	//---------------------------------------------------------------------------------------------



	//---------------------------------------------------------------------------------------------
	/**
	 * Adds a template file (with the given handle) to be parsed.
	 * 
	 * TODO: check if $fileName exists before blindly trying to parse it.
	 */
	public function add_template_file($handleName, $fileName){
		$this->templateFiles[$handleName] = $fileName;
		$this->add_template_var($handleName, $this->file_to_string($fileName));
	}//end add_template_file()
	//---------------------------------------------------------------------------------------------



	//---------------------------------------------------------------------------------------------
	/**
	 * Adds a value for a template placeholder.
	 */
	public function add_template_var($varName, $varValue){
		$this->templateVars[$varName]=$varValue;
	}//end add_template_var();
	//---------------------------------------------------------------------------------------------



	//---------------------------------------------------------------------------------------------
	/**
	 * Rips the given block row name from the parent templateVar, (optionally) replacing it with 
	 * a template var of the same name.
	 * 
	 * @param $parent		(str) name of the templateVar to pull the block row from.
	 * @param $handle		(str) name of the block row to rip from it's parent.
	 * @param $removeDefs	(bool,optional) if evaluated as FALSE, no template var is left in
	 * 							place of the block row.
	 * 
	 * @return (bool false)	FAIL: unable to find block row.
	 * @return (str)		PASS: content of the block row.
	 */
	public function set_block_row($parent, $handle, $removeDefs=0) {
		$name = $handle;
		$str = $this->templateVars[$parent];

		$reg = "/<!-- BEGIN $handle -->(.+){0,}<!-- END $handle -->/sU";
		preg_match_all($reg, $str, $m);
		if(!is_array($m) || !isset($m[0][0]) ||  !is_string($m[0][0])) {
			#exit("set_block_row(): couldn't find '$handle' in var '$parent'");
			$retval = FALSE;
		} else {
			if($removeDefs) {
				$openHandle = "<!-- BEGIN $handle -->";
				$endHandle  = "<!-- END $handle -->";
				$m[0][0] = str_replace($openHandle, "", $m[0][0]);
				$m[0][0] = str_replace($endHandle, "", $m[0][0]);
			}
	
			$str = preg_replace($reg, "{" . "$name}", $str);
			$this->templateVars[$parent] = $str;
			$this->templateRows[$name] = $m[0][0];
			$this->add_template_var($name, "");
			$retval = $m[0][0];
		}
		return($retval);
	}//end set_block_row()
	//---------------------------------------------------------------------------------------------



	//---------------------------------------------------------------------------------------------
	/**
	 * Using the given template, it will replace each index (in $repArr) with it's value: each
	 * var to be replaced must begin the given begin & end delimiters.
	 * 
	 * @param $template		(str) Data to perform the replacements on.
	 * @param $repArr		(array) Array of name=>value pairs, where name is to be replaced with value.
	 * @param $b			(str,optional) beginning delimiter.
	 * @param $e			(str,optional) ending delimiter.
	 */
	public function mini_parser($template, $repArr, $b='%%', $e='%%') {
		return($this->gfObj->mini_parser($template, $repArr, $b, $e));
	}//end mini_parser()
	//---------------------------------------------------------------------------------------------



	//---------------------------------------------------------------------------------------------
	/**
	 * Processes all template vars & files, etc, to produce the final page.  NOTE: it is a wise idea
	 * for most pages to have this called *last*.
	 * 
	 * @param $stripUndefVars		(bool,optional) Remove all undefined template vars.
	 * 
	 * @return (str)				Final, parsed page.
	 */
	public function print_page($stripUndefVars=1) {
		$this->unhandledVars = array();
		//Show any available messages.
		$this->process_set_message();
		
		if(isset($this->templateVars['main'])) {
			//this is done to simulate old behaviour (the "main" templateVar could overwrite the entire main template).
			$out = $this->templateVars['main'];
		}
		else {
			$out = $this->file_to_string($this->mainTemplate);
		}
		if(!strlen($out)) {
			$this->gfObj->debug_print($out);
			$this->gfObj->debug_print($this->mainTemplate);
			$this->gfObj->debug_print("MANUAL FILE CONTENTS::: ". htmlentities(file_get_contents($this->mainTemplate)));
			exit(__METHOD__ .": mainTemplate (". $this->mainTemplate .") was empty...?");
		}
		
		$numLoops = 0;
		$tags = array();
		while(preg_match_all('/\{.\S+?\}/', $out, $tags) && $numLoops < 10) {
			$out = $this->gfObj->mini_parser($out, $this->templateVars, '{', '}');
			$numLoops++;
		}
		
		if($stripUndefVars) {
			$out = $this->strip_undef_template_vars($out, $this->unhandledVars);
		}
		
		print($out);
		
	}//end of print_page()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Returns a fully-parsed template.
	 */
	public function return_parsed_template($tmplVar, $stripUndefVars=1) {
		if(isset($this->templateVars[$tmplVar])) {
			$oldMd5 = md5(serialize($this->templateVars));
			$oldTemplateVars = $this->templateVars;
			$this->add_template_var('main', $this->templateVars[$tmplVar]);
			$retval = $this->return_printed_page($stripUndefVars);
			$this->templateVars = $oldTemplateVars;
			$newMd5 = md5(serialize($this->templateVars));
			if($oldMd5 !== $newMd5) {
				throw new exception(__METHOD__ .": old template vars don't match new...");
			}
		}
		else {
			throw new exception(__METHOD__ .": invalid template var (". $tmplVar .")");
		}
		return($retval);
	}//end return_parsed_template()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Handles a message that was set into the session.
	 */
	public function process_set_message() {
		//if there's not a message set, skip.
		$errorBox = "";
		if(isset($_SESSION['message']) && is_array($_SESSION['message'])) {
			$errorBox = $this->file_to_string("system/message_box.tmpl");
			//let's make sure the "type" value is *lowercase*.
			$_SESSION['message']['type'] = strtolower($_SESSION['message']['type']);
			
			//WARNING::: if you give it the wrong type, it'll STILL be parsed. Otherwise 
			//	this has to match set_message() FAR too closely. And it's a pain.
			$_SESSION['message']['messageType'] = $_SESSION['message']['type'];
			$errorBox = $this->gfObj->mini_parser($errorBox, $_SESSION['message'], '{', '}');
			if($_SESSION['message']['type'] == "fatal") {
				//replace content of the page with our error.
				$this->change_content($errorBox);
			} else {
				//Non-fatal: put it into a template var.
				$this->add_template_var("error_msg", $errorBox);
			}
	
			//now that we're done displaying the message, let's get it out of the session (otherwise
			//	they'll never get past this point).
			unset($_SESSION['message']);
		}
		return($errorBox);
	}//end of process_set_message()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Takes a template file, whose root must be within $GLOBALS['TMPLDIR'], pulls it's 
	 * content & returns it.
	 */
	public function file_to_string($templateFileName) {
		
		if(preg_match('/templates/', $templateFileName)) {
			$bits = explode('templates', $templateFileName);
			if(count($bits) == 2) {
				$templateFileName = $bits[1];
			}
			else {
				throw new exception(__METHOD__ .": full path to template file given but could not break the path into bits::: ". $templateFileName);
			}
		}
		$templateFileName = preg_replace('/\/\//', '\/', $templateFileName);
		$fullPathToFile = $this->template_file_exists($templateFileName);
		if($fullPathToFile !== false && strlen($fullPathToFile)) {
			$retval = file_get_contents($fullPathToFile);
		} else {
			$this->set_message_wrapper(array(
				"title"		=> 'Template File Error',
				"message"	=> 'Not all templates could be found for this page.',
				"type"		=> 'error'
			));
		}
		return($retval);
	}//end file_to_string()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Checks to see if the given filename exists within the template directory.
	 */
	public function template_file_exists($file) {
		$retval = false;
		//If the string doesn't start with a /, add one
		if (strncmp("/",$file,1)) {
			//strncmp returns 0 if they match, so we're putting a / on if they don't
			$file="/".$file;
		}
		$filename=$this->tmplDir.$file;
		
		if(file_exists($filename)) {
			$retval = $filename;
		} 
		return($retval);
	}//end template_file_exists()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Creates an array in the session, used by the templating system as a way to
	 * get messages generated by the code into the page, without having to add 
	 * special templates & such each time.
	 * 
	 * @param $title			(str) the title of the message.
	 * @param $message			(str) text beneath the title.
	 * @param $linkURL			(str,optional) URL for the link below the message.
	 * @param $type				(str) notice/status/error/fatal message, indicating
	 * 								it's importance.  Generally, fatal messages 
	 * 								cause only the message to be shown.
	 * @param $linkText			(str,optional) text that the link wraps.
	 * @param $overwriteSame	(bool,optional) whether setting a message which has
	 * 								the same type as an already set message will
	 * 								overwite the previous.  More important messages 
	 * 								always overwrite lesser ones.
	 * @param $priority			(int,optional) specify the message's priority.
	 * 
	 * @return (bool)			Indicates pass (true)/fail (false)
	 */
	function set_message($title=NULL, $message=NULL, $linkURL=NULL, $type=NULL, $linkText=NULL, $overwriteSame=NULL, $priority=NULL) {
		if(!isset($overwriteSame)) {
			$overwriteSame = 1;
		}
	
		//defines the importance level of each type of message: the higher the value, the more important it is.
		$priorityArr = array(
			'notice' => 10,
			'status' => 20,
			'error'  => 30,
			'fatal'  => 100
		);
		if(!isset($type) || !isset($priorityArr[$type])) {
			//set a default type.
			$arrayKeys = array_keys($priorityArr);
			$type = $arrayKeys[0];
		}
		
		if(strlen($linkURL)) {
			if(!strlen($linkText) || is_null($linkText)) {
				$linkText = "Link";
			}
			$redirectText = '<a href="'. $linkURL .'">'. $linkText .'</a>';
		}
		
		//Create the array.
		$myArr = array(
			"title"		=> $title,
			"message"	=> $message,
			"redirect"	=> $redirectText,
			"type"		=> $type,
			"priority"	=> $priority
			
		);
		
		//make sure the message type is IN the priority array...
		if(!in_array($type, array_keys($priorityArr))) {
			//invalid type.
			$retval = FALSE;
		} elseif($_SESSION['message']) {
			//there's already a message... check if the new one should overwrite the existing.
			if((!$overwriteSame) AND ($priorityArr[$_SESSION['message']['type']] == $priorityArr[$type])) {
				//no overwriting.
				$retval = FALSE;
			} elseif($priorityArr[$_SESSION['message']['type']] <= $priorityArr[$type]) {
				// the existing message is less important.  Overwrite it.
				$_SESSION['message'] = $myArr;
			}
		}
		else {
			$_SESSION['message'] = $myArr;
			$retval = TRUE;
		}
		
		return($retval);
		
	} // end of set_message()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function set_message_wrapper($array) {
		@$this->set_message(
			$array['title'], 
			$array['message'], 
			$array['linkURL'], 
			$array['type'], 
			$array['linkText'], 
			$array['overwriteSame'],
			$array['priority']
		);
	}//end set_message_wrapper()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Performs redirection, provided it is allowed.
	 */
	function conditional_header($url, $exitAfter=TRUE,$isPermRedir=FALSE) {
		$this->gfObj->conditional_header($url, $exitAfter, $isPermRedir);
	}//end conditional_header()
	//---------------------------------------------------------------------------------------------
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Given the name of a templateVar (defaults to "content"), this method will retrieve all block
	 * row definitions in the order that they can safely be ripped-out/set by set_block_row().
	 * 
	 * @parm $templateVar	(str,optional) templateVar to parse.
	 * 
	 * @return (array)		Contains all rows, complete & incomplete.
	 * 
	 * NOTE: Layout of array:::
	 * 	array(
	 * 		incomplete => array(
	 * 			begin	=> array(),
	 * 			end		=> array()
	 * 		),
	 * 		ordered	=> array()
	 * NOTE2: each "array()" above is a list of block row names.
	 * NOTE3: failure to parse the template will return a blank array.
	 * 
	 * 
	 */
	function get_block_row_defs($templateVar="content") {
		//cast $retArr as an array, so it's clean.
		$retArr = array();
		
		//NOTE: the value 30 isn't just a randomly chosen length; it's the minimum
		// number of characters to have a block row.  EG: "<!-- BEGIN x --><!-- END x -->"
		if(isset($this->templateVars[$templateVar]) && strlen($this->templateVars[$templateVar]) >= 30) {
			$templateContents = $this->templateVars[$templateVar];
			//looks good to me.  Run the regex...
			$flags = PREG_PATTERN_ORDER;
			$reg = "/<!-- BEGIN (\S{1,}) -->/";
			preg_match_all($reg, $templateContents, $beginArr, $flags);
			$beginArr = $beginArr[1];
			
			$endReg = "/<!-- END (\S{1,}) -->/";
			preg_match_all($endReg, $templateContents, $endArr, $flags);
			$endArr = $endArr[1];
			
			//create a part of the array that shows any orphaned "BEGIN" statements (no matching "END"
			// statement), and orphaned "END" statements (no matching "BEGIN" statements)
			// NOTE::: by doing this, should easily be able to tell if the block rows were defined
			// properly or not.
			if(count($retArr['incomplete']['begin'] = array_diff($beginArr, $endArr)) > 0) {
				//I'm sure there's an easier way to do this, but my head hurts too much when 
				// I try to do the magic.  Maybe I need to put another level in CodeMancer...
				foreach($retArr['incomplete']['begin'] as $num=>$val) {
					unset($beginArr[$num]);
				}
			}
			if(count($retArr['incomplete']['end'] = array_diff($endArr, $beginArr)) > 0) {
				//both of the below foreach's simply pulls undefined vars out of the
				// proper arrays, so I don't have to deal with them later.
				foreach($retArr['incomplete']['end'] as $num=>$val) {
					unset($endArr[$num]);
				}
			}
			
			//YAY!!! we've got valid data!!!
			//reverse the order of the array, so when the ordered array
			// is looped through, all block rows can be pulled.
			$retArr['ordered'] = array_reverse($beginArr);
		} else {
			//nothin' doin'.  Return a blank array.
			$retArr = array();
		}
		
		return($retArr);
	}//end get_block_row_defs()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	function rip_all_block_rows($templateVar="content", $exceptionArr=array(), $removeDefs=0) {
		$rowDefs = $this->get_block_row_defs($templateVar);
		
		
		$retval = array();
		
		if(is_array($rowDefs) && isset($rowDefs['ordered'])) {
			$useTheseBlockRows = $rowDefs['ordered'];
			if(is_array($useTheseBlockRows)) {
				foreach($useTheseBlockRows as $blockRowName)
				{
					if(!is_array($exceptionArr) || !in_array($blockRowName, $exceptionArr))
					{
						//remove the block row.
						$rowData = $this->set_block_row($templateVar, $blockRowName, $removeDefs);
						$retval[$blockRowName] = $rowData;
					}
				}
			}
		}
		
		return($retval);
	}//end rip_all_block_rows()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function set_all_block_rows($templateVar="content", $exceptionArr=array(), $removeDefs=0)
	{
		$retval = $this->rip_all_block_rows($templateVar, $exceptionArr, $removeDefs);
		return($retval);
	}//end set_all_block_rows()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function allow_invalid_urls($newSetting=NULL) {
		if(!is_null($newSetting) && is_bool($newSetting)) {
			$this->allowInvalidUrls = $newSetting;
		}
		return($this->allowInvalidUrls);
	}//end allow_invalid_urls()
	//---------------------------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function return_printed_page($stripUndefVars=1) {
		ob_start();
		$this->print_page($stripUndefVars);
		$retval = ob_get_contents();
		ob_end_clean();
		return($retval);
	}//end return_printed_page()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function strip_undef_template_vars($templateContents, array &$unhandled=null) {
		$numLoops = 0;
		while(preg_match_all('/\{.\S+?\}/', $templateContents, $tags) && $numLoops < 50) {
			$tags = $tags[0];
			
			//TODO: figure out why this works when running it twice.
			foreach($tags as $key=>$str) {
				$str2 = str_replace("{", "", $str);
				$str2 = str_replace("}", "", $str2);
				if(!isset($this->templateVars[$str2])) {
					//TODO: set an internal pointer or something to use here, so they can see what was missed.
					if(is_array($unhandled)) {
						if(!isset($unhandled[$str2])) {
							$unhandled[$str2]=0;
						}
						$unhandled[$str2]++;
					}
					$templateContents = str_replace($str, '', $templateContents);
				}
			}
			$numLoops++;
		}
		return($templateContents);
	}//end strip_undef_template_vars()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function strip_undef_template_vars_from_section($section='content') {
		if(isset($this->templateVars[$section])) {
			//rip out undefined vars from the contents of the given section.
			$this->templateVars[$section] = $this->strip_undef_template_vars($this->templateVars[$section]);
		}
		else {
			throw new exception(__METHOD__ .": section (". $section .") does not exist");
		}
		
		return($this->templateVars[$section]);
	}//strip_undef_template_vars_from_section()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Magic PHP method for retrieving the values of private/protected vars.
	 */
	public function __get($var) {
		return(@$this->$var);
	}//end __get()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Magic PHP method for changing the values of private/protected vars (or 
	 * creating new ones).
	 */
	public function __set($var, $val) {
		
		//TODO: set some restrictions on internal vars...
		$this->$var = $val;
	}//end __set()
	//-------------------------------------------------------------------------

}//end cs_genericPage{}
?>
