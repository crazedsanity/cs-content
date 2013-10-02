<?php
/*
 * Created on Jan 29, 2009
 */

require_once(dirname(__FILE__) .'/../cs_version.class.php');
abstract class cs_contentAbstract extends cs_version implements cs_versionInterface {
	
	static public $version;
	
	//-------------------------------------------------------------------------
    function __construct($makeGfObj=true) {
		
		if($makeGfObj === true) {
			//make a cs_globalFunctions{} object.
			$this->gfObj = new cs_globalFunctions();
		}
		
		parent::__construct();
    }//end __construct()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public static function GetVersionObject() {
		if(!is_object(self::$version)) {
			self::$version = new cs_version(dirname(__FILE__) .'/../VERSION');
		}
		return(self::$version);
	}//end GetVersionObject()
	//-------------------------------------------------------------------------
	
	
	
}
?>
