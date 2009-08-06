<?php
/*
 * FILE INFORMATION:
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */

require_once(dirname(__FILE__) .'/cs_session.class.php');
require_once(constant('LIBDIR') .'/cs-phpxml/cs_arrayToPath.class.php');

class cs_sessionDB extends cs_session {

	protected $db;
	
	//-------------------------------------------------------------------------
	/**
	 * The constructor.
	 * 
	 * @param $createSession	(mixed,optional) determines if a session will be started or not; if
	 * 								this parameter is non-null and non-numeric, the value will be 
	 * 								used as the session name.
	 */
	function __construct() {
		
		
		//map some constants to connection parameters.
		//NOTE::: all constants should be prefixed...
		$constantPrefix = 'SESSION_DB_';
		$params = array('host', 'port', 'dbname', 'user', 'password');
		foreach($params as $name) {
			$value = null;
			$constantName = $constantPrefix . strtoupper($name);
			if(defined($constantName)) {
				$value = constant($constantName);
			}
			$dbParams[$name] = $value;
		}
		$this->db = new cs_phpDB(constant('DBTYPE'));
		$this->db->connect($dbParams);
		
		$this->tableName = 'cs_session_store_table';
		$this->tablePKey = 'session_store_id';
		$this->sequenceName = 'cs_session_store_table_session_store_id_seq';
		
		if(!$this->sessdb_table_exists()) {
			$this->load_table();
		}
		
		//now tell PHP to use this class's methods for saving the session.
		session_set_save_handler(
			array(&$this, 'sessdb_open'),
			array(&$this, 'sessdb_close'),
			array(&$this, 'sessdb_read'),
			array(&$this, 'sessdb_write'),
			array(&$this, 'sessdb_destroy'),
			array(&$this, 'sessdb_gc')
		);
		
		parent::__construct(true);
		
		//Stop things from going into an audit log... see 
		//http://www.developertutorials.com/tutorials/php/saving-php-session-data-database-050711/page3.html
		//	NOTE::: not sure if this is valid or not...
		$this->audit_logging = false;
		
	}//end __construct()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Determines if the appropriate table exists in the database.
	 */
	public function sessdb_table_exists() {
		try {
			$test = $this->db->run_query("SELECT * FROM ". $this->tableName .
					" ORDER BY ". $this->tablePKey ." LIMIT 1");
			$exists = true;
		}
		catch(exception $e) {
			$exists = false;
		}
		
		return($exists);
	}//end sessdb_table_exists()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	private function load_table() {
		$this->logger->append_to_file(__METHOD__ .": starting... ". microtime(true));
		if(file_exists($filename)) {
			try {
				$this->db->run_update(file_get_contents($filename),true);
			}
			catch(exception $e) {
				throw new exception(__METHOD__ .": failed to load required table " .
						"into your database automatically::: ". $e->getMessage());
			}
		}
		else {
			throw new exception(__METHOD__ .": while attempting to load required " .
					"table into your database, discovered you have a missing schema " .
					"file (". $filename .")");
		}
		$this->logger->append_to_file(__METHOD__ .": done". microtime(true));
	}//end load_table()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	protected function is_valid_sid($sid) {
		$isValid = false;
		if(strlen($sid) == 32) {
			try {
				$sql = "SELECT * FROM ". $this->tableName ." WHERE session_id='". 
						$sid ."'";
				$this->db->run_query($sql);
				$numrows = $this->db->numRows();
				if($numrows == 1) {
					$isValid = true;
				}
				elseif($numrows > 0 || $numrows < 0) {
					throw new exception(__METHOD__ .": invalid numrows returned (". $numrows .")");
				}
			}
			catch(exception $e) {
				//well... do nothing I guess.
			}
		}
		
		return($isValid);
	}//end is_valid_sid()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Open the session (doesn't really do anything)
	 */
	public function sessdb_open($savePath, $sessionName) {
		return(true);
	}//end sessdb_open()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Close the session (call the "gc" method)
	 */
	public function sessdb_close() {
		return($this->sessdb_gc(0));
	}//end sessdb_close()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Read information about the session.  If there is no data, it MUST return 
	 * an empty string instead of NULL.
	 */
	public function sessdb_read($sid) {
		$retval = '';
		try {
			$sql = "SELECT * FROM ". $this->tableName ." WHERE session_id='". 
				$sid ."'";
			$data = $this->db->run_query($sql);
			
			if($this->db->numRows() == 1) {
				$retval = $data['session_data'];
			}
		}
		catch(exception $e) {
			//no throwing exceptions...
		}
		return($retval);
	}//end sessdb_read()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function sessdb_write($sid, $data) {
		$data = array(
			'session_data'	=> $data,
			'user_id'		=> null
		);
		$cleanString = array(
			'session_data'		=> 'sql',
			'user_id'			=> 'numeric'
		);
		
		
		
		//pull the uid out of the session...
		if(defined('SESSION_DBSAVE_UIDPATH')) {
			$a2p = new cs_arrayToPath($_SESSION);
			$uidVal = $a2p->get_data(constant('SESSION_DBSAVE_UIDPATH'));
			
			if(is_string($uidVal) || is_numeric($uidVal)) {
				$data['user_id'] = $uidVal;
			}
		}
		
		$afterSql = "";
		if($this->is_valid_sid($sid)) {
			$type = 'update';
			$sql = "UPDATE ". $this->tableName ." SET ";
			$afterSql = "WHERE session_id='". $sid ."'";
			$data['last_updated'] = 'NOW()';
			$secondArg = false;
		}
		else {
			$type = 'insert';
			$sql = "INSERT INTO ". $this->tableName ." ";
			$data['session_id'] = $sid;
			$secondArg = $this->sequenceName;
		}
		
		$sql .= $this->gfObj->string_from_array($data, $type, null, $cleanString) .' '. $afterSql;
		try {
			$funcName = 'run_'. $type;
			$res = $this->db->$funcName($sql, $secondArg);
		}
		catch(exception $e) {
			//umm... yeah.
		}
		
		return(true);
	}//end sessdb_write()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function sessdb_destroy($sid) {
		try {
			$sql = "DELETE FROM ". $this->tableName ." WHERE session_id='". $sid ."'";
			$this->db->run_update($sql, true);
		}
		catch(exception $e) {
			//do... nothing?
		}
		return(true);
	}//end sessdb_destroy()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Define maximum lifetime (in seconds) to store sessions in the database. 
	 * Anything that is older than that time will be purged (gc='garbage collector').
	 */
	public function sessdb_gc($maxLifetime=null) {
		
		$nowTime = date('Y-m-d H:i:s');
		if(is_null($maxLifetime) || !is_numeric($maxLifetime) || $maxLifetime < 0) {
			//pull it from PHP's ini settings.
			$maxLifetime = ini_get("session.gc_maxlifetime");
		}
		$interval = $maxLifetime .' seconds';
		
		$dt1 = strtotime($nowTime .' - '. $interval);
		$dt2 = date('Y-m-d H:i:s', $dt1);
		
		
		
		try {
			//destroy old sessions, but don't complain if nothing is deleted.
			$sql = "DELETE FROM ". $this->tableName ." WHERE last_updated < ". $dt2;
			#$this->db->run_update($sql, true);
		}
		catch(exception $e) {
			//probably should do something here.
		}
		
		return(true);
		
	}//end sessdb_gc()
	//-------------------------------------------------------------------------


}//end cs_session{}
?>