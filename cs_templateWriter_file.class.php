<?php

class cs_templateWriter_file implements cs_template_writer {
	public function write(cs_template $tmpl) {
		try {
			$retval = file_put_contents($tmpl->location, $tmpl->parse());
		}
		catch(Exception $ex) { // if methods from cs_template_writer throw exceptions
			throw new exception(__METHOD__ .": failed to write the file::: ". $ex->getMessage . $ex->getTraceAsString());
		}
		return($retval);
	}//end write()
}

?>
