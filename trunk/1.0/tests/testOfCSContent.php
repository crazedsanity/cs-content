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
class TestOfCSContent extends UnitTestCase {
	
	//-------------------------------------------------------------------------
	function __construct() {
		
		$this->gfObj = new cs_globalFunctions;
		$this->gfObj->debugPrintOpt=1;
		
		$filesDir = dirname(__FILE__) ."/files";
		define('TEST_FILESDIR', $filesDir);
	}//end __construct()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function test_siteConfig() {
		$configFile = constant('TEST_FILESDIR') .'/sampleConfig.xml';
		$varPrefix = preg_replace("/:/", "_", __METHOD__ ."-");
		$sc = new cs_siteConfig($configFile, 'main', $varPrefix);
		
		//make sure that specifying the section "main" section works just like NOT specifying it.
		$this->assertEqual($sc->get_value('SITEROOT'), $sc->get_value('MAIN/SITEROOT'));
		$this->assertEqual($sc->get_value('SITEROOT'), $sc->get_value('siteroot'));
		$this->assertEqual($sc->get_value('SITEROOT'), $sc->get_value('siteRoot'));
		
		//make sure if we request an index that doesn't exist, it is returned as null
		$this->assertTrue(is_null($sc->get_value('NONExISTENT___')));
		
		//make sure some values have been replaced.
		$this->assertTrue(!preg_match("/{/", $sc->get_value('libdir')));
		$this->assertTrue(
				preg_match("/^". preg_replace("/\//", "\/", $sc->get_value('siteroot')) ."/", $sc->get_value('libdir')), 
				"LIBDIR (". $sc->get_value('libdir') .") doesn't contain SITEROOT (". $sc->get_value('siteroot') .")"
		);
		$this->assertEqual(
				$sc->get_value('main/tmpldir'), 
				$sc->get_value('cs-content/tmpldir'),
				"path replacement for cs-content/tmpldir (". $sc->get_value('cs-content/tmpldir') .") didn't match main/tmpldir (". $sc->get_value('main/tmpldir') .")"
		);
		
		//make sure all of the items that are supposed to be set as globals & constants actually were.
		
		//Do some testing of sections....
		$this->assertTrue(is_array($sc->get_valid_sections()));
		$this->assertEqual($sc->get_valid_sections(), array('MAIN', 'CS-CONTENT'));
		
		//now let's make sure we got all of the proper globals & constants set.... first, get the list of things that should be globals/constants.
		$setAsGlobals = array();
		$setAsConstants = array();
		foreach($sc->get_valid_sections() as $section) {
			$sectionData = $sc->get_section($section);
			foreach($sectionData as $name=>$value) {
				if(is_array($value['attributes'])) {
					if(isset($value['attributes']['SETGLOBAL'])) {
						$setAsGlobals[$name] = $value['value'];
					}
					if(isset($value['attributes']['SETCONSTANT'])) {
						$setAsConstants[$name] = $value['value'];
					}
				}
			}
		}
		
		foreach($setAsGlobals as $name=>$val) {
			$index = $varPrefix . $name;
			$this->assertNotEqual($name, $index);
			$this->assertTrue(isset($GLOBALS[$index]));
			$this->assertEqual($GLOBALS[$index], $val);
		}
		
		foreach($setAsConstants as $name=>$val) {
			$index = $varPrefix . $name;
			$this->assertNotEqual($name, $index);
			$this->assertTrue(defined($index));
			$this->assertEqual(constant($index), $val);
		}
		
	}//end test_siteConfig()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_genericPage() {
		$filesDir = dirname(__FILE__) .'/files';
		
		$mainTemplate = $filesDir .'/templates/main.shared.tmpl';
		$page = new cs_genericPage(false, $mainTemplate);
		$fs = new cs_fileSystem($filesDir .'/templates');
		
		$lsData = $fs->ls();
		
		foreach($lsData as $index=>$value) {
			$filenameBits = explode('.', $index);
			$page->add_template_file($filenameBits[0], $index);
		}
		
		$page->add_template_var('blockRowTestVal', 3);
		$page->add_template_var('date', '2009-01-01');
		
		$checkThis = $page->return_printed_page();
		
		
		$this->assertEqual($checkThis, file_get_contents($filesDir .'/gptest_all-together.txt'));
		
		//now let's rip all the template rows out & add them back in.
		$rowDefs = $page->get_block_row_defs('content');
		$rippedRows = $page->rip_all_block_rows('content');
		
		$this->assertEqual($rowDefs['ordered'], array_keys($rippedRows));
		$remainingRows = $page->rip_all_block_rows('content');
		$this->assertEqual(array(), $remainingRows, "ERROR: some block rows exist after ripping: ". 
				$this->gfObj->string_from_array(array_keys($remainingRows), 'null', ','));
		
		
		foreach($rippedRows as $name=>$data) {
			$page->add_template_var($name, $data);
		}
		$checkThis2 = $page->return_printed_page();
		
		$this->assertEqual($checkThis, $checkThis2);
		
		$checkThis = $page->return_printed_page(0);
		$this->assertTrue(preg_match('/\{.\S+?\}/', $checkThis));
		
		//clone the page object so we can change stuff & not affect the original.
		$page2 = clone $page;
		unset($page2->templateVars);
		$this->assertNotEqual($page->templateVars, $page2->templateVars);
		$page2 = clone $page;
		
		$this->assertNotEqual($page2->templateVars['content'], $page2->strip_undef_template_vars($page2->templateVars['content']));
		$this->assertNotEqual($page2->templateVars['content'], $page2->strip_undef_template_vars($page2->templateVars['content']));
		$page2->templateVars['content'] = $page2->strip_undef_template_vars($page2->templateVars['content']);
		$this->assertEqual($page->return_printed_page(1), $page2->return_printed_page(1));
		
		
		//test to see if the list of templateFiles is as expected...
		{
			$files = array_keys($lsData);
			$expectedList = array();
			foreach($files as $name) {
				$bits = explode('.', $name);
				$expectedList[$bits[0]] = $name;
			}
			
			$this->assertEqual($expectedList, $page->templateFiles);
		}
		
		
		//make sure stripping undefined vars works properly.
		{
			$page = new cs_genericPage(false, $mainTemplate);
			$this->assertEqual($fs->read($mainTemplate), $page->return_printed_page(0));
			$this->assertNotEqual($fs->read($mainTemplate), $page->return_printed_page(1));
			
			//rip out undefined template vars manually & check 'em.
			$junk = array();
			$contents = $page->strip_undef_template_vars($fs->read($mainTemplate), $junk);
			$this->assertEqual($page->strip_undef_template_vars($fs->read($mainTemplate)), $page->return_printed_page(1));
			$this->assertNotEqual($page->strip_undef_template_vars($fs->read($mainTemplate)), $page->return_printed_page(0));
			
			
			//make sure the unhandled var lists are the same.
			$myUnhandledVars = array();
			$page->strip_undef_template_vars($fs->read($mainTemplate), $myUnhandledVars);
			$page->return_printed_page(1);//the last run MUST strip undefined vars.
			$this->assertEqual(array_keys($myUnhandledVars), array_keys($page->unhandledVars));
			if(!$this->assertEqual($myUnhandledVars, $page->unhandledVars)) {
				$this->gfObj->debug_print($myUnhandledVars);
				$this->gfObj->debug_print($page->unhandledVars);
			}
		}
	}//end test_genericPage
	//-------------------------------------------------------------------------
	
	
	
}//end TestOfCSContent
//=============================================================================
?>
