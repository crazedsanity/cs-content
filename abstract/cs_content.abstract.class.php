<?php

abstract class cs_contentAbstract extends cs_versionAbstract {
	
	//-------------------------------------------------------------------------
	/**
	 * 
	 * @codeCoverageIgnore
	 */
    function __construct($makeGfObj=true) {
		$this->set_version_file_location(dirname(__FILE__) . '/../VERSION');
		$this->get_version();
		$this->get_project();
		
		if($makeGfObj === true) {
			//make a cs_globalFunctions{} object.
			$this->gfObj = new cs_globalFunctions();
		}
    }//end __construct()
	//-------------------------------------------------------------------------
	
	
	
}
?>