<?php

class cs_templateReader_file implements cs_template_reader {
	
	protected $source = NULL;
	
	public function read($location) {
		if(file_exists($location)) {
			$retval = file_get_contents($location);
			$this->source = $retval;
		}
		else {
			throw new exception(__METHOD__ .": file does not exist (". $location .")");
		}
		return($retval);
	}//end read()
	
	
	public function getSource() {
		return($this->source);
	}//end getSource()
}

?>
