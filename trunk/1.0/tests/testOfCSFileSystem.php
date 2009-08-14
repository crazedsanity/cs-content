<?php
/*
 * Created on Jan 13, 2009
 *
 * 
 * FILE INFORMATION:
 * 
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */



//=============================================================================
class TestOfCSFileSystem extends UnitTestCase {
	
	//-------------------------------------------------------------------------
	function __construct() {
		require_once(dirname(__FILE__) .'/../cs_globalFunctions.class.php');
		require_once(dirname(__FILE__) .'/../cs_fileSystem.class.php');
		
		$this->gfObj = new cs_globalFunctions;
		$this->gfObj->debugPrintOpt=1;
		
		$filesDir = dirname(__FILE__) ."/files";
		define('TEST_FILESDIR', $filesDir);
	}//end __construct()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	//-------------------------------------------------------------------------
	
	
	
}//end TestOfCSFileSystem
//=============================================================================
?>
