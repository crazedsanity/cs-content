<?php
/*
 * Created on Aug 6, 2009
 *
 *  SVN INFORMATION:::
 * -------------------
 * Last Author::::::::: $Author$ 
 * Current Revision:::: $Revision$ 
 * Repository Location: $HeadURL$ 
 * Last Updated:::::::: $Date$
 */

require_once(dirname(__FILE__) .'/../../cs_fileSystem.class.php');
require_once(dirname(__FILE__) .'/../../cs_siteConfig.class.php');
require_once(dirname(__FILE__) .'/../../cs_phpDB.class.php');

$site = new cs_siteConfig(dirname(__FILE__) .'/../../../../rw/siteConfig.xml', 'website');
require_once(dirname(__FILE__) .'/../../cs_sessionDB.class.php');
#error_reporting(E_ALL);
require_once(constant('LIBDIR') .'/cs_debug.php');

class convertFiles extends cs_sessionDB {
	
	//-------------------------------------------------------------------------
	public function __construct() {
		$this->fs = new cs_fileSystem(constant('RWDIR') .'/tmp');
		parent::__construct();
		$this->gfObj->debugPrintOpt = 1;
	}//end __construct()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function do_conversion() {
		$files = $this->fs->ls();
		
		$this->db->beginTrans();
		
		$created = 0;
		$skipped = 0;
		$total = count($files);
		$handled = 0;
		
		foreach($files as $filename=>$data) {
			//get the file's contents...
			$fData = $this->fs->read($filename);
			
			$sid = preg_replace('/^sess_/', '', $filename);
			
			print "Handling ". $filename ."... ";
			
			$data['accessed'] = strftime('%Y-%m-%d %H:%M:%S', $data['accessed']);
			$data['modified'] = strftime('%Y-%m-%d %H:%M:%S', $data['modified']);
			
			$bits = explode('|', $fData);
			$uid = null;
			if(is_array($bits)) {
				foreach($bits as $n=>$v) {
					$check = unserialize($v);
					if(is_array($check) && isset($check['userInfo'])) {
						#$this->gfObj->debug_print($check);
						$uid = $check['userInfo']['uid'];
						#$this->gfObj->debug_print(__METHOD__ .": uid=(". $uid .")");
						break;
					}
				}
			}
			$insertData = array(
				'session_id'	=> $sid,
				'user_id'		=> $uid,
				'date_created'	=> $data['modified'],
				'last_updated'	=> $data['accessed'],
				'session_data'	=> $fData,
			);
			if(!$this->check_sid_exists($sid)) {
				$this->do_insert($insertData);
				$created++;
			}
			else {
				$skipped++;
			}
			$handled++;
			
			print "  DONE (". $handled ." / ". $total .")  SKIPPED=(". $skipped .")   \r";
			
			$this->db->commitTrans();
		}
	}//end do_conversion()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	private function check_sid_exists($sid) {
		$exists = false;
		if(strlen($sid) == 32) {
			$sql = "SELECT session_id FROM ". $this->tableName ." WHERE " .
					"session_id='". $sid ."'";
			try {
				$data = $this->db->run_query($sql);
				$numrows = $this->db->numRows();
				if($numrows == 1) {
					$exists = true;
				}
				elseif($numrows == 0) {
					$exists = false;
				}
				else {
					throw new exception(__METHOD__ .": invalid value of numrows (". $numrows .")");
				}
			}
			catch(exception $e) {
				
			}
		}
		else {
			throw new exception(__METHOD__ .": invalid session id (". $sid .")");
		}
		
		return($exists);
	}//end check_sid_exists()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	private function do_insert(array $data) {
		$cleanString = array(
			'session_id'		=> 'sql',
			'user_id'			=> 'numeric',
			'date_created'		=> 'sql',
			'last_updated'		=> 'sql',
			'session_data'		=> 'sql'
		);
		if(!is_numeric($data['user_id'])) {
			unset($data['user_id']);
		}
		$sql = "INSERT INTO ". $this->tableName ." ". 
				$this->gfObj->string_from_array($data, 'insert', null, $cleanString);
		
		#$this->gfObj->debug_print($sql);
		#$this->gfObj->debug_print($data);
		$id = $this->db->run_insert($sql, $this->sequenceName);
		
		return($id);
	}//end do_insert()
	//-------------------------------------------------------------------------
	
}


$obj = new convertFiles;
$obj->do_conversion();

?>
