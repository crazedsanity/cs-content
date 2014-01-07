<?php
/*
 * Created on Jan 13, 2009
 */

require_once(dirname(__FILE__) .'/../__autoload.php');


//=============================================================================
class TestOfCSGlobalFunctions extends PHPUnit_Framework_TestCase {
	
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
	public function test_cleanString() {
		
		$gf = new cs_globalFunctions();
		
		$cleanThis = '~`!@#$^&*()_+-=[]\{}|;34:\\\'\<>?,.//\".JuST THIS';
		$testSQL = array(
			'none'							=> $cleanThis,
			'query'							=> '@_=;34:/JuST THIS',
			'theDefault'					=> '34JuSTTHIS',
			'alphanumeric'					=> '34JuSTTHIS',
			#'sql'							=> '~`!@#$^&*()_+-=[]{}|;34:\\\'<>?,.//\".JuST THIS',
			#'sql_insert'					=> '~`!@#$^&*()_+-=[]{}|;34:\\\\\'<>?,.//".JuST THIS',
			#'sql92_insert'					=> '~`!@#$^&*()_+-=[]{}|;34:\'\'<>?,.//".JuST THIS',
			'double_quote'					=> '~`!@#$^&*()_+-=[]\{}|;34:\\\'\<>?,.//\.JuST THIS',
			'htmlspecial'					=> '~`!@#$^&amp;*()_+-=[]\{}|;34:\\\'\&lt;&gt;?,.//\&quot;.JuST THIS',
			'htmlspecial_q'					=> '~`!@#$^&amp;*()_+-=[]\{}|;34:\\&#039;\&lt;&gt;?,.//\&quot;.JuST THIS',
			'htmlspecial_nq'				=> '~`!@#$^&amp;*()_+-=[]\{}|;34:\\\'\&lt;&gt;?,.//\".JuST THIS',
			'htmlentity'					=> '~`!@#$^&amp;*()_+-=[]\{}|;34:\\\'\&lt;&gt;?,.//\&quot;.JuST THIS',
			'htmlentity_plus_brackets'		=> '~`!@#&#36;^&amp;*()_+-=[]\&#123;&#125;|;34:\\\'\&lt;&gt;?,.//\&quot;.JuST THIS',
			'double_entity'					=> '~`!@#$^&amp;*()_+-=[]\{}|;34:\\\'\&lt;&gt;?,.//\.JuST THIS',
			'meta'							=> '~`!@#\$\^&\*\(\)_\+-=\[\]\\\\{}|;34:\\\\\'\\\<>\?,\.//\\\\"\.JuST THIS',
			'email'							=> '@_-34..JuSTTHIS',
			'email_plus_spaces'				=> '@_-34:..JuST THIS',
			'phone_fax'						=> '()+-34 ',
			'integer'						=> '-34',
			'numeric'						=> '-34',
			'decimal'						=> '34..',
			'float'							=> '34..',
			'name'							=> '\'JuSTTHIS',
			'names'							=> '\'JuSTTHIS',
			'alpha'							=> 'JuSTTHIS',
			'bool'							=> 't',
			#'varchar'						=> '~`!@#$^&*()_+-=[]{}|;34:\\\'<>?,.//".JuST THIS',
			'date'							=> '-34',
			'datetime'						=> '-34:\'.//.JuST THIS',
			'all'							=> '34JuSTTHIS'
		);
		
		foreach($testSQL as $name=>$expected) {
			$cleanedData = $gf->cleanString($cleanThis, $name);
			
			//NOTE::: passing "%" in the message data causes an exception with the simpletest framework.
			$this->assertEquals($expected, $cleanedData, "Cleaning test '". $name ."' FAILED...  expected=(". $expected ."), got (". $cleanedData ."), ");
		}
		
		
		//test quoting (with a few exceptions).
		$testQuotes = $testSQL;
		unset($testQuotes['none'], $testQuotes['sql92_insert']);
		foreach($testQuotes as $name=>$expected) {
			$gf->switch_force_sql_quotes(1);
			$cleanedDataPlusQuotes = $gf->cleanString($cleanThis, $name, 1);
			$this->assertEquals("'". $expected ."'", $cleanedDataPlusQuotes, "Failed quoting with style=(". $name .")");
			
			$gf->switch_force_sql_quotes(0);
			$this->assertEquals("'". $expected ."'", $cleanedDataPlusQuotes, "Failed quoting with style=(". $name .")");
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
			$this->assertEquals($gf->string_from_array($testSQL, 'insert'), $expected);
			
			$expected = "(column1, column two) VALUES ('\'my value \' OR \'x\'=\'x\'','Stuff')";
			$this->assertEquals($gf->string_from_array($testSQL, 'insert', null, 'sql'), $expected);
			
			$expected = "(column1, column two) VALUES ('\'my value \' OR \'x\'=\'x\'','Stuff')";
			$this->assertEquals($gf->string_from_array($testSQL, 'insert', null, 'sql_insert'), $expected);
			
			$expected = "(column1, column two) VALUES ('\'my value \' OR \'x\'=\'x\'','Stuff')";
			$this->assertEquals($gf->string_from_array($testSQL, 'insert', null, 'sql92_insert'), $expected);
			
			//now let's see what happens if we pass an array signifying how it should be cleaned.
			$expected = "(column1, column two) VALUES ('\'my value \' OR \'x\'=\'x\'','Stuff')";
			$this->assertEquals($gf->string_from_array($testSQL, 'insert', null, array('column1'=>'sql', 'column two'=>'sql')), $expected);
			$expected = "(column1, column two) VALUES ('\\\\\'my value \\\\\' OR \\\\\'x\\\\\'=\\\\\'x\\\\\'','Stuff')";
			$this->assertEquals($gf->string_from_array($testSQL, 'insert', null, array('column1'=>'sql_insert', 'column two'=>'sql_insert')), $expected);
			$expected = "(column1, column two) VALUES ('\'\'my value \'\' OR \'\'x\'\'=\'\'x\'\'','Stuff')";
			$this->assertEquals($gf->string_from_array($testSQL, 'insert', null, array('column1'=>'sql92_insert', 'column two'=>'sql92_insert')), $expected);
			
		}
		
		//make sure forceSqlQuotes is OFF.
		$gf->switch_force_sql_quotes(0);
		
		//Test the SELECT style.
		{
			//a basic set of criteria...
			$expected = "w='' AND x='y' AND y='0' AND z=''";
			$actual = $gf->string_from_array(array('w'=>'', 'x'=>"y", 'y'=>0,'z'=>NULL), 'select');
			$this->assertEquals($expected, $actual);
			
			//make sure it distinguishes between text "NULL" and literal NULL.
			$expected = "w='' AND x='y' AND y='0' AND z='NULL'";
			$actual = $gf->string_from_array(array('w'=>'', 'x'=>"y", 'y'=>0,'z'=>"NULL"), 'select');
			$this->assertEquals($expected, $actual);
			
			//make sure it distinguishes between text "NULL" and literal NULL.
			$expected = "w='' AND x='y' AND y='0' AND z='NULL'";
			$actual = $gf->string_from_array(array('w'=>'', 'x'=>"y", 'y'=>0,'z'=>"NULL"), 'select', null, 'sql');
			$this->assertEquals($expected, $actual);
			
			//check with specific cleaning styles.
			$expected = "w='' AND x='y' AND y='0' AND z='NULL'";
			$cleanString = array('w'=>"nonexistent", 'x'=>"alpha", 'y'=>"numeric", 'z'=>"sql");
			$actual = $gf->string_from_array(array('w'=>'', 'x'=>"y", 'y'=>0,'z'=>"NULL"), 'select', null, $cleanString);
			$this->assertEquals($expected, $actual);
		}
		
		
		//Test the UPDATE style.
		{
			//basic update.
			$expected = "w='', x='y', y='0', z=''";
			$actual = $gf->string_from_array(array('w'=>"", 'x'=>"y", 'y'=>0, 'z'=>NULL), 'update', null, 'sql');
			$this->assertEquals($expected, $actual);
			
			
			//basic update, but force SQL quotes...
			$gf->switch_force_sql_quotes(1);
			$expected = "w='', x='y', y='0', z=''";
			$actual = $gf->string_from_array(array('w'=>"", 'x'=>"y", 'y'=>0, 'z'=>NULL), 'update', null, 'sql');
			$this->assertEquals($expected, $actual);
			$gf->switch_force_sql_quotes(0);
			
			//update with invalid quotes (attempts at SQL injection)
			$expected = "w='\' ', x='\'', y='0', z=''";
			$actual = $gf->string_from_array(array('w'=>"' ", 'x'=>"'", 'y'=>0, 'z'=>NULL), 'update', null, 'sql');
			$this->assertEquals($expected, $actual);
		}
		
		
	}//end test_string_from_array()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_interpret_bool() {
		$gf=new cs_globalFunctions;
		
		$this->assertEquals($gf->interpret_bool('true'), true);
		$this->assertEquals($gf->interpret_bool(true), true);
		$this->assertEquals($gf->interpret_bool('false'), false);
		$this->assertEquals($gf->interpret_bool(false), false);
		$this->assertEquals($gf->interpret_bool('0'), false);
		$this->assertEquals($gf->interpret_bool('1'), true);
		$this->assertEquals($gf->interpret_bool(0), false);
		$this->assertEquals($gf->interpret_bool("000000"), false);
		$this->assertEquals($gf->interpret_bool(1), true);
		$this->assertEquals($gf->interpret_bool(0.1), true);
		$this->assertEquals($gf->interpret_bool(0.01), true);
		$this->assertEquals($gf->interpret_bool(0.001), true);
		$this->assertEquals($gf->interpret_bool('f'), false);
		$this->assertEquals($gf->interpret_bool('fa'), true);
		$this->assertEquals($gf->interpret_bool('fal'), true);
		$this->assertEquals($gf->interpret_bool('fals'), true);
		$this->assertEquals($gf->interpret_bool('t'), true);
		$this->assertEquals($gf->interpret_bool('tr'), true);
		$this->assertEquals($gf->interpret_bool('tru'), true);
		$this->assertEquals($gf->interpret_bool("1stuff"), true);
		$this->assertEquals($gf->interpret_bool(""), false);
		$this->assertEquals($gf->interpret_bool(" true  "), true);
		$this->assertEquals($gf->interpret_bool(" false  "), false);
		$this->assertEquals($gf->interpret_bool('false-showastrue'), true);
		$this->assertEquals($gf->interpret_bool('true-showastrue'), true);
		
		
		//now go through the same thing, but this time tell it to give back a specific value for true and false.
		$this->assertEquals($gf->interpret_bool(false, array(0=>'FaLSe',1=>"crap")), 'FaLSe');
		$this->assertEquals($gf->interpret_bool(true, array(0=>'FaLSe',1=>"crap")), 'crap');
		$this->assertEquals($gf->interpret_bool(false, array(0=>"crap",1=>'FaLSe')), 'crap');
		$this->assertEquals($gf->interpret_bool(true, array(0=>"crap",1=>'FaLSe')), 'FaLSe');
	}//end test_interpret_bool()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_mini_parser() {
		
		$gf = new cs_globalFunctions;
		
		//Basic test.
		{
			$stringToChange = '{{random-{number}-item}} {test}';
			$arrayOfVars = array(
				'number'		=> 5,
				'random-5-item'	=> "test",
				'test'			=> "SUCCESS"
			);
			$expectedOutput = 'SUCCESS SUCCESS';
			$actualOutput = $gf->mini_parser($stringToChange, $arrayOfVars, '{', '}');
			$this->assertEquals($expectedOutput, $actualOutput);
		}
		
		//Order of operations test.
		{
			$stringToChange = '{{random-{number}-item}} {test}';
			$arrayOfVars = array(
				'random-5-item'	=> "test",
				'number'		=> 5,
				'test'			=> "SUCCESS"
			);
			$expectedOutput = '{{random-5-item}} SUCCESS';
			$actualOutput = $gf->mini_parser($stringToChange, $arrayOfVars, '{', '}');
			$this->assertEquals($expectedOutput, $actualOutput);
			
			//if we put that same actualOutput through the ringer again, it comes up with the originally expected output.
			$expectedOutput = "SUCCESS SUCCESS";
			$actualOutput = $gf->mini_parser($actualOutput, $arrayOfVars, '{', '}');
			$this->assertEquals($expectedOutput, $actualOutput);
		}
		
		//some testing with the default begin/end strings.
		{
			$stringToChange = '%%%%random-%%number%%-item%%%% %%test%%';
			$arrayOfVars = array(
				'number'		=> 5,
				'random-5-item'	=> "test",
				'test'			=> "SUCCESS"
			);
			$expectedOutput = 'SUCCESS SUCCESS';
			$actualOutput = $gf->mini_parser($stringToChange, $arrayOfVars);
			$this->assertEquals($expectedOutput, $actualOutput);
		}
		
		//A stupid test to make sure we can specify different begin/end var identifiers.
		
		{
			$stringToChange = '__BEGIN____BEGIN__random-__BEGIN__number__END__-item__END____END__ __BEGIN__test__END__';
			$arrayOfVars = array(
				'number'		=> 5,
				'random-5-item'	=> "test",
				'test'			=> "SUCCESS"
			);
			$expectedOutput = 'SUCCESS SUCCESS';
			$actualOutput = $gf->mini_parser($stringToChange, $arrayOfVars, '__BEGIN__', '__END__');
			$this->assertEquals($expectedOutput, $actualOutput);
		}
		
	}//end test_mini_parser()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_truncate_string() {
		
		$gf = new cs_globalFunctions;
		
		//basic test.
		{
			$length = 15;
			$string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean et mi scelerisque massa consequat adipiscing.";
			$looseFinal = "Lorem ipsum dol...";
			$strictFinal= "Lorem ipsum ...";
			
			$this->assertEquals($looseFinal, $gf->truncate_string($string, $length));
			$this->assertEquals($looseFinal, $gf->truncate_string($string, $length, '...'));
			$this->assertEquals($looseFinal, $gf->truncate_string($string, $length, '...', false));
			$this->assertEquals($looseFinal, $gf->truncate_string($string, $length, '...', 0));
			$this->assertEquals($looseFinal, $gf->truncate_string($string, $length, '...', null));
			
			
			$this->assertEquals($strictFinal, $gf->truncate_string($string, $length, '...', true));
			$this->assertEquals($strictFinal, $gf->truncate_string($string, $length, '...', 1));
			$this->assertEquals($strictFinal, $gf->truncate_string($string, $length, '...', "Do it"));
			
			
			$this->assertNotEquals($looseFinal, $gf->truncate_string($string, $length, '...', true));
			$this->assertNotEquals($looseFinal, $gf->truncate_string($string, $length, '...', 1));
			$this->assertNotEquals($looseFinal, $gf->truncate_string($string, $length, '...', "Do it"));
		}
		
		//advanced test: give it a final length of *near* the length of the string & see what happens.
		{
			
			$length = 56;
			$string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
			$string2= "Lorem ipsum dolor sit amet, consectetur adipiscing elit...";
			$string3= "Lorem ipsum dolor sit amet, consectetur adipiscing eli...";
			$string54= "Lorem ipsum dolor sit amet, consectetur adipiscing ...";
			$string55= "Lorem ipsum dolor sit amet, consectetur adipiscing e...";
			$string56= "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
			
			//make sure the initial string is ACTUALLY 56 characters long.
			$this->assertEquals($length, strlen($string));
			
			$this->assertEquals($string,  $gf->truncate_string($string, 56, '...', false));
			$this->assertEquals($string2, $gf->truncate_string($string, 55, '...', false));
			$this->assertEquals($string3, $gf->truncate_string($string, 54, '...', false));
			
			$this->assertEquals($string56, $gf->truncate_string($string, 56, '...', true));
			$this->assertEquals(56, strlen($gf->truncate_string($string, 56, '...', true)));
			
			$this->assertEquals($string55, $gf->truncate_string($string, 55, '...', true));
			$this->assertEquals(55, strlen($gf->truncate_string($string, 55, '...', true)));
			
			$this->assertEquals($string54, $gf->truncate_string($string, 54, '...', true));
			$this->assertEquals(54, strlen($gf->truncate_string($string, 54, '...', true)));
		}
		
	}//end truncate_string()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_create_list() {
		
		$gf = new cs_globalFunctions;
		
		$items = array(
			"", "one", "'TWO", "thr'ee", "four", "^five", "six'"
		);
		$noSqlRes = "one, 'TWO, thr'ee, four, ^five, six'";
		$sqlRes = "'', 'one', ''TWO', 'thr'ee', 'four', '^five', 'six''";
		
		$checkNoSql = null;
		$checkSql = null;
		foreach($items as $str) {
			$checkNoSql = $gf->create_list($checkNoSql, $str, ", ", 0);
			$checkSql = $gf->create_list($checkSql, $str, ", ", 1);
		}
		
		$this->assertEquals($checkNoSql, $noSqlRes);
		$this->assertEquals($checkSql, $sqlRes);
		
	}//end test_create_list()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	function test_clean_url() {
		$testUrls = array(
			"testNulls"		=> NULL,
			"testEmpty"		=> array("", NULL),
			"root"			=> "",
			"simple"		=> array("/index.php/test.html","index/test"),
			"complex"		=> array("/x.xyz/y.123/_x/-y/*z", "x/y/_x/-y/*z"),
			"noLeadingSlash"=> array("page/stuff.html", "page/stuff"),
		);
		$gf = new cs_globalFunctions;
		foreach($testUrls as $testName=>$cleanThis) {
			if(is_array($cleanThis)) {
				$expectThis = $cleanThis[1];
				$cleanThis = $cleanThis[0];
			}
			else {
				$expectThis = $cleanThis;
			}
			$actualOutput = $gf->clean_url($cleanThis);
			$this->assertEquals($expectThis, $actualOutput, "failed test '". $testName ."', expected=(". $expectThis ."), actualOutput=(". $actualOutput .")");
		}
	}//end test_clean_url()
	//-------------------------------------------------------------------------
	
	
	
	
}//end TestOfCSGlobalFunctions
//=============================================================================
?>
