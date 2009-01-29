<?php
/*
 * Created on Jan 29, 2009
 * 
 * FILE INFORMATION:
 * 
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */

require_once(dirname(__FILE__) ."/../../cs-versionparse/cs_version.abstract.class.php");


abstract class cs_contentAbstract extends cs_versionAbstract {
	
	//-------------------------------------------------------------------------
    function __construct($makeGfObj=true) {
		$this->set_version_file_location(dirname(__FILE__) . '/../VERSION');
		$this->get_version();
		$this->get_project();
		
		if($makeGfObj === true) {
			//make a cs_globalFunctions{} object.
			require_once(dirname(__FILE__) ."/../cs_globalFunctions.php");
			$this->gfObj = new cs_globalFunctions();
		}
    }//end __construct()
	//-------------------------------------------------------------------------
	
	
	
}
?>