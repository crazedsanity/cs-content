<?php
/*
 * FILE INFORMATION:
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */

require_once(dirname(__FILE__) ."/../cs-versionparse/cs_version.abstract.class.php");

class cs_session extends cs_versionAbstract {

	protected $db;
	public $uid;
	public $sid;
	public $sid_check = 1;
	
	//---------------------------------------------------------------------------------------------
	/**
	 * The constructor.
	 * 
	 * @param $createSession	(mixed,optional) determines if a session will be started or not; if
	 * 								this parameter is non-null and non-numeric, the value will be 
	 * 								used as the session name.
	 */
	function __construct($createSession=1) {
		$this->set_version_file_location(dirname(__FILE__) . '/VERSION');
		if($createSession) {
			if(!is_null($createSession) && strlen($createSession) && !is_numeric($createSession)) {
				session_name($createSession);
			}
			
			//now actually create the session.
			session_start();
		}
		
		//check if there's a uid in the session already.
		//TODO: need a setting somewhere that says what the name of this var should be,
		//	instead of always forcing "uid".
		$this->uid = 0;
		if($_SESSION['uid']) {
			$this->uid = $_SESSION['uid'];
		}
		
		//grab what our session_id is...
		$this->sid = session_id();
		
	}//end __construct()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Required method, so passing the object to contentSystem::handle_session() 
	 * will work properly.
	 * 
	 * @param (none)
	 * 
	 * @return FALSE		FAIL: user is not authenticated (hard-coded this way).
	 */
	public function is_authenticated() {
		return(FALSE);
	}//end is_authenticated()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
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
		if(isset($_COOKIE) && $_COOKIE[$name]) {
			$retval = $_COOKIE[$name];
		}
		return($retval);
	}//end get_cookie()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Create a new cookie.
	 * 
	 * @param $name			(string) Name of cookie
	 * @param $value		(string) value of cookie
	 * @param $expiration	(string/number) unix timestamp or value for strtotime().
	 */
	public function create_cookie($name, $value, $expiration=NULL) {
		
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
		
		$retval = setcookie($name, $value, $expTime, '/');
		return($retval);
		
	}//end create_cookie()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
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
	//---------------------------------------------------------------------------------------------


}//end cs_session{}
?>