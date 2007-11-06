<?php
/*
 * FILE INFORMATION:
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */

require_once(dirname(__FILE__) ."/cs_versionAbstract.class.php");

class cs_session extends cs_versionAbstract {

	protected $db;
	public $uid;
	public $sid;
	public $sid_check = 1;
	
	//---------------------------------------------------------------------------------------------
	function __construct($createSession=1) {
		if($createSession) {
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
	public function is_authenticated() {
		return(FALSE);
	}//end is_authenticated()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function get_cookie($name) {
		$retval = NULL;
		if(isset($_COOKIE) && $_COOKIE[$name]) {
			$retval = $_COOKIE[$name];
		}
		return($retval);
	}//end get_cookie()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
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
	public function drop_cookie($name) {
		if(isset($_COOKIE[$name])) {
			setcookie($name, $_COOKIE[$name], time() -10000, '/');
			unset($_COOKIE[$name]);
		}
	}//end drop_cookie()
	//---------------------------------------------------------------------------------------------


}//end cs_session{}
?>