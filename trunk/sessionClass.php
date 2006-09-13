<?php
require_once("pg_abstraction_layer.php");
/*
 * FILE INFORMATION:
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */
class Session{

	protected $db;
	public $uid;
	public $sid;
	public $sid_check = 1;
	private $useDatabase;
	
	//---------------------------------------------------------------------------------------------
	function __construct($createSession=1, $useDatabase=FALSE) {
		if($createSession) {
			//TODO: check what the name of the session_id really is...
			//TODO: something that can say how long the session_id should be: this is too arbitrary.
			if($_GET['PHPSESSID'] && strlen($_GET['PHPSESSID']) == 32) {
				session_name($_GET['PHPSESSID']);
			}
			
			//now actually create the session.
			session_start();
		}
		
		//check if there's a uid in the session already.
		//TODO: need a setting somewhere that says what the name of this var should be,
		//	instead of always forcing "uid".
		$this->uid = 0;
		if($_SESSION['uid']) {
			$this->uid = $_SESSION['uid'];
		}
		
		//grab what our session_id is...
		$this->sid = session_id();
		
		$this->useDatabase = $useDatabase;
		if($useDatabase) {
			$this->connectDb();
		}
		
	}//end __construct()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	private function db_exec($sql) {
		$retval = NULL;
		if($this->useDatabase) {
			$numrows = $this->db->exec($sql);
			$dberror = $this->db->errorMsg();
			
			if(!$dberror & $numrows > 0) {
				$retval = $numrows;
			} else {
				debug_print("db_exec(): numrows=[$numrows], dberror=[$dberror]\n$sql");
			}
		}
		
		debug_print("db_exec(): retval=[$retval] SQL: $sql");
			
		return($retval);
	}//end db_exec()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	function check_session() {
		$retval = 0;
		if($this->useDatabase) {
			
			$result = $this->db_exec("SELECT * FROM cs_session WHERE session_id='". $this->sid ."'");
			if($result > 0) {
				$data = $this->db->farray_fieldnames();
				$this->uid = $data['uid'];
				$this->sid_check = 1;
				$retval = $result;
			}
		}
		
		return($retval);
	}//end check_session()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function connect_db() {
		if(!is_object($this->db)) {
			$this->db = new phpdb;
			$this->db->connect();
			$this->useDatabase = TRUE;
		} elseif(!is_resource($this->db->connectionID)) {
			//created the object, but not connected.
			$this->db->connect();
			$this->useDatabase = TRUE;
		}
		return($this->useDatabase);
	}//end connect_db()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function login($username, $password) {
		$retval = -2;
		
		$connectDbRes = $this->connect_db();
		if($this->connect_db()) {
			//if they're already logged-in, don't bother.
			if($this->check_session()) {
				//already logged-in.  Don't bother.
				$retval = 2;
			} else {
				//database connection good.  Run query.
				$password = md5(rtrim($password));
				$result = $this->db_exec("SELECT * FROM cs_authentication WHERE username='$username' AND password='$password'");
				
				$retval = -1;
				if($result) {
					$retval = 0;
					$data = $this->db->farray_fieldnames();
					debug_print($data);
					debug_print($result);
					
					//all is good: insert data into the session table.
					$result = $this->db_exec("INSERT INTO cs_session (session_id,uid) VALUES ('". $this->sid ."', ". $data['uid'] .")");
					if($result) {
						$this->uid = $data['uid'];
						$this->sid_check = 1;
						$retval = $this->sid_check;
						$_SESSION['uid'] = $this->uid;
					}
				}
			}
		}
		
		return($retval);
	}//end login()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function logout($sid=NULL) {
		if(is_null($sid)) {
			$sid = $this->sid;
		}
		$this->db_exec("DELETE from cs_session WHERE session_id='$sid'");
		unset($_SESSION['uid']);
	}//end logout()
	//---------------------------------------------------------------------------------------------


}//end content__Session{}
?>