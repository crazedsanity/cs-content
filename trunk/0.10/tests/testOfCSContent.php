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
		require_once(dirname(__FILE__) .'/../cs_globalFunctions.php');
		require_once(dirname(__FILE__) .'/../cs_siteConfig.class.php');
		
		$this->gf = new cs_globalFunctions;
		$this->gf->debugPrintOpt=1;
	}//end __construct()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function test_cleanString() {
		
		$gf = new cs_globalFunctions();
		
		$cleanThis = '~`!@#$^&*()_+-=[]\{}|;34:\\\'\<>?,.//\".JuST THIS';
		$testSQL = array(
			'none'							=> $cleanThis,
			'query'							=> '@_=;34:/JuST THIS',
			'theDefault'					=> '34JuSTTHIS',
			'alphanumeric'					=> '34JuSTTHIS',
			'sql'							=> '~`!@#$^&*()_+-=[]{}|;34:\\\'<>?,.//\".JuST THIS',
			'sql_insert'					=> '~`!@#$^&*()_+-=[]{}|;34:\\\\\'<>?,.//".JuST THIS',
			'sql92_insert'					=> '~`!@#$^&*()_+-=[]{}|;34:\'\'<>?,.//".JuST THIS',
			'double_quote'					=> '~`!@#$^&*()_+-=[]\{}|;34:\\\'\<>?,.//\.JuST THIS',
			'htmlspecial'					=> '~`!@#$^&amp;*()_+-=[]\{}|;34:\\\'\&lt;&gt;?,.//\&quot;.JuST THIS',
			'htmlspecial_q'					=> '~`!@#$^&amp;*()_+-=[]\{}|;34:\\&#039;\&lt;&gt;?,.//\&quot;.JuST THIS',
			'htmlspecial_nq'				=> '~`!@#$^&amp;*()_+-=[]\{}|;34:\\\'\&lt;&gt;?,.//\".JuST THIS',
			'htmlentity'					=> '~`!@#$^&amp;*()_+-=[]\{}|;34:\\\'\&lt;&gt;?,.//\&quot;.JuST THIS',
			'htmlentity_plus_brackets'		=> '~`!@#&#36;^&amp;*()_+-=[]\&#123;&#125;|;34:\\\'\&lt;&gt;?,.//\&quot;.JuST THIS',
			'double_entity'					=> '~`!@#$^&amp;*()_+-=[]\{}|;34:\\\'\&lt;&gt;?,.//\.JuST THIS',
			'meta'							=> '~`!@#\$\^&\*\(\)_\+-=\[\]\\\\{}|;34:\\\\\'\\\<>\?,\.//\\\\"\.JuST THIS',
			'email'							=> '@_-34..JuSTTHIS',
			'email_plus_spaces'				=> '@_-34..JuST THIS',
			'phone_fax'						=> '()+-34 ',
			'integer'						=> '34',
			'numeric'						=> '34',
			'decimal'						=> '34..',
			'float'							=> '34..',
			'name'							=> '\'JuSTTHIS',
			'names'							=> '\'JuSTTHIS',
			'alpha'							=> 'JuSTTHIS',
			'bool'							=> 't',
			'varchar'						=> '\'@_=;34:/JuST THIS\'',
			'date'							=> '-34',
			'datetime'						=> '-34:\'.//.JuST THIS',
			'all'							=> '34JuSTTHIS'
		);
		
		foreach($testSQL as $name=>$expected) {
			$cleanedData = $gf->cleanString($cleanThis, $name);
			
			//NOTE::: passing "%" in the message data causes an exception with the simpletest framework.
			$this->assertEqual($expected, $cleanedData);
		}
		
		
		//test quoting (with a few exceptions).
		$testQuotes = $testSQL;
		unset($testQuotes['none'], $testQuotes['sql92_insert']);
		foreach($testQuotes as $name=>$expected) {
			$gf->switch_force_sql_quotes(1);
			$cleanedDataPlusQuotes = $gf->cleanString($cleanThis, $name, 1);
			$this->assertEqual("'". $expected ."'", $cleanedDataPlusQuotes, "Failed quoting with style=(". $name .")");
			
			$gf->switch_force_sql_quotes(0);
			$this->assertEqual("'". $expected ."'", $cleanedDataPlusQuotes, "Failed quoting with style=(". $name .")");
		}
		
		
		//TEST NULLS
		{
			
			$this->assertEqual($gf->cleanString("", "numeric",0), "");
			$this->assertEqual($gf->cleanString("", "numeric",1), "''");
			$this->assertEqual($gf->cleanString("", "integer",0), "");
			$this->assertEqual($gf->cleanString("", "integer",1), "''");
			$this->assertEqual($gf->cleanString(null, "numeric",0), "NULL");
			$this->assertEqual($gf->cleanString(null, "numeric",1), "NULL");
			$this->assertEqual($gf->cleanString(null, "integer",0), "NULL");
			$this->assertEqual($gf->cleanString(null, "integer",1), "NULL");
			
			$this->assertEqual($gf->cleanString(null, "varchar",0), "NULL");
			$this->assertEqual($gf->cleanString(null, "varchar",1), "'NULL'");
			$this->assertEqual($gf->cleanString("", "varchar",0), "NULL");
			$this->assertEqual($gf->cleanString("", "varchar",1), "'NULL'");
		}
		
	}//end test_cleanString()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_string_from_array() {
		$gf = new cs_globalFunctions;
		$gf->switch_force_sql_quotes(0);
		
		//Test some SQL-Specific stuff.
		$testSQL = array(
			'column1'		=> "'my value ' OR 'x'='x'",
			'column two'	=> "Stuff"
		);
		
		//Test INSERT style.
		{
			$expected = "(column1, column two) VALUES ('my value ' OR 'x'='x','Stuff')";
			$this->assertEqual($gf->string_from_array($testSQL, 'insert'), $expected);
			
			$expected = "(column1, column two) VALUES ('\'my value \' OR \'x\'=\'x\'','Stuff')";
			$this->assertEqual($gf->string_from_array($testSQL, 'insert', null, 'sql'), $expected);
			
			$expected = "(column1, column two) VALUES ('\'my value \' OR \'x\'=\'x\'','Stuff')";
			$this->assertEqual($gf->string_from_array($testSQL, 'insert', null, 'sql_insert'), $expected);
			
			$expected = "(column1, column two) VALUES ('\'my value \' OR \'x\'=\'x\'','Stuff')";
			$this->assertEqual($gf->string_from_array($testSQL, 'insert', null, 'sql92_insert'), $expected);
			
			//now let's see what happens if we pass an array signifying how it should be cleaned.
			$expected = "(column1, column two) VALUES ('\'my value \' OR \'x\'=\'x\'','Stuff')";
			$this->assertEqual($gf->string_from_array($testSQL, 'insert', null, array('column1'=>'sql', 'column two'=>'sql')), $expected);
			$expected = "(column1, column two) VALUES ('\\\\\'my value \\\\\' OR \\\\\'x\\\\\'=\\\\\'x\\\\\'','Stuff')";
			$this->assertEqual($gf->string_from_array($testSQL, 'insert', null, array('column1'=>'sql_insert', 'column two'=>'sql_insert')), $expected);
			$expected = "(column1, column two) VALUES ('\'\'my value \'\' OR \'\'x\'\'=\'\'x\'\'','Stuff')";
			$this->assertEqual($gf->string_from_array($testSQL, 'insert', null, array('column1'=>'sql92_insert', 'column two'=>'sql92_insert')), $expected);
			
		}
		
	}//end test_string_from_array()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_interpret_bool() {
		$gf=new cs_globalFunctions;
		
		$this->assertEqual($gf->interpret_bool('true'), true);
		$this->assertEqual($gf->interpret_bool('false'), false);
		$this->assertEqual($gf->interpret_bool('0'), false);
		$this->assertEqual($gf->interpret_bool('1'), true);
		$this->assertEqual($gf->interpret_bool(0), false);
		$this->assertEqual($gf->interpret_bool(1), true);
		$this->assertEqual($gf->interpret_bool('f'), false);
		$this->assertEqual($gf->interpret_bool('t'), true);
		$this->assertEqual($gf->interpret_bool("1stuff"), true);
		$this->assertEqual($gf->interpret_bool(""), false);
		$this->assertEqual($gf->interpret_bool(" true  "), true);
		$this->assertEqual($gf->interpret_bool(" false  "), false);
		
		//now go through the same thing, but this time tell it to give back a specific value for true and false.
		$this->assertEqual($gf->interpret_bool(false, array(0=>'FaLSe',1=>"crap")), 'FaLSe');
		$this->assertEqual($gf->interpret_bool(false, array(0=>"crap",1=>'FaLSe')), 'crap');
	}//end test_interpret_bool()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function test_siteConfig() {
		$configFile = dirname(__FILE__) .'/files/sampleConfig.xml';
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
	
	
	
}//end TestOfCSContent
//=============================================================================
?>
