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
		
		
		require_once(dirname(__FILE__) .'/cs_fileSystem.class.php');
		$this->logger = new cs_fileSystem(constant('RWDIR'));
		$this->logger->create_file('session.log',true);
		$this->logger->openFile('session.log');
		
		//now tell PHP to use this class's methods for saving the session.
		session_set_save_handler(
			array(&$this, 'sessdb_open'),
			array(&$this, 'sessdb_close'),
			array(&$this, 'sessdb_read'),
			array(&$this, 'sessdb_write'),
			array(&$this, 'sessdb_destroy'),
			array(&$this, 'sessdb_gc')
		);
		
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
		$this->logger->append_to_file(__METHOD__ .": starting... ". microtime(true));
		try {
			$test = $this->db->run_query("SELECT * FROM ". $this->tableName .
					" ORDER BY ". $this->tablePKey ." LIMIT 1");
			$exists = true;
		}
		catch(exception $e) {
			$exists = false;
		}
		$this->logger->append_to_file(__METHOD__ .": result=(". $exists .")". microtime(true));
		
		return($exists);
	}//end sessdb_table_exists()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	private function load_table() {
		$this->logger->append_to_file(__METHOD__ .": starting... ". microtime(true));
		$filename = dirname(__FILE__) .'/schema/db_session_schema.'. $this->db->get_dbtype() .'.sql';
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
		$this->logger->append_to_file(__METHOD__ .": starting... ". microtime(true));
		$isValid = false;
		if(strlen($sid) == 32) {
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
			try {
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
				$sql = "SELECT * FROM ". $this->tableName ." WHERE session_id='". 
						$sid ."'";
				$this->db->run_query($sql);
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
				$numrows = $this->db->numRows();
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
				if($numrows == 1) {
					$isValid = true;
				}
				elseif($numrows > 0 || $numrows < 0) {
					throw new exception(__METHOD__ .": invalid numrows returned (". $numrows .")");
				}
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ ."), numrows=(". $numrows ."), SQL::: ". $sql ." ". microtime(true));
			}
			catch(exception $e) {
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
				//well... do nothing I guess.
			}
		}
		$this->logger->append_to_file(__METHOD__ .": result=(". $isValid .")". microtime(true));
		
		return($isValid);
	}//end is_valid_sid()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Open the session (doesn't really do anything)
	 */
	public function sessdb_open($savePath, $sessionName) {
		$this->logger->append_to_file(__METHOD__ .": starting... ". microtime(true));
		$this->logger->append_to_file(__METHOD__ .": done". microtime(true));
		return(true);
	}//end sessdb_open()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Close the session (call the "gc" method)
	 */
	public function sessdb_close() {
		$this->logger->append_to_file(__METHOD__ .": starting... ". microtime(true));
		$this->logger->append_to_file(__METHOD__ .": done". microtime(true));
		return($this->sessdb_gc(0));
	}//end sessdb_close()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Read information about the session.  If there is no data, it MUST return 
	 * an empty string instead of NULL.
	 */
	public function sessdb_read($sid) {
		$this->logger->append_to_file(__METHOD__ .": starting... ". microtime(true));
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
		$this->logger->append_to_file(__METHOD__ .": result=(". $retval .")". microtime(true));
		return($retval);
	}//end sessdb_read()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function sessdb_write($sid, $data) {
		$this->logger->append_to_file(__METHOD__ .": starting... ". microtime(true));
		$data = array(
			'session_data'	=> $data,
			'user_id'		=> null
		);
		
		
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
		
		//pull the uid out of the session...
		if(defined('SESSION_DBSAVE_UIDPATH')) {
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
			$a2p = new cs_arrayToPath($_SESSION);
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
			$uidVal = $a2p->get_data(constant('SESSION_DBSAVE_UIDPATH'));
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
			
			if(is_string($uidVal) || is_numeric($uidVal)) {
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
				$data['user_id'] = $uidVal;
			}
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
		}
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
		
		$afterSql = "";
		if($this->is_valid_sid($sid)) {
			$type = 'update';
			$sql = "UPDATE ". $this->tableName ." SET ";
			$afterSql = "WHERE session_id='". $sid ."'";
			$secondArg = false;
		}
		else {
			$type = 'insert';
			$sql = "INSERT INTO ". $this->tableName ." ";
			$data['session_id'] = $sid;
			$secondArg = $this->sequenceName;
		}
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ .") ". microtime(true));
		
		$sql .= $this->gfObj->string_from_array($data, $type, null, 'sql') . $afterSql;
		try {
			$funcName = 'run_'. $type;
			$res = $this->db->$funcName($sql, $secondArg);
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ ."), SQL::: ". $sql ." ". microtime(true));
		}
		catch(exception $e) {
			//umm... yeah.
		$this->logger->append_to_file(__METHOD__ .": still going, line=(". __LINE__ ."), EXCEPTION::: ". $e->getMessage() ."\n ". microtime(true));
		}
		$this->logger->append_to_file(__METHOD__ .": done". microtime(true));
		
		return(true);
	}//end sessdb_write()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function sessdb_destroy($sid) {
		$this->logger->append_to_file(__METHOD__ .": starting... ". microtime(true));
		try {
			$sql = "DELETE FROM ". $this->tableName ." WHERE session_id='". $sid ."'";
			$this->db->run_update($sql, true);
		}
		catch(exception $e) {
			//do... nothing?
		}
		$this->logger->append_to_file(__METHOD__ .": done". microtime(true));
		return(true);
	}//end sessdb_destroy()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Define maximum lifetime (in seconds) to store sessions in the database. 
	 * Anything that is older than that time will be purged (gc='garbage collector').
	 */
	public function sessdb_gc($maxLifetime=null) {
		$this->logger->append_to_file(__METHOD__ .": starting... ". microtime(true));
		
		$nowTime = date('Y-m-d H:i:s');
		if(is_null($maxLifetime) || !is_numeric($maxLifetime) || $maxLifetime < 0) {
			//pull it from PHP's ini settings.
			$maxLifetime = ini_get("session.gc_maxlifetime");
		}
		$interval = $maxLifetime .' seconds';
		
		$dt1 = strtotime($nowTime .' - '. $interval);
		$dt2 = date('Y-m-d H:i:s', $dt1);
		
		
		$this->logger->append_to_file(__METHOD__ .": still going, dt2=(". $dt2 .").. ". microtime(true));
		
		
		try {
			//destroy old sessions, but don't complain if nothing is deleted.
			$sql = "DELETE FROM ". $this->tableName ." WHERE last_updated < ". $dt2;
			#$this->db->run_update($sql, true);
		}
		catch(exception $e) {
			//probably should do something here.
		}
		$this->logger->append_to_file(__METHOD__ .": done". microtime(true));
		
		return(true);
		
	}//end sessdb_gc()
	//-------------------------------------------------------------------------


}//end cs_session{}
?>