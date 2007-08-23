<?php
/*
 * FILE INFORMATION:
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */
class cs_session{

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
	/**
	 * Returns a version string.
	 */
	public function get_version($asArray=FALSE) {
		$version = array(
			'major'	=> 0,
			'minor'	=> 6
		);
		if($asArray) {
			$version = $this->gfObj->string_from_array($version, NULL, '.');
		}
		
		return($version);
	}//end get_version()
	//---------------------------------------------------------------------------------------------


}//end cs_session{}
?>