<?php

//=============================================================================
class TestOfCSTemplate extends UnitTestCase {
		
	//-------------------------------------------------------------------------
	function setUp() {
		cs_global::$debugPrintOpt = 1;
		cs_global::$debugRemoveHr = 0;
	}//end setUp()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function tearDown() {
		cs_global::$debugPrintOpt = 0;
	}//end tearDown()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_basic() {
		$baseDir = dirname(__FILE__) .'/files';
		$mainTemplate = $baseDir .'/templates/main.shared.tmpl';
		$template = new cs_template('file', $mainTemplate);
	}//end test_basic_rw()
	//-------------------------------------------------------------------------
	
	
	
}//end TestOfCSTemplate
//=============================================================================
?>
