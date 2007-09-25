<?php

require_once(dirname(__FILE__) ."/cs_versionAbstract.class.php");

class cs_globalFunctions extends cs_versionAbstract {
	
	
	/* DEBUG PRINT OPTIONS */
	/** Remove the separator below the output of each debug_print()? */
	public $debugRemoveHr = 0;
	public $debugPrintOpt = 1;
	
	//=========================================================================
	public function __construct() {
		//These checks have been implemented for pseudo backwards-compatibility 
		//	(internal vars won't change if GLOBAL vars changed).
		if(isset($GLOBALS['DEBUGREMOVEHR'])) {
			$this->debugRemoveHr = $GLOBALS['DEBUGREMOVEHR'];
		}
		if(isset($GLOBALS['DEBUGPRINTOPT'])) {
			$this->debugPrintOpt = $GLOBALS['DEBUGPRINTOPT'];
		}
	}//end __construct()
	//=========================================================================
	
	
	
	//================================================================================================================
	/**
	 * Automatically selects either the header() function, or printing meta-refresh data for redirecting a browser.
	 */
	public function conditional_header($url, $exitAfter=TRUE, $permRedir=FALSE) {
		
		if(!strlen($url)) {
			throw new exception(__METHOD__ .": failed to specify URL (". $url .")");
		}
		else {
			if(headers_sent()) {
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
			else {
				if($permRedir) {
					//NOTE: can't do much for permanent redirects if headers have already been sent.
					header("HTTP/1.1 301 Moved Permanently");
				}
				header("location:$url");
			}
		}
		
		if($exitAfter) {
			exit;
		}
	}//end conditional_header()
	//================================================================================================================
	
	
	
	//================================================================================================================
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
	 */
	public function string_from_array($array,$style=NULL,$separator=NULL, $cleanString=NULL, $removeEmptyVals=FALSE) {
		
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
						}
						else {
							//now format it properly.
							$array[$myIndex] = $this->cleanString($array[$myIndex], $myCleanStringArg);
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
					$tmp[0] = $this->create_list($tmp[0], $key);
					//clean the string, if required.
					if($cleanString) {
						//make sure it's not full of poo...
						$value = $this->cleanString($value, "sql");
						$value = "'". $value ."'";
					}
					if((is_null($value)) OR ($value == "")) {
						$value = "NULL";
					}
					$tmp[1] = $this->create_list($tmp[1], $value);
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
					$sqlQuotes = 1;
					if($value === "NULL" || $value === NULL) {
						$sqlQuotes = 0;
					}
					if($cleanString && !preg_match('/^\'/',$value)) {
						//make sure it doesn't have crap in it...
						$value = $this->cleanString($value, "sql",$sqlQuotes);
					}
					$retval = $this->create_list($retval, $field . $separator . $value);
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
						$value = $this->cleanString($value, "sql");
						$value = "'". $value ."'";
					}
					$retval = $this->create_list($retval, $field . $separator . $value, " ");
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
						$retval = $this->create_list($retval, $field ." IN (". $this->string_from_array($value) .")", " $delimiter ");
					}
					else {
						//if there's already an operator ($separator), don't specify one.
						if(preg_match('/^[\(<=>]/', $value)) {
							$separator = NULL;
						}
						if($cleanString) {
							//make sure it doesn't have crap in it...
							$value = $this->cleanString($value, "sql");	
						}
						if(!is_numeric($value) && isset($separator)) {
							$value = "'". $value ."'";	
						}
						$retval = $this->create_list($retval, $field . $separator . $value, " $delimiter ");
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
							$value = $this->cleanString($value, $cleanString);
						}
						$retval = $this->create_list($retval, "$field=$value", $separator);
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
						$retval = $this->create_list($retval, $field . $separator . $value, "\n");
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
						$retval = $this->create_list($retval, $field . $separator . $value, "<BR>\n");
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
						$value = $this->cleanString($value, $cleanString);
					}
					$retval = $this->create_list($retval, $value, $separator);
				}
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			}
		}
		else {
			//not an array.
			$retval = 0;
		}
		
		return($retval);
	}//end string_from_array()
	//================================================================================================================
	
	
	
	//================================================================================================================
	/**
	 * Easy way of cleaning data using types/styles of cleaning, with optional quoting.
	 * 
	 * @param $cleanThis		(str) data to be cleaned
	 * @param $cleanType		(str,optional) how to clean the data.
	 * @param $sqlQuotes		(bool,optional) quote the string for SQL
	 * 
	 * @return (string)			Cleaned data.
	 */
	function cleanString($cleanThis=NULL, $cleanType="all",$sqlQuotes=0) {
		$cleanType = strtolower($cleanType);
		switch ($cleanType) {
			case "none":
				//nothing to see here (no cleaning wanted/needed).  Move along.
				$sqlQuotes = 0;
			break;
			
			case "query":
				/*
					replace \' with '
					gets rid of evil characters that might lead to SQL injection attacks.
					replace line-break characters
				*/
				$evilChars = array("\$", "%", "~", "*",">", "<", "-", "{", "}", "[", "]", ")", "(", "&", "#", "?", ".", "\,","\/","\\","\"","\|","!","^","+","`","\n","\r");
				$cleanThis = preg_replace("/\|/","",$cleanThis);
				$cleanThis = str_replace($evilChars,"", $cleanThis);
				$cleanThis = stripslashes(addslashes($cleanThis));
			break;
			
			case "sql":
				$cleanThis = addslashes(stripslashes($cleanThis));
			break;
			
			
			case "sql_insert":
				/*
				 * This is for descriptive fields, where double quotes don't need to be escaped: in these 
				 * cases, escaping the double-quotes might lead to inserting something that looks different 
				 * than the original, but in fact is identical. 
				 */
				$cleanThis = addslashes(stripslashes($cleanThis));
				$cleanThis = preg_replace('/\\\\"/', '"', $cleanThis);
			break;
			
			case "double_quote":
				//This will remove all double quotes from a string.
				$cleanThis = str_replace('"',"",$cleanThis);
			break;
	
			case "htmlspecial":
				/*
				This function is useful in preventing user-supplied text from containing HTML markup, such as in a message board or guest book application. 
					The translations performed are:
				      '&' (ampersand) becomes '&amp;'
				      '"' (double quote) becomes '&quot;'.
				      '<' (less than) becomes '&lt;'
				      '>' (greater than) becomes '&gt;' 
				*/
	
				$cleanThis = htmlspecialchars($cleanThis);
			break;
	
			case "htmlspecial_q":
			/*
				'&' (ampersand) becomes '&amp;'
				'"' (double quote) becomes '&quot;'.
				''' (single quote) becomes '&#039;'.
				'<' (less than) becomes '&lt;'
				'>' (greater than) becomes '&gt;
			*/
				$cleanThis = htmlspecialchars($cleanThis,ENT_QUOTES);
			break;
	
			case "htmlspecial_nq":
			/*
				'&' (ampersand) becomes '&amp;'
				'<' (less than) becomes '&lt;'
				'>' (greater than) becomes '&gt;
			*/
				$cleanThis = htmlspecialchars($cleanThis,ENT_NOQUOTES);
			break;
	
			case "htmlentity":
				/*	
					Convert all applicable text to its html entity
					Will convert double-quotes and leave single-quotes alone
				*/
				$cleanThis = htmlentities(html_entity_decode($cleanThis));
			break;
	
			case "htmlentity_plus_brackets":
				/*	
					Just like htmlentity, but also converts "{" and "}" (prevents template 
					from being incorrectly parse).
					Also converts "{" and "}" to their html entity.
				*/
				$cleanThis = htmlentities(html_entity_decode($cleanThis));
				$cleanThis = str_replace('$', '&#36;', $cleanThis);
				$cleanThis = str_replace('{', '&#123;', $cleanThis);
				$cleanThis = str_replace('}', '&#125;', $cleanThis);
			break;
	
			case "double_entity":
				//Removed double quotes, then calls html_entities on it.
				$cleanThis = str_replace('"',"",$cleanThis);
				$cleanThis = htmlentities(html_entity_decode($cleanThis));
			break;
		
			case "meta":
				// Returns a version of str with a backslash character (\) before every character that is among these:
				// . \\ + * ? [ ^ ] ( $ )
				$cleanThis = quotemeta($cleanThis);
			break;
	
			case "email":
				//Remove all characters that aren't allowed in an email address.
				$cleanThis = preg_replace("/[^A-Za-z0-9\._@-]/","",$cleanThis);
			break;
	
			case "email_plus_spaces":
				//Remove all characters that aren't allowed in an email address.
				$cleanThis = preg_replace("/[^A-Za-z0-9\ \._@-]/","",$cleanThis);
			break;
	
			case "phone_fax":
				//Remove everything that's not numeric or +()-   example: +1 (555)-555-2020 is valid
				$cleanThis = preg_replace("/[^0-9-+() ]/","",$cleanThis);
			break;
			
			case "integer":
			case "numeric":
				//Remove everything that's not numeric.
				$cleanThis = preg_replace("/[^0-9]/","",$cleanThis);
			break;
			
			case "decimal":
			case "float":
				//same as integer only the decimal point is allowed
				$cleanThis = preg_replace("/[^0-9\.]/","",$cleanThis);
			break;
			
			case "name":
			case "names":
				//removes everything in the "alpha" case, but allows "'".
				$cleanThis = preg_replace("/[^a-zA-Z']/", "", $cleanThis);
			break;
	
			case "alpha":
				//Removes anything that's not English a-zA-Z
				$cleanThis = preg_replace("/[^a-zA-Z]/","",$cleanThis);
			break;
			
			case "bool":
			case "boolean":
				//makes it either T or F (gotta lower the string & only check the first char to ensure accurate results).
				$cleanThis = interpret_bool($cleanThis, array('f', 't'));
			break;
			
			case "varchar":
				$cleanThis=$this->cleanString($cleanThis,"query");
				$cleanThis="'" . $cleanThis . "'";
				if($cleanThis == "''") {
					$cleanThis="NULL";	
				}
			break;
			
			case "date":
				$cleanThis = preg_replace("/[^0-9\-]/","",$cleanThis);
				break;
				
			case "datetime":
				$cleanThis=preg_replace("/[^A-Za-z0-9\/: \-\'\.]/","",$cleanThis);
				if(!preg_match('/\'/', $cleanThis)) {
					$cleanThis="'" . $cleanThis . "'";
				}
			break;
				
			case "all":
			default:
				// 1. Remove all naughty characters we can think of except alphanumeric.
				$cleanThis = preg_replace("/[^A-Za-z0-9]/","",$cleanThis);
			break;
	
		}
		if($sqlQuotes) {
			$cleanThis = "'". $cleanThis ."'";
		}
		return $cleanThis;
	}//end cleanString()
	//================================================================================================================
	
	
	
	
	//================================================================================================================
	/**
	 * Returns a list delimited by the given delimiter.  Does the work of checking if the given variable has data
	 * in it already, that needs to be added to, vs. setting the variable with the new content.
	 */
	public function create_list($string=NULL, $addThis=NULL, $delimiter=", ") {
		if($string) {
			$retVal = $string . $delimiter . $addThis;
		}
		else {
			$retVal = $addThis;
		}
	
		return($retVal);
	} //end create_list()
	//================================================================================================================
	
	
	
	//================================================================================================================
	/**
	 * A way of printing out human-readable information, especially arrays & objects, either to a web browser or via
	 * the command line.
	 * 
	 * @param $input		(mixed,optional) data to print/return
	 * @param $printItForMe	(bool,optional) whether it should be printed or just returned.
	 * 
	 * @return (string)		printed data.
	 */
	public function debug_print($input=NULL, $printItForMe=NULL, $removeHR=NULL) {
		if(!is_numeric($removeHR)) {
			$removeHR = $this->debugRemoveHr;
		}

		if(!is_numeric($printItForMe)) {
			$printItForMe = $this->debugPrintOpt;
		}
		
		ob_start();
		print_r($input);
		$output = ob_get_contents();
		ob_end_clean();
	
		$output = "<pre>$output</pre>";
	
		if(!$_SERVER['SERVER_PROTOCOL']) {
			$output = strip_tags($output);
			$hrString = "\n***************************************************************\n";
		}
		else {
			$hrString = "<hr>";
		}
		if($removeHR) {
			unset($hrString);
		}
		
		if($printItForMe) {
			print "$output". $hrString ."\n";
		}
	
		return($output);
	} //end debug_print()
	//================================================================================================================
	
	
	
	//================================================================================================================
	function swapValue(&$value, $c1, $c2) {
		if(!$value) {
			$value = $c1;
		}
	
	
		/* choose the next color */
		if($value == "$c1") {
			$value = "$c2";
		}
		else {
			$value = "$c1";
		}
	
		return($value);
	}
	//================================================================================================================



	//---------------------------------------------------------------------------------------------
	/**
	 * Using the given template, it will replace each index (in $repArr) with it's value: each
	 * var to be replaced must begin the given begin & end delimiters.
	 * 
	 * @param $template		(str) Data to perform the replacements on.
	 * @param $repArr		(array) Array of name=>value pairs, where name is to be replaced with value.
	 * @param $b			(str,optional) beginning delimiter.
	 * @param $e			(str,optional) ending delimiter.
	 */
	public function mini_parser($template, $repArr, $b='%%', $e='%%') {
		if(!isset($b) OR !isset($e)){
			$b="{";
			$e="}";
		}

		foreach($repArr as $key=>$value) {
			//run the replacements.
			$key = "$b" . $key . "$e";
			$template = str_replace("$key", $value, $template);
		}

		return($template);
	}//end mini_parser()
	//---------------------------------------------------------------------------------------------
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Takes the given string & truncates it so the final string is the given 
	 * maximum length.  Optionally adds a chunk of text to the end, and also 
	 * optionally STRICTLY truncates (non-strict means the endString will be 
	 * added blindly, while strict means the length of the endString will be 
	 * subtracted from the total length, so the final string is EXACTLY the 
	 * given length or shorter).
	 * 
	 * @param string		(str) the string to truncate
	 * @param $maxLength	(int) maximum length for the result.
	 * @param $endString	(str,optional) this is added to the end of the 
	 * 							truncated string, if it exceeds $maxLength
	 * @param $strict		(bool,optional) if non-strict, the length of 
	 * 							the return would be $maxLength + length($endString)
	 */
	function truncate_string($string,$maxLength,$endString="...",$strict=FALSE) {
	
		//determine if it's even worth truncating.
		$strLength = strlen($string);
		if($strLength <= $maxLength) {
			//no need to truncate.
			$retval = $string;
		}
		else {
			//actually needs to be truncated...
			if($strict) {
				$trueMaxLength = $maxLength - strlen($endString);
			}
			else {
				$trueMaxLength = $maxLength;
			}
			
			//rip the first ($trueMaxLength) characters from string, append $endString, and go.
			$tmp = substr($string,0,$trueMaxLength);
			$retval = $tmp . $endString;
		}
		
		return($retval);
		
	}//end truncate_string()
	//---------------------------------------------------------------------------------------------

}//end cs_globalFunctions{}

?>
