<?php
require_once(dirname(__FILE__) .'/interface/cs_template_parser.interface.php');
require_once(dirname(__FILE__) .'/interface/cs_template_reader.interface.php');
require_once(dirname(__FILE__) .'/interface/cs_template_writer.interface.php');

class cs_template {
	
	protected $location;
	protected $parser;
	
	public function __construct($type, $location) {
		$reader = cs_template_Factory::getReader($type, $location);
		$reader->read();
		$this->parser = cs_template_Factory::getParser($type, $reader);
	}//end __construct()
	
	
	
	public function __get($varName) {
		if(!isset($this->$varName)) {
			throw new exception(__METHOD__ .": '". $varName ."' does not exist");
		}
		return($this->$varName);
	}//end __get()
	
	
	
	public function __call($methodName, $args) {
		if(method_exists($this->parser, $methodName)) {
			$retval = call_user_func_array(array($this->parse, $methodName), $args);
		}
		else {
			throw new exception(__METHOD__ .": invalid method (". $methodName .")");
		}
		return($retval);
	}//end __call()
}

class testContentSystem {

	public function testBasics() {
		$tmplObj = new cs_template('file', 'main.shared.tmpl');
		//setup some default template vars.
		$defaultVars = array(
			'date'			=> date('m-d-Y'),
			'time'			=> date('H:i:s'),
			'curYear'		=> date('Y'),
			'curDate'		=> date("F j, Y"),
			'curMonth'		=> date("m"),
			'timezone'		=> date("T"),
			'DOMAIN'		=> $_SERVER['SERVER_NAME'],
			//'PHP_SELF'		=> $_SERVER['SCRIPT_NAME'],		// --> set in finish().
			'REQUEST_URI'	=> $_SERVER['REQUEST_URI'],
			'FULL_URL'		=> $_SERVER['HTTP_HOST'] . $_SERVER['SCRIPT_NAME'],
			'error_msg'		=> ""
		);
		foreach($defaultVars as $k=>$v) {
			$tmplObj->addVar($k, $v);
		}

		$this->assertEqual(file_get_contents('path/to/parsed_template'), $tmplObj->parse());
	}
}
?>
