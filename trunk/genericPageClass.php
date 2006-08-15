<?php
/*
 * FILE INFORMATION:
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */
require_once("template.inc");
class GenericPage {
	var $sess0ionObj;					//session_class object to manage our sessin variables
	var $templateObj;					//template object to parse the pages
	var $templateVars	= array();	//our copy of the global templateVars
	var $mainTemplate;				//the default layout of the site
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * The constructor.
	 */
	public function __construct($restrictedAccess=TRUE, $mainTemplateFile=NULL) {
		//initialize some internal stuff.
		$this->initialize_locals($mainTemplateFile);
		
		//if they need to be logged-in... 
		$this->check_login($restrictedAccess);
	}//end __construct()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Initializes some internal objects, variables, and so on.
	 */
	protected function initialize_locals($mainTemplateFile) {
		
		//NOTE: this **requires** that the global variable "SITE_ROOT" is already set.
		$GLOBAL['TMPLDIR'] = $GLOBALS['SITE_ROOT'] .'/templates';
		$GLOBAL['LIBDIR'] = $GLOBALS['SITE_ROOT'] .'/lib';
		
		//if there have been some global template vars (or files) set, read 'em in here.
		if(is_array($GLOBALS['templateVars']) && count($GLOBALS['templateVars'])) {
			foreach($GLOBALS['templateVars'] as $key=>$value) {
				$this->add_template_var($key, $value);
			}
		}
		if(is_array($GLOBALS['templateFiles'])) {
			foreach($GLOBALS['templateFiles'] as $key => $value) {
				$this->templateFiles[$key] = $value;
			}
		}
		unset($GLOBALS['templateVars'], $GLOBALS['templateFiles']);
		
		//build a new instance of the template library (from PHPLib).
		$this->templateObj=new Template($GLOBALS['TMPLDIR'],"keep"); //initialize a new template parser

		//Create a new Session{} object: need the session primarily for set_message() functionality.
		$this->sessionObj = new Session(1);		//initialize a new session object
		$this->uid = $this->sessionObj->uid;
		
		if(preg_match('/^\//', $mainTemplateFile)) {
			$mainTemplateFile = $GLOBALS['TMPLDIR'] ."/". $mainTemplateFile;
		}
		$this->mainTemplate=$mainTemplateFile; //load the default layout
		$this->add_template_var("PHPSESSID", $this->sessionObj->sid);
	}//end initialize_locals()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function check_login($restrictedAccess) {
		if($restrictedAccess) {
			$myUri = $_SERVER['SCRIPT_NAME'];
			$doNotRedirectArr = array('/login.php', '/admin/login.php', '/index.php', '/admin.php',
				'/content', '/content/index.php'
			);
			$myGetArr = $_GET;
			if(is_array($myGetArr) && count($myGetArr) > 0) {
				unset($myGetArr['PHPSESSID']);
				$myUrlString = string_from_array($myGetArr, NULL, 'url');
				$redirectHere = '/login.php?destination='. $myUrlString;
				
				//Not exitting after conditional_header() is... bad, m'kay?
				conditional_header($redirectHere);
				exit;
			}
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

		$reg = "/<!-- BEGIN $handle -->.+<!-- END $handle -->/sU";
		preg_match_all($reg, $str, $m);
		if(!is_string($m[0][0])) {
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
		if(!isset($b) OR !isset($e)){
			$b="{";
			$e="}";
		}

		foreach($repArr as $key=>$value) {
			//run the replacements.
			$key = "$b" . $key . "$e";
			$template = str_replace("$key", $value, $template);
		}

		return($template);
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
		//Show any available messages.
		$this->process_set_message();
		
		//Load the default page layout.
		$this->templateObj->set_file("main", $this->mainTemplate);

		//load the placeholder names and thier values
		$this->templateObj->set_var($this->templateVars);
		$this->templateObj->parse("out","main"); //parse the sub-files into the main page
		if($stripUndefVars) {
			preg_match_all('/\{.*?\}/', $this->templateObj->varvals[out], $tags);
			$tags = $tags[0];
			foreach($tags as $key=>$str) {
				$str2 = str_replace("{", "", $str);
				$str2 = str_replace("}", "", $str2);
				if(!$this->templateVars[$str2]) {
					$this->templateObj->varvals[out] = str_replace($str, "$debug", $this->templateObj->varvals[out]);
				}
			}
		}
		$this->templateObj->pparse("out","out"); //parse the main page 
		
	}//end of print_page()
	//---------------------------------------------------------------------------------------------



	//---------------------------------------------------------------------------------------------
	/**
	 * Handles a message that was set into the session.
	 */
	public function process_set_message() {
		//if there's not a message set, skip.
		$errorBox = $this->file_to_string("system/message_box.tmpl");
		if($this->sessionObj->sid_check == "-1") {
			//need to set a message saying the session has expired.  No session is 
			//	available anymore, so we have to do this manually... GRAB THE ASTROGLIDE!!!
			$this->change_content($errorBox);

			//setup the message...
			$msg = "For your protection, your session has been expired.<BR>\nPlease re-login.<BR>\n";

			//drop all the proper variables into place.
			$this->add_template_var("title", "Session Expired");
			$this->add_template_var("message", $msg);
			$this->add_template_var("redirect", "<a href='login.php'>Solve this problem.</a>");
			$this->add_template_var("messageType", "fatal");
		} elseif(is_array($_SESSION['message'])) {
			//let's make sure the "type" value is *lowercase*.
			$_SESSION['message']['type'] = strtolower($_SESSION['message']['type']);

			//WARNING::: if you give it the wrong type, it'll STILL be parsed. Otherwise 
			//	this has to match set_message() FAR too closely. And it's a pain.
			foreach($_SESSION['message'] as $myVarName => $myVarVal) {
				$errorBox = $this->mini_parser($errorBox, $_SESSION['message'], '{', '}');
			}
			if($_SESSION['message']['type'] == "fatal") {
				//replace content of the page with our error.
				$this->change_content($errorBox);
			} else {
				//Non-fatal: put it into a template var.
				$this->add_template_var("error_msg", $errorBox);
			}
		} 

		//now that we're done displaying the message, let's get it out of the session (otherwise
		//	they'll never get past this point).
		unset($_SESSION['message']);
	}//end of process_set_message()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Takes a template file, whose root must be within $GLOBALS['TMPLDIR'], pulls it's 
	 * content & returns it.
	 */
	private function file_to_string($templateFileName) {
		$templateFileName = preg_replace('/\/\//', '\/', $templateFileName);
		if($this->template_file_exists($templateFileName)) {
			$retval = file_get_contents($GLOBALS['TMPLDIR'] .'/'. $templateFileName);
		} else {
			$this->set_message_wrapper(array(
				"title"		=> 'Template File Error',
				"message"	=> 'Not all templates could be found for this page.',
				"type"		=> 'error'
			));
		}
	}//end file_to_string()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Checks to see if the given filename exists within the template directory.
	 */
	protected function template_file_exists($file) {
		$retval = 0;
		//If the string doesn't start with a /, add one
		if (strncmp("/",$file,1)) {
			//strncmp returns 0 if they match, so we're putting a / on if they don't
			$file="/".$file;
		}
		$filename=$GLOBALS['TMPLDIR'].$file;
		
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
			$arrayKeys = array_keys();
			$type = $arrayKeys[0];
		}
		
		$retval = FALSE;
		//make sure the message type is IN the priority array...
		if(!in_array($type, array_keys($priorityArr))) {
			//invalid type.
			$retval = FALSE;
		} elseif($_SESSION['message']) {
			//there's already a message... check if the new one should overwrite the existing.
			if((!$overwriteSame) AND ($priorityArr[$_SESSION['message']['type']] == $priorityArr[$type])) {
				//no overwriting.
				$retval = 0;
			} elseif($priorityArr[$_SESSION['message']['type']] <= $priorityArr[$type]) {
				// the existing message is less important.  Overwrite it.
				unset($_SESSION['message']);
			}
		}
	
		//Create the array.
		$_SESSION["message"] = array(
			"title"		=> $title,
			"message"	=> $message,
			"linkURL"	=> $linkURL,
			"linkText"	=> $linkText,
			"type"		=> $type,
			"priority"	=> $priority
			
		);
	
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
	function conditional_header($url) {
		//checks to see if headers were sent; if yes: use a meta redirect.
		//	if no: send header("location") info...
		if(headers_sent()) {
			//headers sent.  Use the meta redirect.
			print "
			<HTML>
			<HEAD>
			<TITLE>Redirect Page</TITLE>
			<META HTTP-EQUIV='refresh' content='0; URL=$url'>
			</HEAD>
			<a href=\"$url\"></a>
			</HTML>
			";
		}
		else {
			header("location:$url");
		}
	}//end conditional_header()
	//---------------------------------------------------------------------------------------------

}
?>
