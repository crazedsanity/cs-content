<?php

class cs_templateParser_file implements cs_template_parser {
	//TODO: allow custom start/end definition for rows & vars
	//TODO: allow custom definition of maxDepth
	
	protected $vars = array();	// var names and their values
	protected $rows = array();	// row names and their PARSED values
	protected $source = NULL;
	protected $maxDepth = 10;
	
	//--------------------------------------------------------------------------
	public function __construct(cs_template_reader $reader) {
		$this->source = $reader->getSource();
	}//end __construct()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function getVars() {
		return($this->vars);
	}//end getVars()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function findDefinedVars() {
		$retval = array();
		preg_match_all('/\{.\S+?\}/', $this->source, $retval);
		
		return($retval);
	}//end findDefinedVars()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function defineVar($varName, $definition=NULL) {
		$this->vars[$varName] = $definition;
	}//end defineVar()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function manualParse($varName, $varValue, $subject) {
		$numLoops = 0;
		$retval = $subject;
		while(preg_match('/\{'. $varName .'\}/', $retval) && $numLoops > $this->maxDepth) {
			$retval = preg_replace('/\{'. $varName .'\}/', $varValue);
		}
		return($retval);
	}//end manualParse()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function replaceAllVars() {
		$parsedSource = $this->source;
		$numLoops = 0;
		while(preg_match('/\{.\S+?\}/', $parsedSource) && $numLoops < $this->maxDepth) {
			foreach($this->vars as $name=>$value) {
				$parsedSource = $this->manualParse($name, $value, $parsedSource);
			}
			$numLoops++;
		}
		return($parsedSource);
	}//end replaceAllVars()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function getSingleVar($varName) {
		return($this->vars[$varName]);
	}//end getSingleVar()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function getRows() {
		return($this->rows);
	}//end getRows()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function defineRow($rowName, $definition) {
		$this->rows[$rowName] = $definition;
	}//end defineRow()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function replaceAllRows() {
		//TODO: finish replaceRows()
	}//end replaceAllRows()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function findDefinedRows() {
		$retval = array();
		$regex = '<!-- BEGIN \S+? -->{.+}{0,}<!-- END \S+? -->';
		preg_match_all($regex, $this->source, $retval);
		
		return($retval);
	}//end findDefinedRows()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function getSingleRow($rowName) {
		return($this->rows[$rowName]);
	}//end getSingleRow()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function parseRow($rowName, array $dataArray, $dataArrayIndexPlaceHolder=NULL) {//TODO: finish parseRow()
		if(isset($this->rows[$rowName])) {
			$parsedRows = "";
			foreach($dataArray as $index => $data) {
				$currentRow = $this->rows[$rowName];
				if(!is_null($dataArrayIndexPlaceHolder)) {
					$currentRow = $this->manualParse($dataArrayIndexPlaceHolder, $index, $currentRow);
				}
				foreach($data as $varName=>$varValue) {
					$currentRow = $this->manualParse($varName, $varValue, $currentRow);
				}
				$parsedRows .= $currentRow;
			}
		}
		else {
			throw new exception(__METHOD__ .": no such row '". $rowName ."'");
		}
		
		return($parsedRows);
	}//end parseRow()
	//--------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------
	public function parse($stripUndefinedVars=TRUE) {
		//TODO: finish parse()
	}//end parse()
	//--------------------------------------------------------------------------
}

?>
