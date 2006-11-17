<?php

class globalFunctions {

	//##########################################################################
	public function conditional_header($url)
	{
		//checks to see if headers were sent; if yes: use a meta redirect.
		//	if no: send header("location") info...
	
	
		if(headers_sent())
		{
			//headers sent.  Use the meta redirect.
			print "
			<HTML>
			<HEAD>
			<TITLE>Redirect Page</TITLE>
			<META HTTP-EQUIV='refresh' content='0; URL=$url'>
			</HEAD>
			<a href=\"$url\"></a>
			</HTML>
			";
		}
		else header("location:$url");
	}//end conditional_header()
	//##########################################################################
	
	
	//##########################################################################
	public function string_from_array($array,$style=NULL,$separator=NULL, $cleanString=NULL, $removeEmptyVals=FALSE) {
		/**
		 * Basically, just a wrapper for create_list(), which returns a list or 
		 * an array of lists, depending upon what was requested.
		 * 
		 * @param $array		<array> list for the array...
		 * @param $style		<str,optional> what "style" it should be returned 
		 *                         as (select, update, etc).
		 * @param $separator	<str,optional> what separattes key from value: see each
		 * 							style for more information.
		 * @param $cleanString	<mixed,optional> clean the values in $array by sending it
		 * 							to cleanString(), with this as the second argument.
		 * @param $removeEmptyVals	<bool,optional> If $cleanString is an ARRAY and this
		 * 							evaluates as TRUE, indexes of $array whose values have
		 *							a length of 0 will be removed.
		 *
		 * TODO: explain return values
		 * TODO: look into a better way of implementing the $removeEmptyVals thing.
		 */
		
		//precheck... if it's not an array, kill it.
		if(!is_array($array)) {
			return(0);
		}
		
		//make sure $style is valid.
		$typesArr = array("insert", "update");
		$style = strtolower($style);
		
		if(is_array($array)) {
		
			//if $cleanString is an array, assume it's arrayIndex => cleanStringArg
			if(is_array($cleanString) && (!is_null($style) && (strlen($style)))) {
				$cleanStringArr = array_intersect_key($cleanString, $array);
				if(count($cleanStringArr) > 0 && is_array($cleanStringArr)) {
					foreach($cleanStringArr as $myIndex=>$myCleanStringArg) {
						if(($removeEmptyVals) && (strlen($array[$myIndex]) == 0)) {
							//remove the index.
							unset($array[$myIndex]);
						} else {
							//now format it properly.
							$array[$myIndex] = cleanString($array[$myIndex], $myCleanStringArg);
						}
					}
				}
			}
			switch($style) {
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				case "insert":
				if(!$separator) {
					$separator = " VALUES ";
				}
				//build temporary data...
				foreach($array as $key=>$value) {
					$tmp[0] = create_list($tmp[0], $key);
					//clean the string, if required.
					if($cleanString) {
						//make sure it's not full of poo...
						$value = cleanString($value, "sql");
						$value = "'". $value ."'";
					}
					if((is_null($value)) OR ($value == "")) {
						$value = "NULL";
					}
					$tmp[1] = create_list($tmp[1], $value);
				}
				
				//make the final product.
				$retval = "(". $tmp[0] .")" . $separator . "(". $tmp[1] .")";
				break;
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				case "update":
				if(!$separator) {
					$separator = "=";
				}
				//build final product.
				foreach($array as $field=>$value) {
					if($cleanString && !preg_match('/^\'/',$value)) {
						//make sure it doesn't have crap in it...
						$value = cleanString($value, "sql");
						$value = "'". $value ."'";
					}
					$retval = create_list($retval, $field . $separator . $value);
				}
				break;
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				case "order":
				case "limit":
				//for creating the "limit 50 offset 35" part of a query... or at least using that "style".
				$separator = " ";
				//build final product.
				foreach($array as $field=>$value) {
					if($cleanString) {
						//make sure it doesn't have crap in it...
						$value = cleanString($value, "sql");
						$value = "'". $value ."'";
					}
					$retval = create_list($retval, $field . $separator . $value, " ");
				}
				if($style == "order" && !preg_match('/order by/', strtolower($retval))) {
					$retval = "ORDER BY ". $retval;
				}
				break;
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				case "select":
				//build final product.
				$separator = "=";
				foreach($array as $field=>$value) {
					
					//allow for tricksie things...
					/*
					 * Example: 
					 * string_from_array(array("y"=>3, "x" => array(1,2,3))); 
					 * 
					 * would yield: "y=3 AND (x=1 OR x=2 OR x=3)"
					 */
					$delimiter = "AND";
					if(is_array($value)) {
						//doing tricksie things!!!
						$retval = create_list($retval, $field ." IN (". string_from_array($value) .")", " $delimiter ");
					} else {
						//if there's already an operator ($separator), don't specify one.
						if(preg_match('/^[\(<=>]/', $value)) {
							$separator = NULL;
						}
						if($cleanString) {
							//make sure it doesn't have crap in it...
							$value = cleanString($value, "sql");	
						}
						if(!is_numeric($value) && isset($separator))
						{
							$value = "'". $value ."'";	
						}
						$retval = create_list($retval, $field . $separator . $value, " $delimiter ");
					}
				}
				break;
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				
				
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				case "url":{
					//an array like "array('module'='todo','action'='view','ID'=164)" to "module=todo&action=view&ID=164"
					if(!$separator) {
						$separator = "&";
					}
					foreach($array as $field=>$value) {
						if($cleanString && !is_array($cleanString)) {
							$value = cleanString($value, $cleanString);
						}
						$retval = create_list($retval, "$field=$value", $separator);
					}
				}
				break;
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				
				
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				case "text_list":{
					if(is_null($separator)) {
						$separator = '=';
					}
					foreach($array as $field=>$value) {
						$retval = create_list($retval, $field . $separator . $value, "\n");
					}
				}
				break;
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				
				
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				case "html_list":{
					if(is_null($separator)) {
						$separator = '=';
					}
					foreach($array as $field=>$value) {
						$retval = create_list($retval, $field . $separator . $value, "<BR>\n");
					}
				}
				break;
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				
				
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				DEFAULT:
				if(!$separator) {
					$separator = ", ";
				}
				foreach($array as $field=>$value) {
					if($cleanString) {
						$value = cleanString($value, $cleanString);
					}
					$retval = create_list($retval, $value, $separator);
				}
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			}
		} else {
			//not an array.
			$retval = 0;
		}
		
		return($retval);
	}//end string_from_array()
	//##########################################################################
	
	
	
	
	//##########################################################################
	public function create_list($string=NULL, $addThis=NULL, $delimiter=", ") {
		//////////////////////////////////////////////////////////////////
		//RETURNS A COMMA-DELIMITED LIST OF ITEMS... IF	WE		//
		//	WANTED TO GET A LIST OF THINGS W/COMMAS, WE'D 		//
		//	NORMALLY HAVE TO RUN ALL THIS CODE IN THE SCRIPT...	//
		//	$list = array("x", "y");				//
		//								//
		//	NOW IT WOULD LOOK SOMETHING LIKE:			//
		//	foreach ($list as $item) {				//
		//		$newList = this_function($newList,$item);	//
		//	}							//
		//////////////////////////////////////////////////////////////////
	
		if($string) {
			$retVal = $string . $delimiter . $addThis;
		} else {
			$retVal = $addThis;
		}
	
		return($retVal);
	} //end create_comma_delimited_list()
	//##########################################################################
	
	
	
	
	
	
	//##########################################################################
	public function debug_print($input=NULL, $printItForMe=NULL) {
		//////////////////////////////////////////////////////////////////
		// WRAPS GIVEN $input IN <pre> TAGS: WORKS NICELY WHEN PRINTING	//
		//	AN ARRAY TO THE SCREEN.					//
		//								//
		// INPUTS:::							//
		//	$input		Information to print/return.		//
		//	$printItForMe	Print it.				//
		// OUTPUTS:::							//
		//	<string>	Returns "<pre>\n$input\n<pre>\n"	//
		//////////////////////////////////////////////////////////////////
	
		if(!is_numeric($printItForMe)) {
			$printItForMe = $GLOBALS['DEBUGPRINTOPT'];
		}
		$printItForMe = 1;
	
		ob_start();
		print_r($input);
		$output = ob_get_contents();
		ob_end_clean();
	
		$output = "<pre>\n$output\n</pre>\n";
	
		if(!$_SERVER['SERVER_PROTOCOL']) {
			$output = strip_tags($output);
			$hrString = "***************************************************************\n";
		} else {
			$hrString = "<hr>";
		}
	
		if($printItForMe) {
			print "$output". $hrString ."\n";
		}
	
		return($output);
	} //end debug_print()
	//##########################################################################
	
	

}

?>
