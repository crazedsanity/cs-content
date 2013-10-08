<?php

interface cs_template_parser {
	public function getVars();
	public function defineVar($varName, $definition);
	public function replaceAllVars();
	public function getSingleVar($varName);
	public function findDefinedVars();

	public function getRows();
	public function defineRow($rowName, $definition);
	public function replaceAllRows();
	public function getSingleRow($rowName);
	public function parseRow($rowName, array $dataArray, $dataArrayIndexPlaceHolder=NULL);
	public function findDefinedRows();

	/**
	 * Replace all possible template vars with those that are defined, remove 
	 * all undefined rows/vars, and return the parsed string. 
	 */
	public function parse($stripUndefinedVars=TRUE);
	
	
	public function manualParse($varName, $varValue, $subject);
}

?>
