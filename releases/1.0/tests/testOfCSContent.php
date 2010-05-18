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
		if(!defined('TEST_FILESDIR')) {
			define('TEST_FILESDIR', $filesDir);
		}
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
				if(isset($value['attributes']) && is_array($value['attributes'])) {
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
		
		$mainTemplateFullUrl = $filesDir .'/templates/main.shared.tmpl';
		$mainTemplate = 'main.shared.tmpl';
		
		$page = new cs_genericPage(false, $mainTemplateFullUrl);
		
		//NOTE::: this test FAILS with cs_genericPage.class.php@455 (or any revision less than 455)
		$this->assertEqual($mainTemplateFullUrl, $page->template_file_exists($mainTemplate));
		
		$this->assertEqual($page->file_to_string($mainTemplate), file_get_contents($mainTemplateFullUrl));
		
		
		
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
		
		//NOTE::: this test FAILS with cs_genericPage.class.php@455 (or any revision less than 455)
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
		
		
		//make sure stripping undefined vars works properly (see issue #237)
		{
			$page = new cs_genericPage(false, $mainTemplateFullUrl);
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
		
		//Test if ripping out all the block rows works as intended (also related to issue #237)
		{
			$page = new cs_genericPage(false, $mainTemplateFullUrl);
			$page->add_template_var('blockRowTestVal', 3);
			
			$fs = new cs_fileSystem($filesDir .'/templates');
			$lsData = $fs->ls();
			foreach($lsData as $index=>$value) {
				$filenameBits = explode('.', $index);
				$page->add_template_file($filenameBits[0], $index);
			}
			
			$blockRows = $page->rip_all_block_rows('content');
			
			//make sure printing the page multiple times doesn't change its output.
			$this->assertEqual($page->return_printed_page(), $page->return_printed_page());
			$this->assertEqual($page->return_printed_page(), $page->return_printed_page());
			$this->assertEqual($page->return_printed_page(), $page->return_printed_page());
			
			/*
			 * NOTE::: if this seems confusing, well... it is.  Basically, the template var "{blockRowTestVal}" doesn't get 
			 * parsed into the value of 3 until the call to print_page(), so therefore the block row "blockRow3" doesn't have
			 * a valid BEGIN statement until AFTER the page is built... ripping out that blockrow would have to be done after 
			 * everything is all complete (i.e. by assigning the value of return_printed_page() to a template var)
			 */
			if(!$this->assertEqual(6, count($blockRows))) {
				$this->gfObj->debug_print($blockRows);
			}
			
			$this->assertEqual(file_get_contents($filesDir .'/gptest_blockrows.txt'), $page->return_printed_page());
			
			$rasterizedData = $page->return_printed_page();
			$page->add_template_var('main', $page->return_printed_page());
			$this->assertEqual($rasterizedData, $page->return_printed_page());
			
			$blockRows = $page->rip_all_block_rows('main');
			$this->assertEqual(1, count($blockRows));
			$this->assertTrue(isset($blockRows['blockRow3']));
			
			$this->assertEqual(file_get_contents($filesDir .'/gptest_blockrows2.txt'), $page->return_printed_page());
			$this->assertNotEqual(file_get_contents($filesDir .'/gptest_blockrows2.txt'), file_get_contents($filesDir .'/gptest_blockrows.txt'));
		}
	}//end test_genericPage
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function test_contentSystem () {
		
		$content = new contentSystem(dirname(__FILE__) .'/files');
		$content->inject_var('testObj', $this);
		$content->finish();
	}//end test_contentSystem()
	//-------------------------------------------------------------------------
	
	
	
}//end TestOfCSContent
//=============================================================================
?>
