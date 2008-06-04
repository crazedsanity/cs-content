<?php

/*
 * A class for generic SQLite database access.
 * 
 * SVN INFORMATION:::
 * SVN Signature:::::::: $Id$
 * Last Committted Date: $Date$
 * Last Committed Path:: $HeadURL$
 * 
 */


class cs_phpDB__sqlite {

	/** Internal result set pointer. */
	protected $result = NULL;
	
	/** Internal error code. */
	protected $errorCode = 0;
	
	/** Status of the current transaction. */
	protected $transStatus = NULL;
	
	/** Whether there is a transaction in progress or not. */
	protected $inTrans = FALSE;
	
	/** Holds the last query performed. */
	protected $lastQuery = NULL;
	
	/** List of queries that have been run */
	protected $queryList=array();
	
	/** How many seconds to wait for a query before cancelling it. */
	protected $timeOutSeconds = NULL;
	
	/** Internal check to determine if a connection has been established. */
	protected $isConnected=FALSE;
	
	/** Internal check to determine if the parameters have been set. */
	protected $paramsAreSet=FALSE;
	
	/** Resource handle. */
	protected $connectionID = -1;
	
	/** Hostname or IP to connect to */
	protected $host;
	
	/** Port to connect to (default for Postgres is 5432) */
	protected $port;
	
	/** Name of the database */
	protected $dbname;
	
	/** Username to connect to the database */
	protected $user;
	
	/** password to connect to the database */
	protected $password;
	
	/** Row counter for looping through records */
	protected $row = -1;
	
	/** cs_globalFunctions object, for string stuff. */
	protected $gfObj;
	
	/** Internal check to ensure the object has been properly created. */
	protected $isInitialized=FALSE;
	
	/** List of prepared statements, indexed off the name, with the sub-array being fieldname=>dataType. */
	protected $preparedStatements = array();
	
	/** Set to TRUE to save all queries into an array. */
	protected $useQueryList=FALSE;
	
	/** array that essentially remembers how many times beginTrans() was called. */
	protected $transactionTree = NULL;
	
	/**  */
	private $dbConnObj;
	
	////////////////////////////////////////////
	// Core primary connection/database function
	////////////////////////////////////////////
	
	
	//=========================================================================
	public function __construct() {
		$this->gfObj = new cs_globalFunctions;
		
		if(defined('DEBUGPRINTOPT')) {
			$this->gfObj->debugPrintOpt = DEBUGPRINTOPT;
		}
		
		$this->isInitialized = TRUE;
	}//end __construct()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Make sure the object is sane.
	 */
	final protected function sanity_check() {
		if($this->isInitialized !== TRUE) {
			throw new exception(__METHOD__ .": not properly initialized");
		}
	}//end sanity_check()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Set appropriate parameters for database connection
	 */
	public function set_db_info(array $params){
		$this->sanity_check();
		$required = array('rwDir', 'dbname');
		
		$requiredCount = 0;
		foreach($params as $index=>$value) {
			if(property_exists($this, $index) && in_array($index, $required)) {
				$this->$index = $value;
				$requiredCount++;
			}
			else {
				throw new exception(__METHOD__. ": property (". $index .") does " .
					"not exist or isn't allowed");
			}
		}
		
		if($requiredCount == count($required)) {
			$this->paramsAreSet = TRUE;
		}
		else {
			throw new exception(__METHOD__ .": required count (". $requiredCount 
				.") does not match required number of fields (". count($required) .")");
		}
	}//end set_db_info()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Wrapper for close()
	 */
	function disconnect() {
		//Disconnect from $database
		return($this->close());
	}//end disconnect()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Standard method to close connection.
	 */
	function close() {
		$this->isConnected = FALSE;
		$retval = null;
		if($this->connectionID != -1) {
			sqlite_close($this->dbConnObj);
			$retval = TRUE;
		}
		else {
			throw new exception(__METHOD__ .": Failed to close connection: connection is invalid");
		}
		
		return($retval);
	}//end close()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Connect to the database
	 */
	function connect(array $dbParams=NULL, $forceNewConnection=FALSE){
		$this->sanity_check();
		$retval = NULL;
		$connectError = NULL;
		
		$this->set_db_info($dbParams);
		
		if($this->paramsAreSet === TRUE && $this->isConnected === FALSE) {
			
			$dbFile = $this->rwDir .'/'. $this->dbname;
			$this->connectionID = sqlite_open($dbFile, $connectError);
			
			if(is_resource($this->dbConnObj)) {
				$this->errorCode=0;
				$this->isConnected = TRUE;
				$retval = $this->connectionID;
			}
			else {
				throw new exception(__METHOD__ .": FATAL ERROR: ". $connectError);
			}
		}
		else {
			throw new exception(__METHOD__ .": paramsAreSet=(". $this->paramsAreSet ."), isConnected=(". $this->isConnected .")");
		}
		
		return($retval);
	}//end connect()
	//=========================================================================
	
	
	
	//=========================================================================
	/** 
	 * Run sql queries
	 * 
	 * TODO: re-implement query logging (setting debug, logfilename, etc).
	 */
	function exec($query) {
		$this->lastQuery = $query;
		if($this->useQueryList) {
			$this->queryList[] = $query;
		}
		$returnVal = false;
		
		if(($this->get_transaction_status() != -1) && ($this->connectionID != -1)) {
			$this->result = @sqlite_exec($this->connectionID, $query);

			if($this->result !== false) {
				if (eregi("^[[:space:]]*select", $query)) {
					//If we didn't have an error and we are a select statement, move the pointer to first result
					$numRows = $this->numRows();
					if($numRows > 0) {
						$this->move_first();
					}
					$returnVal = $numRows;
					
				}
				else {
					//We got something other than an update. Use numAffected
					$returnVal = $this->numAffected();
				}
			}
 		}
		return($returnVal);
	}//end exec()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Returns any error caused by the last executed query.
	 * 
	 * @return NULL			OK: no error
	 * @return (string)		FAIL: contains error returned from the query.
	 */
	function errorMsg($setMessage=NULL,$logError=NULL) {
		$this->sanity_check();
		if ($this->connectionID < 0 || !is_resource($this->connectionID)) {
			$retVal = "Failed to open connection to database (". $this->dbname .")";
		} else {
			$retVal = pg_last_error($this->connectionID);
		}

		return($retVal);
	}//end errorMsg()
	//=========================================================================
	
	
	
	
	///////////////////////
	// Result set related
	///////////////////////
	
	
	
	//=========================================================================
	/**
	 * Return the current row as an object.
	 */
	function fobject() {
		$this->sanity_check();
		if($this->result == NULL || $this->row == -1) {
			$retval = NULL;
		}
		else {
			//NOTE::: this function isn't documented (as of 2008-06-04)... maybe broken.
			$retval = sqlite_fetch_object($this->result);
		}
		
		return($retval);
	}
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Fetch the current row as an array containing fieldnames AND numeric indexes.
	 */
	function farray(){
		if($this->result == NULL || $this->row == -1) {
			$retval = NULL;
		}
		else {
			$retval = sqlite_fetch_array($this->result);
		}
		
		return($retval);
	}//end farray()
	//=========================================================================
	
	
	
	//=========================================================================
	function fetch_all($index=NULL, $numbered=NULL,$unsetIndex=1) {
		$this->sanity_check();
		$retval = NULL;
		
		//before we get too far, let's make sure there's something there.
		if($this->numRows() <= 0) {
			$retval = 0;
		}
		else {
			$retval = sqlite_fetch_all($this->result);
		}
		return($retval);
	}//end farray_fieldnames()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Returns the number of tuples affected by an insert/delete/update query.
	 * NOTE: select queries must use numRows()
	 */
	function numAffected() {
		if($this->result == null) {
			$retval = 0;
		} else {
			$this->affectedRows = sqlite_changes($this->connectionID);
			$retval = $this->affectedRows;
		}
		
		return($retval);
	}//end numAffected()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Returns the number of rows in a result (from a SELECT query).
	 */
	function numRows() {
		if ($this->result == null) {
			$retval = 0;
		}
		else {
			$this->numrows = sqlite_num_rows($this->result);
			$retval = $this->numrows;
		}
		
		return($retval);
	}//end numRows()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * wrapper for numAffected()
	 */
	function affectedRows(){
		return($this->numAffected());
	}//end affectedRows()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Get the number of fields in a result.
	 */
	// get the number of fields in a result
	function num_fields() {
		if($this->result == null) {
			$retval = 0;
		}
		else {
			$retval = sqlite_num_fields($this->result);
		}
		return($retval);	
	}//end num_fields()
	//=========================================================================
	
	
	
	//=========================================================================
	function column_count() {
		return($this->numFields());
	}//end column_count()
	//=========================================================================
	
	
	
	//=========================================================================
	/** 
	 * get last OID (object identifier) of last INSERT statement
	 */
	function lastOID($doItForMe=0, $field=NULL) {
		if($this->result == NULL) {
			$retval = NULL;
		}
		else {
			$retval = sqlite_last_insert_rowid($this->connectionID);
		}
		return($retval);
	}//end lastOID()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * get result field name of the given field number.
	 */
	// get result field name
	function fieldname($fieldnum) {
		if($this->result == NULL) {
			$retval =NULL;
		}
		else {
			$retval = sqlite_field_name($this->result, $fieldnum);
		}
		
		return($retval);
	}//end fieldname()
	//=========================================================================
	
	
	
	
	////////////////////////
	// Transaction related
	////////////////////////
	
	
	
	
	//=========================================================================
	/**
	 * Start a transaction.
	 */
	function beginTrans() {
		return($this->exec("BEGIN TRANSACTION"));
	}//end beginTrans()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Commit a transaction.
	 */
	function commitTrans() {
		return($this->exec("COMMIT TRANSACTION"));
	}//end commitTrans()
	//=========================================================================
	
	
	
	//=========================================================================
	// returns true/false
	function rollbackTrans() {
		$retval = $this->exec("ROLLBACK TRANSACTION");
		return($retval);
	}//end rollbackTrans()
	//=========================================================================
	
	
	
	////////////////////////
	// SQL String Related
	////////////////////////
	
	
	
	//=========================================================================
	/**
	 * Gets rid of evil characters that might lead ot SQL injection attacks.
	 */
	function querySafe($string) {
		return($this->gfObj->cleanString($string,"query"));
	}//end querySafe()
	//=========================================================================
	
	
	
	//=========================================================================
	/**
	 * Make it SQL safe.
	 */
	function sqlSafe($string) {
		return($this->gfObj->cleanString($string,"sql"));
	}//end sqlSafe()
	//=========================================================================
	
	
	
	//=========================================================================
	public function is_connected() {
		$retval = FALSE;
		if(is_resource($this->connectionID) && $this->isConnected === TRUE) {
			$retval = TRUE;
		}
		
		return($retval);
	}//end is_connected()
	//=========================================================================
	
	
	
} // end class phpDB

?>
