<?php
/*
 * Created on Jan 25, 2009
 */

require_once(dirname(__FILE__) .'/../__autoload.php');

//=============================================================================
#class TestOfCSFileSystem extends PHPUnit_Framework_TestCase {

class testOfCSVersionAbstract extends PHPUnit_Framework_TestCase {
	
	//--------------------------------------------------------------------------
	function __construct() {
		$this->gfObj = new cs_globalFunctions;
	}//end __construct()
	//--------------------------------------------------------------------------
	
	
	
	//--------------------------------------------------------------------------
	public function test_backwardCompabibility() {
		//Just make sure we can actually 
		$x = new _testBackCompat_1_2_6_or_less();
		$this->assertTrue(is_object($x));
	}
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	function test_version_basics() {
		
		$tests = array(
			'files/version1'	=> array(
				'0.1.2-ALPHA8754',
				'test1',
				array(
					'version_major'			=> 0,
					'version_minor'			=> 1,
					'version_maintenance'	=> 2,
					'version_suffix'		=> 'ALPHA8754'
				)
			),
			'files/version2'	=> array(
				'5.4.0',
				'test2',
				array(
					'version_major'			=> 5,
					'version_minor'			=> 4,
					'version_maintenance'	=> 0,
					'version_suffix'		=> null
				)
			),
			'files/version3'	=> array(
				'5.4.3-BETA5543',
				'test3 stuff',
				array(
					'version_major'			=> 5,
					'version_minor'			=> 4,
					'version_maintenance'	=> 3,
					'version_suffix'		=> 'BETA5543'
				)
			)
		);
		
		foreach($tests as $fileName=>$expectedArr) {
			$ver = new cs_version();
			$ver->set_version_file_location(dirname(__FILE__) .'/'. $fileName);
			
			$this->assertEquals($expectedArr[0], $ver->get_version(), "Failed to match string from file (". $fileName .")");
			$this->assertEquals($expectedArr[1], $ver->get_project(), "Failed to match project from file (". $fileName .")");
			
			//now check that pulling the version as an array is the same...
			$checkItArr = $ver->get_version(true);
			$expectThis = $expectedArr[2];
			$expectThis['version_string'] = $expectedArr[0];
			$this->assertEquals($checkItArr, $expectThis);
		}
	}//end test_version_basics()
	//--------------------------------------------------------------------------
	
	
	
	//--------------------------------------------------------------------------
	function test_check_higher() {
		
		//NOTE: the first item should ALWAYS be higher.
		$tests = array(
			'basic, no suffix'	=> array('1.0.1', '1.0.0'),
			'basic + suffix'	=> array('1.0.0-ALPHA1', '1.0.0-ALPHA0'),
			'basic w/o maint'	=> array('1.0.1', '1.0'),
			'suffix check'		=> array('1.0.0-BETA1', '1.0.0-ALPHA1'),
			'suffix check2'		=> array('1.0.0-ALPHA10', '1.0.0-ALPHA1'),
			'suffix check3'		=> array('1.0.1', '1.0.0-RC1')
		);
		
		foreach($tests as $name=>$checkData) {
			$ver = new cs_version;
			$this->assertTrue($ver->is_higher_version($checkData[1], $checkData[0]));
			$this->assertFalse($ver->is_higher_version($checkData[0], $checkData[1]));
			
			$this->assertFalse(is_array($ver->get_version()));
			$this->assertFalse(is_array($ver->get_version(false)));
			$this->assertTrue(is_array($ver->get_version(true)));
		}
		
		//now check to ensure there's no problem with parsing equivalent versions.
		$tests2 = array(
			'no suffix'				=> array('1.0', '1.0.0', ''),
			'no maint + suffix'		=> array('1.0-ALPHA1', '1.0.0-ALPHA1', 'ALPHA1'),
			'no maint + BETA'		=> array('1.0-BETA5555', '1.0.0-BETA5555', 'BETA5555'),
			'no maint + RC'			=> array('1.0-RC33', '1.0.0-RC33', 'RC33'),
			'maint with space'		=> array('1.0-RC  33', '1.0.0-RC33', 'RC33'),
			'extra spaces'			=> array(' 1.0   ', '1.0.0', '')
		);
		foreach($tests2 as $name=>$checkData) {
			$ver = new cs_version;
			$bc = new _testBackCompat_1_2_6_or_less();
			
			//rip apart & recreate first version to test against the expected...
			{
				$this->assertEquals(
						$ver->build_full_version_string($ver->parse_version_string($checkData[0])),
						$checkData[1]
					);

				//test backward compabitibility (for the above test)
				$this->assertEquals(
						$bc->build_full_version_string($bc->parse_version_string($checkData[0])), 
						$checkData[1]
					);
			}
			
			//now rip apart & recreate the expected version (second) and make sure it matches itself.
			{
				$this->assertEquals(
						$ver->build_full_version_string($ver->parse_version_string($checkData[1])), 
						$checkData[1]
					);

				//test backward compabitibility (for the above test)
				$this->assertEquals($bc->build_full_version_string($bc->parse_version_string($checkData[1])), 
						$checkData[1]
					);
			}
			
			// check the suffix.
			{
				$bits = $ver->parse_version_string($checkData[1]);
				$this->assertEquals($bits['version_suffix'], $checkData[2]);
			}
		}
		
		
	}//end test_check_higher()
	//--------------------------------------------------------------------------
	
	
	
	//--------------------------------------------------------------------------
	/**
	 * @expectedException LogicException
	 */
	public function test_exceptionFileMissing() {
		$ver = new _testExceptions();
		$ver->set_versionFileLocation('/__invalid__/__path__');
		$ver->get_project();
	}
	//--------------------------------------------------------------------------
	
	
	
//	//--------------------------------------------------------------------------
//	/**
//	 * @expectedException LengthException
//	 */
//	public function test_exceptionProjectMissing() {
//		$ver = new cs_version();
//		$projectInfo = $ver->set_version_file_location(dirname(__FILE__) .'/files/version4');
//		
//		$ver->gfObj->debug_print($projectInfo,1);
//	}
//	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function test_genericExceptionCatcher() {
		$file = dirname(__FILE__) .'/files/version4';
		$this->assertEquals(strlen(file_get_contents($file)), 0);
		$this->assertTrue(file_exists($file));
		$ver = new _testExceptions();
		try {
			$ver->set_versionFileLocation($file);
		}
		catch(Exception $ex) {
			$this->assertTrue(is_object($ex));
		}
	}
	//--------------------------------------------------------------------------
	
	
	
	//--------------------------------------------------------------------------
	
}

class _testBackCompat_1_2_6_or_less extends cs_versionAbstract {
	public function __construct($makeGfObj=true) {
		parent::__construct($makeGfObj);
	}
}

class _testExceptions extends cs_version {
	public function __construct($makeGfObj=true) {
		
	}
	public function set_versionFileLocation($location=null) {
		$this->versionFileLocation = $location;
	}
	public function testAuto() {
		parent::auto_set_version_file();
	}
}

