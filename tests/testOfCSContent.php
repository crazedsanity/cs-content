<?php
/*
 * Created on Jan 13, 2009
 */


require_once(dirname(__FILE__) .'/../__autoload.php');

//=============================================================================
class TestOfCSContent extends PHPUnit_Framework_TestCase {
	
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
	function test_genericPage() {
		$filesDir = dirname(__FILE__) .'/files';
		
		$mainTemplateFullUrl = $filesDir .'/templates/main.shared.tmpl';
		$mainTemplate = 'main.shared.tmpl';
		
		$page = new cs_genericPage(false, $mainTemplateFullUrl);
		
		//NOTE::: this test FAILS with cs_genericPage.class.php@455 (or any revision less than 455)
		$this->assertEquals($mainTemplateFullUrl, $page->template_file_exists($mainTemplate));
		
		$this->assertEquals($page->file_to_string($mainTemplate), file_get_contents($mainTemplateFullUrl));
		
		
		
		$fs = new cs_fileSystem($filesDir .'/templates');
		
		$lsData = $fs->ls();
		
		foreach($lsData as $index=>$value) {
			$filenameBits = explode('.', $index);
			$page->add_template_file($filenameBits[0], $index);
		}
		
		$page->add_template_var('blockRowTestVal', 3);
		$page->add_template_var('date', '2009-01-01');
		
		$checkThis = $page->return_printed_page();
		
		$this->assertEquals($checkThis, file_get_contents($filesDir .'/gptest_all-together.txt'));
		
		//now let's rip all the template rows out & add them back in.
		$rowDefs = $page->get_block_row_defs('content');
		$rippedRows = $page->rip_all_block_rows('content');
		
		$this->assertEquals($rowDefs['ordered'], array_keys($rippedRows));
		$remainingRows = $page->rip_all_block_rows('content');
		$this->assertEquals(array(), $remainingRows, "ERROR: some block rows exist after ripping: ". 
				$this->gfObj->string_from_array(array_keys($remainingRows), 'null', ','));
		
		
		foreach($rippedRows as $name=>$data) {
			$page->add_template_var($name, $data);
		}
		$checkThis2 = $page->return_printed_page();
		
		//NOTE::: this test FAILS with cs_genericPage.class.php@455 (or any revision less than 455)
		$this->assertEquals($checkThis, $checkThis2);
		
		$checkThis = $page->return_printed_page(0);
		$this->assertTrue((bool)preg_match('/\{.\S+?\}/', $checkThis));
		
		//clone the page object so we can change stuff & not affect the original.
		$page2 = clone $page;
		unset($page2->templateVars);
		$this->assertNotEquals($page->templateVars, $page2->templateVars);
		$page2 = clone $page;
		
		$this->assertNotEquals($page2->templateVars['content'], $page2->strip_undef_template_vars($page2->templateVars['content']));
		$this->assertNotEquals($page2->templateVars['content'], $page2->strip_undef_template_vars($page2->templateVars['content']));
		$page2->templateVars['content'] = $page2->strip_undef_template_vars($page2->templateVars['content']);
		$this->assertEquals($page->return_printed_page(1), $page2->return_printed_page(1));
		
		
		//test to see if the list of templateFiles is as expected...
		{
			$files = array_keys($lsData);
			$expectedList = array();
			foreach($files as $name) {
				$bits = explode('.', $name);
				$expectedList[$bits[0]] = $name;
			}
			
			$this->assertEquals($expectedList, $page->templateFiles);
		}
		
		
		//make sure stripping undefined vars works properly (see issue #237)
		{
			$page = new cs_genericPage(false, $mainTemplateFullUrl);
			$this->assertEquals($fs->read($mainTemplate), $page->return_printed_page(0));
			$this->assertNotEquals($fs->read($mainTemplate), $page->return_printed_page(1));
			
			//rip out undefined template vars manually & check 'em.
			$junk = array();
			$contents = $page->strip_undef_template_vars($fs->read($mainTemplate), $junk);
			$this->assertEquals($page->strip_undef_template_vars($fs->read($mainTemplate)), $page->return_printed_page(1));
			$this->assertNotEquals($page->strip_undef_template_vars($fs->read($mainTemplate)), $page->return_printed_page(0));
			
			
			//make sure the unhandled var lists are the same.
			$myUnhandledVars = array();
			$page->strip_undef_template_vars($fs->read($mainTemplate), $myUnhandledVars);
			$page->return_printed_page(1);//the last run MUST strip undefined vars.
			$this->assertEquals(array_keys($myUnhandledVars), array_keys($page->unhandledVars));
			if(!$this->assertEquals($myUnhandledVars, $page->unhandledVars)) {
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
			$this->assertEquals($page->return_printed_page(), $page->return_printed_page());
			$this->assertEquals($page->return_printed_page(), $page->return_printed_page());
			$this->assertEquals($page->return_printed_page(), $page->return_printed_page());
			
			/*
			 * NOTE::: if this seems confusing, well... it is.  Basically, the template var "{blockRowTestVal}" doesn't get 
			 * parsed into the value of 3 until the call to print_page(), so therefore the block row "blockRow3" doesn't have
			 * a valid BEGIN statement until AFTER the page is built... ripping out that blockrow would have to be done after 
			 * everything is all complete (i.e. by assigning the value of return_printed_page() to a template var)
			 */
			if(!$this->assertEquals(6, count($blockRows))) {
				$this->gfObj->debug_print($blockRows);
			}
			
			$this->assertEquals(file_get_contents($filesDir .'/gptest_blockrows.txt'), $page->return_printed_page());
			
			$rasterizedData = $page->return_printed_page();
			$page->add_template_var('main', $page->return_printed_page());
			$this->assertEquals($rasterizedData, $page->return_printed_page());
			
			$blockRows = $page->rip_all_block_rows('main');
			$this->assertEquals(1, count($blockRows));
			$this->assertTrue(isset($blockRows['blockRow3']));
			
			$this->assertEquals(file_get_contents($filesDir .'/gptest_blockrows2.txt'), $page->return_printed_page());
			$this->assertNotEquals(file_get_contents($filesDir .'/gptest_blockrows2.txt'), file_get_contents($filesDir .'/gptest_blockrows.txt'));
		}
	}//end test_genericPage
	//-------------------------------------------------------------------------
	
	
}//end TestOfCSContent
//=============================================================================
?>
