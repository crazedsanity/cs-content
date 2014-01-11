<?php
/*
 * Created on Jan 13, 2009
 */

require_once(dirname(__FILE__) .'/../__autoload.php');

//=============================================================================
class TestOfCSFileSystem extends PHPUnit_Framework_TestCase {
	
	//-------------------------------------------------------------------------
	public function __construct() {
		$this->gfObj = new cs_globalFunctions;
		
		//make sure it's all clean.
		$this->_makeClasses();
		$this->tearDown();
		
	}//end __construct()
	//-------------------------------------------------------------------------
	
	
	//-------------------------------------------------------------------------
	protected function _makeClasses() {
		$filesDir = dirname(__FILE__) ."/files";
		$this->reader = new cs_fileSystem($filesDir);
		$this->writer = new cs_fileSystem($filesDir .'/rw');
	}//end _makeClasses()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function setUp() {
		$this->_makeClasses();
		
		//make a directory to write into.
		$this->writer->mkdir(__CLASS__);
		$this->writer->cd(__CLASS__);
	}//end setUp()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function tearDown() {
		//TODO: this should be able to RECURSIVELY delete files & folders.
		$this->writer->cd('/');
		@$this->writer->rmdir(__CLASS__);
	}//end tearDown()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function test_basics() {
		$fs = new _fs_testProtectedMethods(dirname(__FILE__));
		
		$this->assertEquals('/', $fs->cwd);
		$this->assertEquals(dirname(__FILE__), $fs->realcwd);
		
		
		// check that specifying a valid current working directory (cwd) works
		{
			//use a leading slash in CWD
			$validCwd2 = new cs_fileSystem(dirname(__FILE__), '/files');
			$this->assertEquals(dirname(__FILE__) .'/files', $validCwd2->realcwd);
			$this->assertEquals('/files', $validCwd2->cwd);
			
			// just the directory name for CWD (no leading slash)
			$validCwd = new cs_fileSystem(dirname(__FILE__), 'files');
			$this->assertEquals(dirname(__FILE__) .'/files', $validCwd->realcwd);
			$this->assertEquals('files', $validCwd->cwd);
		}
		
		//make sure specifying an invalid CWD works as expected
		{
			$invalidCwd = new cs_fileSystem(dirname(__FILE__), '/xDoEsn0tEx15t');
			$this->assertEquals('/', $invalidCwd->cwd);
			$this->assertEquals(dirname(__FILE__), $invalidCwd->realcwd);
			$this->assertEquals($invalidCwd->root, $invalidCwd->realcwd);
		}
		
		//test that it fixes invalid modes.
		{
			$validModes = array('r', 'r+', 'w', 'w+', 'a', 'a+', 'x', 'x+', 'c', 'c+');
			$invalidModes = array('b', 'b+', 'd', 'd+', 'e', 'e+');

			foreach($validModes as $x) {
				$testMe = new cs_fileSystem(dirname(__FILE__), null, $x);
				$this->assertEquals($x, $testMe->mode);
			}

			foreach($invalidModes as $x) {
				$testMe = new cs_fileSystem(dirname(__FILE__), null, $x);
				$this->assertNotEquals($x, $testMe->mode);
				$this->assertEquals('r+', $testMe->mode);
			}
		}
	}
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * @expectedException InvalidArgumentException
	 */
	public function test_exception_invalidRoot() {
		new cs_fileSystem(null);
	}
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function test_readWrite() {
		
		$this->assertEquals($this->reader->root, dirname(__FILE__) .'/files');
		
		$outsideLs = $this->reader->ls("templates");
		
		$this->reader->cd("templates");
		$insideLs = $this->reader->ls();
		
		$this->assertEquals($outsideLs, $insideLs);
		
		//okay, read all the files & make the writer create them.
		foreach($insideLs as $file=>$data) {
			if($data['type'] == 'file') {
				$this->assertEquals(1, $this->writer->create_file($file));
				
				$this->assertNotEquals($this->writer->realcwd, $this->reader->realcwd);
				
				//now read data out of one & write into the other, make sure they're the same size.
				$fileSize = $this->writer->write($this->reader->read($file), $file);
				$this->assertEquals($fileSize, $data['size']);
				
				//now get rid of the new file.
				$this->writer->rm($file);
			}
		}
		
		//lets take the contents of ALL of those files, push it into one big file, and make sure it is identical.
		$testFilename_a = 'concat_file.txt';
		$testFilename_aplus = 'concat_file2.txt';
		$this->writer->create_file($testFilename_a);
		$this->writer->create_file($testFilename_aplus);
		
		$totalSize = 0;
		$totalContent = "";
		$loop=0;
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
		$this->assertEquals($totalContent, $this->writer->read($testFilename_a));
		$this->assertEquals($totalContent, $this->writer->read($testFilename_aplus));
		
		
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
			$this->assertEquals($myContent, $this->writer->read($appendTestFile));
			
			unset($myContent,$finalFileLines);
			
			//randomly pull a line and make sure it starts with the right phrase.
			$this->writer->openFile($appendTestFile, 'r');
			$linesToTest = 100;
			
			for($i=0;$i<$linesToTest;$i++) {
				$randomLine = rand(0, ($actualNum -1));
				
				$this->writer->go_to_line($randomLine);
				$lineContents = $this->writer->get_next_line();
				
				$actualLine = $randomLine +1;
				$regex = "line #$randomLine";
				$error = "fetched line #$randomLine ($actualLine), should start with '$regex', but didn't... actual::: ". $lineContents;
				$this->assertTrue((bool)preg_match('/^'. $regex .' /', $lineContents), $error);
			}
			
			$this->writer->go_to_last_line();
			$this->writer->go_to_line(($this->writer->lineNum -2));//go back two lines because we're actually past the last line, gotta go 2 up so when we fetch "the next line", it is actually the last.
			$lineContents = $this->writer->get_next_line();
			$this->assertTrue((bool)preg_match('/^line #'. ($this->writer->lineNum -1) .' /', $lineContents));
			
			$this->writer->closeFile();
		}
		
		//now let's try moving a file.
		$newName = "movedFile.txt";
		$lsData = $this->writer->ls();
		$this->assertTrue(isset($lsData[$appendTestFile]));
		$this->writer->move_file($appendTestFile, $newName);
		
		//change the array and make sure it is approximately the same.
		$newLsData = $this->writer->ls();
		$tmp = $lsData[$appendTestFile];
		unset($lsData[$appendTestFile]);
		$lsData[$newName] = $tmp;
		$this->assertEquals($newLsData, $lsData);
		
		
		//now delete the files.
		foreach($this->writer->ls() as $file=>$garbage) {
			$this->assertTrue($this->writer->rm($file));
		}
	}//end test_readWrite()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function test_navigationAndLs() {
		$fs = new cs_fileSystem(dirname(__FILE__));
		
		$thisFile = basename(__FILE__);
		
		$list = $fs->ls();
		
		$this->assertTrue(isset($thisFile, $list));
		$this->assertTrue(is_array($list[$thisFile]));
		$this->assertEquals($list[$thisFile]['type'], 'file');
		
		$this->assertTrue(isset($list['files']));
		$this->assertEquals($list['files']['type'], 'dir');
		
		$this->assertTrue((bool)$fs->cd('files'));
		
		$this->assertEquals($fs->cwd, '/files');
		$this->assertEquals($fs->realcwd, dirname(__FILE__) .'/files');
		
		
		$this->assertTrue($fs->cdup());
		$this->assertEquals($fs->cwd, '/');
		$this->assertEquals(preg_replace('~/$~', '', $fs->realcwd), dirname(__FILE__));
		
		//this should fail, because it's higher than allowed.
		$this->assertFalse($fs->cdup());
		$this->assertEquals($fs->cwd, '/');
		$this->assertEquals(preg_replace('~/$~', '', $fs->realcwd), dirname(__FILE__));
		
		$this->assertTrue((bool)$fs->cd('/'));
		$this->assertEquals($fs->cwd, '/');
		$this->assertEquals(preg_replace('~/$~', '', $fs->realcwd), dirname(__FILE__));
		
		//make sure we can still find just this file.
		$fileInfo = $fs->ls(basename(__FILE__));
		$this->assertTrue(is_array($fileInfo));
		
		$this->assertEquals(count($fileInfo), 1, "too many files in the array...");
		$this->assertTrue(isset($fileInfo[basename(__FILE__)]));
		$this->assertTrue(isset($fileInfo[basename(__FILE__)]['type']), "malformed array, should ONLY contain info about this file::: ". $this->gfObj->debug_print($fileInfo,0));
	}
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function test_pathFixing() {
		$fs = new _fs_testProtectedMethods(dirname(__FILE__));
		
		
		$this->assertEquals($fs->root, dirname(__FILE__));
		
		//make sure it comes up with the REAL path when there's dots involved...
		$this->assertEquals(
				'/real/path/to/file',
				$fs->resolve_path_with_dots('/path/../real/fake/../path/from/../to/./file')
		);
		
		
		$this->assertEquals(__FILE__, $fs->_2absolute('/'. basename(__FILE__)));
	}
	//-------------------------------------------------------------------------
	
	
	/**
	 * @expectedException InvalidArgumentException
	 */
	public function test_resolvePathException() {
		$fs = new _fs_testProtectedMethods(dirname(__FILE__));
		
		$fs->resolve_path_with_dots(NULL);
	}
	
	
}//end TestOfCSFileSystem
//=============================================================================


//=============================================================================
class _fs_testProtectedMethods extends cs_fileSystem {
	public function __construct($rootDir=NULL, $cwd=NULL, $initialMode=NULL) {
		parent::__construct($rootDir, $cwd, $initialMode);
	}
	public function _2absolute($filename) {
		return(parent::filename2absolute($filename));
	}
}//end _fs_testProtectedMethods
//=============================================================================
?>
