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

//TODO: option to not use layered transactions
//TODO: rollbackTrans() in layered transaction causes abort when final layer is committed/aborted
//TODO: stop sending queries to backend when transction is bad/aborted.
//TODO: commit/abort specific layer requests (i.e. if there's 8 layers & the first is named "x", calling commitTrans("x") will cause the whole transaction to commit & all layers to be destroyed.

require_once(dirname(__FILE__) ."/cs_versionAbstract.class.php");

class cs_phpDB extends cs_versionAbstract {
	
	private $dbLayerObj;
	
	//=========================================================================
	public function __construct($type='pgsql') {
		
		if(strlen($type)) {
			
			require_once(dirname(__FILE__) .'/db_types/'. __CLASS__ .'__'. $type .'.class.php');
			$className = __CLASS__ .'__'. $type;
			$this->dbLayerObj = new $className;
			
			$this->gfObj = new cs_globalFunctions;
			
			if(defined('DEBUGPRINTOPT')) {
				$this->gfObj->debugPrintOpt = DEBUGPRINTOPT;
			}
			
			$this->isInitialized = TRUE;
		}
		else {
			throw new exception(__METHOD__ .": failed to give a type (". $type .")");
		}
	}//end __construct()
	//=========================================================================
	
	
	
	public function __call($methodName, $args) {
		$retval = call_user_func_array(array($this->dbLayerObj, $methodName), $args);
		return($retval);
	}//end __call()	
} // end class phpDB

?>
