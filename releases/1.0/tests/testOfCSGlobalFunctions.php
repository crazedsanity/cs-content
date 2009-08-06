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
class TestOfCSGlobalFunctions extends UnitTestCase {
	
	//-------------------------------------------------------------------------
	function __construct() {
		require_once(dirname(__FILE__) .'/../cs_globalFunctions.class.php');
		require_once(dirname(__FILE__) .'/../cs_siteConfig.class.php');
		
		$this->gfObj = new cs_globalFunctions;
		$this->gfObj->debugPrintOpt=1;
		
		$filesDir = dirname(__FILE__) ."/files";
		define('TEST_FILESDIR', $filesDir);
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
		
		//make sure forceSqlQuotes is OFF.
		$gf->switch_force_sql_quotes(0);
		
		//Test the SELECT style.
		{
			//a basic set of criteria...
			$expected = "w='' AND x='y' AND y='0' AND z=''";
			$actual = $gf->string_from_array(array('w'=>'', 'x'=>"y", 'y'=>0,'z'=>NULL), 'select');
			$this->assertEqual($expected, $actual);
			
			//make sure it distinguishes between text "NULL" and literal NULL.
			$expected = "w='' AND x='y' AND y='0' AND z='NULL'";
			$actual = $gf->string_from_array(array('w'=>'', 'x'=>"y", 'y'=>0,'z'=>"NULL"), 'select');
			$this->assertEqual($expected, $actual);
			
			//make sure it distinguishes between text "NULL" and literal NULL.
			$expected = "w='' AND x='y' AND y='0' AND z='NULL'";
			$actual = $gf->string_from_array(array('w'=>'', 'x'=>"y", 'y'=>0,'z'=>"NULL"), 'select', null, 'sql');
			$this->assertEqual($expected, $actual);
			
			//check with specific cleaning styles.
			$expected = "w='' AND x='y' AND y='0' AND z='NULL'";
			$cleanString = array('w'=>"nonexistent", 'x'=>"alpha", 'y'=>"numeric", 'z'=>"sql");
			$actual = $gf->string_from_array(array('w'=>'', 'x'=>"y", 'y'=>0,'z'=>"NULL"), 'select', null, $cleanString);
			$this->assertEqual($expected, $actual);
		}
		
		
		//Test the UPDATE style.
		{
			//basic update.
			$expected = "w='', x='y', y='0', z=''";
			$actual = $gf->string_from_array(array('w'=>"", 'x'=>"y", 'y'=>0, 'z'=>NULL), 'update', null, 'sql');
			$this->assertEqual($expected, $actual);
			
			
			//basic update, but force SQL quotes...
			$gf->switch_force_sql_quotes(1);
			$expected = "w='', x='y', y='0', z=''";
			$actual = $gf->string_from_array(array('w'=>"", 'x'=>"y", 'y'=>0, 'z'=>NULL), 'update', null, 'sql');
			$this->assertEqual($expected, $actual);
			$gf->switch_force_sql_quotes(0);
			
			//update with invalid quotes (attempts at SQL injection)
			$expected = "w='\' ', x='\'', y='0', z=''";
			$actual = $gf->string_from_array(array('w'=>"' ", 'x'=>"'", 'y'=>0, 'z'=>NULL), 'update', null, 'sql');
			$this->assertEqual($expected, $actual);
		}
		
		
	}//end test_string_from_array()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_interpret_bool() {
		$gf=new cs_globalFunctions;
		
		$this->assertEqual($gf->interpret_bool('true'), true);
		$this->assertEqual($gf->interpret_bool(true), true);
		$this->assertEqual($gf->interpret_bool('false'), false);
		$this->assertEqual($gf->interpret_bool(false), false);
		$this->assertEqual($gf->interpret_bool('0'), false);
		$this->assertEqual($gf->interpret_bool('1'), true);
		$this->assertEqual($gf->interpret_bool(0), false);
		$this->assertEqual($gf->interpret_bool(000000), false);
		$this->assertEqual($gf->interpret_bool(1), true);
		$this->assertEqual($gf->interpret_bool(0.1), true);
		$this->assertEqual($gf->interpret_bool(0.01), true);
		$this->assertEqual($gf->interpret_bool(0.001), true);
		$this->assertEqual($gf->interpret_bool('f'), false);
		$this->assertEqual($gf->interpret_bool('fa'), true);
		$this->assertEqual($gf->interpret_bool('fal'), true);
		$this->assertEqual($gf->interpret_bool('fals'), true);
		$this->assertEqual($gf->interpret_bool('t'), true);
		$this->assertEqual($gf->interpret_bool('tr'), true);
		$this->assertEqual($gf->interpret_bool('tru'), true);
		$this->assertEqual($gf->interpret_bool("1stuff"), true);
		$this->assertEqual($gf->interpret_bool(""), false);
		$this->assertEqual($gf->interpret_bool(" true  "), true);
		$this->assertEqual($gf->interpret_bool(" false  "), false);
		$this->assertEqual($gf->interpret_bool('false-showastrue'), true);
		$this->assertEqual($gf->interpret_bool('true-showastrue'), true);
		
		
		//now go through the same thing, but this time tell it to give back a specific value for true and false.
		$this->assertEqual($gf->interpret_bool(false, array(0=>'FaLSe',1=>"crap")), 'FaLSe');
		$this->assertEqual($gf->interpret_bool(false, array(0=>"crap",1=>'FaLSe')), 'crap');
	}//end test_interpret_bool()
	//-------------------------------------------------------------------------
	
	
	
}//end TestOfCSContent
//=============================================================================
?>
