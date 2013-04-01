<?php
/*
 * FILE INFORMATION:
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */

class cs_session extends cs_contentAbstract {

	protected $uid;
	protected $sid;
	protected $sid_check = 1;
	
	//-------------------------------------------------------------------------
	/**
	 * The constructor.
	 * 
	 * @param $createSession	(mixed,optional) determines if a session will be started or not; if
	 * 								this parameter is non-null and non-numeric, the value will be 
	 * 								used as the session name.
	 */
	function __construct($createSession=true) {
		parent::__construct(true);
		$sessName = null;
		$sessionId = null;
		if($createSession) {
			if(is_string($createSession) && strlen($createSession) >2) {
				$sessName = $createSession;
				session_name($createSession);
			}
			elseif(defined('SESSION_NAME') && constant('SESSION_NAME') && isset($_COOKIE) && isset($_COOKIE[constant('SESSION_NAME')])) {
				$sessName = constant('SESSION_NAME');
				session_name(constant('SESSION_NAME'));
				$sessionId = $_COOKIE[constant('SESSION_NAME')];
				session_id($sessionId);
			}
			
			//now actually create the session.
			@session_start();
		}
		if(is_null($sessName)) {
			$sessName = session_name();
		}
		
		//check if there's a uid in the session already.
		//TODO: need a setting somewhere that says what the name of this var should be,
		//	instead of always forcing "uid".
		$this->uid = 0;
		if(isset($_SESSION['uid']) && $_SESSION['uid']) {
			$this->uid = $_SESSION['uid'];
		}
		
		//grab what our session_id is...
		$this->sid = session_id();
		
	}//end __construct()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Required method, so passing the object to contentSystem::handle_session() 
	 * will work properly.
	 * 
	 * @param (none)
	 * 
	 * @return FALSE		FAIL: user is not authenticated (hard-coded this way).
	 */
	public function is_authenticated() {
		return(isset($_SESSION['uid']) && strlen($_SESSION['uid']));
	}//end is_authenticated()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Retrieve data for an existing cookie.
	 * 
	 * @param $name		(string) Name of cookie to retrieve value for.
	 * 
	 * @return NULL		FAIL (?): cookie doesn't exist or has NULL value.
	 * @return (string)	PASS: value of cookie.
	 */
	public function get_cookie($name) {
		$retval = NULL;
		if(isset($_COOKIE) && isset($_COOKIE[$name])) {
			$retval = $_COOKIE[$name];
		}
		return($retval);
	}//end get_cookie()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Create a new cookie.
	 * 
	 * @param $name			(string) Name of cookie
	 * @param $value		(string) value of cookie
	 * @param $expiration	(string/number) unix timestamp or value for strtotime().
	 */
	public function create_cookie($name, $value, $expiration=NULL, $path=NULL, $domain=NULL) {
		
		$expTime = NULL;
		if(!is_null($expiration)) {
			if(is_numeric($expiration)) {
				$expTime = $expiration;
			}
			elseif(preg_match('/ /', $expiration)) {
				$expTime = strtotime($expiration);
			}
			else {
				throw new exception(__METHOD__ .": invalid timestamp given (". $expiration .")");
			}
		}
		
		if(is_null($domain)) {
			$bits = explode('.', $_SERVER['SERVER_NAME']);
			if(count($bits) > 1) {
				$tldBit = $bits[count($bits)-1];
				$domBit  = $bits[count($bits)];
				$domain = '.'. $domBit .'.'. $tldBit;
			}
		}
		
		$retval = setcookie($name, $value, $expTime, $path, $domain);
		return($retval);
		
	}//end create_cookie()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Destroy (expire) an existing cookie.
	 * 
	 * @param $name		(string) Name of cookie to destroy
	 * 
	 * @return FALSE	FAIL: no cookie by that name.
	 * @return TRUE		PASS: cookie destroyed.
	 */
	public function drop_cookie($name) {
		$retval = FALSE;
		if(isset($_COOKIE[$name])) {
			setcookie($name, $_COOKIE[$name], time() -10000, '/');
			unset($_COOKIE[$name]);
			$retval = TRUE;
		}
		return($retval);
	}//end drop_cookie()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * PHP5 magic method for retrieving the value of internal vars; this allows 
	 * code to find the value of these variables, but not modify them (modifying 
	 * requires the "__set($var,$val)" method).
	 */
	public function __get($var) {
		return($this->$var);
	}//end __get()
	//-------------------------------------------------------------------------


}//end cs_session{}
?>
