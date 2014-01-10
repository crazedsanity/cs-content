<?php
/*
 * Created on Jan 13, 2009
 */


require_once(dirname(__FILE__) .'/../__autoload.php');

//=============================================================================
class TestOfSession extends PHPUnit_Framework_TestCase {
	
	//-------------------------------------------------------------------------
	function __construct() {
		
		$this->gfObj = new cs_globalFunctions;
		
		$filesDir = dirname(__FILE__) ."/files";
		if(!defined('TEST_FILESDIR')) {
			define('TEST_FILESDIR', $filesDir);
		}
	}//end __construct()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_instantiation() {
		new cs_session();
	}
	//-------------------------------------------------------------------------
	
	
}//end TestOfCSContent
//=============================================================================
?>
