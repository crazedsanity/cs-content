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


}//end cs_session{}
?>