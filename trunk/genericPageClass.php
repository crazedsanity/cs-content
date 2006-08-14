<?php
require_once("template.inc");
class GenericPage {
	var $session;		//session_class object to manage our sessin variables
	var $db;		//db object to provide access to the database
	var $template;		//template object to parse the pages
	var $templateVars	= array();	//our copy of the global templateVars
	var $templateFiles	= array();	//our copy of the global templateFiles
	var $mainTemplate;	//the default layout of the site
	var $tabList;		//list of tabs to display on this page
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * The constructor.
	 */
	function __construct($restrictedAccess=TRUE, $logPageView=TRUE, $mainTemplateFile=NULL) {
		//initialize some internal stuff.
		$this->initialize_locals($mainTemplateFile, $logPageView);
		
		//if they need to be logged-in... 
		$this->check_login($restrictedAccess);
		
		//check if they're in an administrative area, and if they *should* be in that area.
		$this->check_admin_access();
	}//end __construct()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Initializes some internal objects, variables, and so on.
	 */
	protected function initialize_locals($mainTemplateFile, $logPageView) {
		
		//NOTE: this **requires** that the global variable "SITE_ROOT" is already set.
		$GLOBAL['TMPLDIR'] = $GLOBALS['SITE_ROOT'] .'/templates';
		$GLOBAL['LIBDIR'] = $GLOBALS['SITE_ROOT'] .'/lib';
		
		//if there have been some global template vars (or files) set, read 'em in here.
		if(is_array($GLOBALS['templateVars']) && count($GLOBALS['templateVars'])) {
			foreach($GLOBALS['templateVars'] as $key=>$value) {
				$this->templateVars[$key] = $value;
			}
		}
		if(is_array($GLOBALS['templateFiles'])) {
			foreach($GLOBALS['templateFiles'] as $key => $value) $this->templateFiles[$key] = $value;
		}
		
		//build a new instance of the template library (from PHPLib).
		$this->template=new template($GLOBALS['TMPLDIR'],"keep"); //initialize a new template parser
		$this->db= new phpDB;  				 //initialize a new database connection
		#$connID = $this->db->connect();

		//Create a new Session{} object: need the session primarily for set_message() functionality.
		$this->session=new Session($this->db);		//initialize a new session object
		$this->uid = $this->session->uid;
		
		$this->mainTemplate=$mainTemplateFile; //load the default layout
		$this->add_template_var("PHPSESSID", $this->session->sid);
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
	 * Appends data to the given section.
	 */
	public function add_content($htmlString,$section="content"){
		$this->templateVars[$section] .= $htmlString;
	}//end add_content()
	//---------------------------------------------------------------------------------------------




	//---------------------------------------------------------------------------------------------
	/**
	 * Adds a template file (with the given handle) to be parsed.
	 * 
	 * TODO: check if $fileName exists before blindly trying to parse it.
	 */
	public function add_template_file($handleName, $fileName){
		$this->add_template_var($handleName, html_file_to_string($fileName));
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
	function mini_parser($template, $repArr, $b='%%', $e='%%') {
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
	function print_page($stripUndefVars=1) {
		//Show any available messages.
		$this->process_set_message();
		
		//Load the default page layout.
		$this->template->set_file("main", $this->mainTemplate);

		if(is_array($this->templateFiles)) {
			//do we have additional template files to load?
			$this->template->set_file($this->templateFiles);
		}
		
		//load the placeholder names and thier values
		$this->template->set_var($this->templateVars);
		if(is_array($this->templateFiles)) {
   			//do we have additional template files to parse?
			foreach($this->templateFiles as $name=>$value) {
				$this->template->parse($name,$name);
			}
		}
		$this->template->parse("out","main"); //parse the sub-files into the main page
		if($stripUndefVars) {
			preg_match_all('/\{.*?\}/', $this->template->varvals[out], $tags);
			$tags = $tags[0];
			foreach($tags as $key=>$str) {
				$str2 = str_replace("{", "", $str);
				$str2 = str_replace("}", "", $str2);
				if(!$this->templateVars[$str2]) {
					//$debug = "<!-- ***** killed $str ***** -->";
					$this->template->varvals[out] = str_replace($str, "$debug", $this->template->varvals[out]);
				}
			}
		}
		$this->template->pparse("out","out"); //parse the main page 
		$this->db->close();
		
	}//end of print_page()
	//---------------------------------------------------------------------------------------------



	//---------------------------------------------------------------------------------------------
	/**
	 * Handles a message that was set into the session.
	 */
	function process_set_message() {
		//if there's not a message set, skip.
		$errorBox = html_file_to_string("system/message_box.tmpl");
		if($this->session->sid_check == "-1") {
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

}
?>
