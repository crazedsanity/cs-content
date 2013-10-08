<?php

class cs_template_Factory {
	public static function getReader($type, $location) {
		$class = 'cs_templateReader_'. $type;
		if(!class_exists($class)) {
			throw new exception(__METHOD__ .": unsupported reader (". $type .")");
		}
		elseif(is_null($location)) {
cs_debug_backtrace(1);
			throw new exception(__METHOD__ .": invalid location (". $location .")");
		}
		return(new $class($location));
	}//end getReader()
	
	
	
	public static function getWriter($type, cs_template_reader $reader) {
		$class = 'cs_templateWriter_'. $type;
		if(!class_exists($class)) {
			throw new exception(__METHOD__ .": unsupported writer (". $type .")");
		}
		return(new $class($reader));
	}//end getWriter()
	
	
	
	public static function getParser($type, cs_template_reader $reader) {
		$class = 'cs_templateParser_'. $type;
		if(!class_exists($class)) {
			throw new exception(__METHOD__ .": unsupported parser (". $type .")");
		}
		return new $class($reader);
	}//end getParser()
}
