<?php

class cs_templateReader_file implements cs_template_reader {
	
	protected $source = NULL;

	public function __construct($templateLocation) {
		$this->source = $templateLocation;
	}
	
	public function read() {
		if(file_exists($this->source)) {
			$retval = file_get_contents($this->source);
		}
		else {
cs_debug_backtrace(1);
cs_global::debug_print($this,1);
			throw new exception(__METHOD__ .": file does not exist (". $this->source .")");
		}
		return($retval);
	}//end read()
	
	
	public function getSource() {
		return($this->source);
	}//end getSource()
}

?>
