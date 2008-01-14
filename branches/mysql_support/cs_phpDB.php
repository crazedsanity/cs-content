<?php

/*
 * A class for generic PostgreSQL database access.
 * 
 * SVN INFORMATION:::
 * SVN Signature:::::::: $Id$
 * Last Committted Date: $Date$
 * Last Committed Path:: $HeadURL$
 * 
 */

///////////////////////
// ORIGINATION INFO:
// 		Author: Trevin Chow (with contributions from Lee Pang, wleepang@hotmail.com)
// 		Email: t1@mail.com
// 		Date: February 21, 2000
// 		Last Updated: August 14, 2001
//
// 		Description:
//  		Abstracts both the php function calls and the server information to POSTGRES
//  		databases.  Utilizes class variables to maintain connection information such
//  		as number of rows, result id of last operation, etc.
//
///////////////////////

require_once(dirname(__FILE__) ."/cs_versionAbstract.class.php");
class cs_phpDB extends cs_versionAbstract {

	
	/** Name of the class to call to run stuff. */
	private $className;
	
	private $dbLayerObj;
	

	//=========================================================================
	public function __construct($type='pgsql') {
		
		if(strlen($type)) {
			
			require_once(dirname(__FILE__) .'/db_types/cs_phpDB__'. $type .'.class.php');
			
			$className = __CLASS__ .'__'. $type;
			$this->dbLayerObj = new $className;
			
			$this->gfObj = new cs_globalFunctions;
			
			if(defined('DEBUGPRINTOPT')) {
				$this->gfObj->debugPrintOpt = DEBUGPRINTOPT;
			}
			
			$this->isInitialized = TRUE;
		}
		else {
			throw new exception(__METHOD__ .": failed to set a type!");
		}
	}//end __construct()
	//=========================================================================
	
	
	
	//=========================================================================
	public function __call($x, $y) {
		
		#debug_print(__METHOD__ .": ". debug_print(func_get_args(),0),1);
		#debug_print($this->dbLayerObj,1);
		$retval = call_user_func_array(array($this->dbLayerObj, $x), $y);
		return($retval);
	}//end __call()
	//=========================================================================
	
		
} // end class phpDB

?>
