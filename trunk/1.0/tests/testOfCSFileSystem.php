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
		
	}//end __construct()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function setUp() {
		$filesDir = dirname(__FILE__) ."/files";
		
		$this->reader = new cs_fileSystem($filesDir);
		$this->writer = new cs_fileSystem(constant('RWDIR'));
		
		//make a directory to write into.
		$this->writer->mkdir(__CLASS__);
		$this->writer->cd(__CLASS__);
	}//end setUp()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function tearDown() {
		//TODO: this should be able to RECURSIVELY delete files & folders.
		$this->writer->cd('/');
		$this->writer->rmdir(__CLASS__);
	}//end tearDown()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_basic_rw() {
		
		$this->assertEqual($this->reader->root, dirname(__FILE__) .'/files');
		
		$outsideLs = $this->reader->ls("templates");
		
		$this->reader->cd("templates");
		$insideLs = $this->reader->ls();
		
		$this->assertEqual($outsideLs, $insideLs);
		
		//okay, read all the files & make the writer create them.
		$matchSize = array();
		foreach($insideLs as $file=>$data) {
			$this->assertEqual(1, $this->writer->create_file($file));
			
			$this->assertNotEqual($this->writer->realcwd, $this->reader->realcwd);
			
			//now read data out of one & write into the other, make sure they're the same size.
			$fileSize = $this->writer->write($this->reader->read($file), $file);
			$this->assertEqual($fileSize, $data['size']);
			
			//now get rid of the new file.
			$this->writer->rm($file);
		}
		
		//lets take the contents of ALL of those files, push it into one big file, and make sure it is identical.
		$testFilename_a = 'concat_file.txt';
		$testFilename_aplus = 'concat_file2.txt';
		$this->writer->create_file($testFilename_a);
		$this->writer->create_file($testFilename_aplus);
		
		$totalSize = 0;
		$totalContent = "";
		$loop=0;
		$fileList = "";
		foreach($insideLs as $file=>$data) {
			$totalSize += $data['size'];
			
			$content = $this->reader->read($file);
			$totalContent .= $content;
			
			$this->writer->openFile($testFilename_a, 'a');
			$this->writer->append_to_file($content, null);
			$this->writer->closeFile();
			
			$this->writer->openFile($testFilename_aplus, 'a+');
			$this->writer->append_to_file($content, null);
			$this->writer->closeFile();
			
			$loop++;
		}
		
		//now lets read each file & see if they have the proper content...
		$this->assertEqual($totalContent, $this->writer->read($testFilename_a));
		$this->assertEqual($totalContent, $this->writer->read($testFilename_aplus));
		
		
		//Test if it can create and then move around within a file properly
		{
			//Generated from http://www.lipsum.com/feed/html
			$fileLines = array(
				'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
				'Nam nec risus eu mauris euismod convallis eget eget mi.',
				'Morbi eget mi eu sapien mollis porttitor vitae ut augue.',
				'Pellentesque porta volutpat sem, quis facilisis nulla dictum vitae.',
				'Praesent tempus lorem sit amet tortor tempor blandit.'
			);
			
			$appendTestFile = 'lipsum.txt';
			$this->writer->create_file($appendTestFile);
			$this->writer->openFile($appendTestFile, 'a+');
			
			//now let's make the array MASSIVE by replicating the file lines over & over again.
			$finalFileLines = array();
			$replicate = 1000;
			$myContent = null;
			$actualNum = 0;
			for($x=0; $x<$replicate;$x++) {
				foreach($fileLines as $x2=>$line) {
					$myLine = "line #". $actualNum ." ". $line;
					$myContent .= $myLine ."\n";
					
					$this->writer->append_to_file($myLine);
					$actualNum++;
				}
			}
			$this->writer->closeFile();
			
			//now make sure the contents of the file are as expected...
			$this->assertEqual($myContent, $this->writer->read($appendTestFile));
			
			$this->writer->create_file('x.txt');
			$this->writer->write($myContent, 'x.txt');
			
			unset($myContent,$finalFileLines);
		}
		
		
		//now delete the files.
		foreach($this->writer->ls() as $file=>$garbage) {
			$this->writer->rm($file);
		}
	}//end test_basic_rw()
	//-------------------------------------------------------------------------
	
	
	
}//end TestOfCSFileSystem
//=============================================================================
?>
