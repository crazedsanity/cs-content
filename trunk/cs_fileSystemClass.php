<?

/*
 * FILE INFORMATION:
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */

require_once(dirname(__FILE__) ."/cs_globalFunctions.php");

class cs_fileSystemClass {

	public $root;		//actual root directory.
	public $cwd;		//current directory; relative to $this->root
	public $realcwd;	//$this->root .'/'. $this->cwd
	public $dh;		//directory handle.
	public $fh;		//file handle.
	public $filename;	//filename currently being used.
	public $gf;		//cs_globalFunctions{} object.
	public $lineNum = NULL;

	
	//========================================================================================
	/**
	 * The constructor.
	 */
	public function __construct($rootDir=NULL, $cwd=NULL, $initialMode=NULL) {
		//set the root directory that we'll be using; this is considered just like "/" in 
		//	linux.  Directories above it are considered non-existent.
		if(($rootDir) AND (is_dir($rootDir))) {
			// yup... use it.
			$this->root = $rootDir;
		} elseif(($GLOBALS['SITE_ROOT']) AND (is_dir($GLOBALS['SITE_ROOT']))) {
			//not set, but SITE_ROOT is... use it.
			$this->root = $GLOBALS['SITE_ROOT'];
		} else {
			//nothing useable... die.
			exit("UNUSEABLE ROOT: $rootDir");
		}
		
		$this->gf = new cs_globalFunctions();
		
		//set the CURRENT working directory... this should be a RELATIVE path to $this->root.
		if(($cwd) AND (is_dir($rootDir .'/'. $cwd)) AND (!ereg($this->root, $cwd))) {
			//looks good.  Use it.
			$this->cwd = $cwd;
			$this->realcwd = $this->root .'/'. $cwd;
		} else {
			//no dice.  Use the root.
			$this->cwd = '/';
			$this->realcwd = $this->root ;
		}
		chdir($this->realcwd);
		
		//check for the initialMode...
		$useableModes = array('r', 'r+', 'w', 'w+', 'a', 'a+', 'x', 'x+');
		if(($initialMode) AND (in_array($initialMode, $useableModes))) {
			//
			$this->mode = $initialMode;
		} else {
			//define the DEFAULT mode.
			$this->mode = "r+";
		}
		
	}//end __construct()
	//========================================================================================
	
	
	
	//========================================================================================
	public function cdup() {
		$retval = FALSE;
		//easy way to go "up" a directory (just like doing "cd .." in linux)
		if(strlen($this->cwd) > 1) {
			$myCwd = preg_replace('/\/$/', '', $this->cwd);
			if(!preg_match('/^\//', $myCwd)) {
				$myCwd = '/'. $myCwd;
			}
			$myParts = explode('/', $myCwd);
			array_pop($myParts);
			$myCwd = $this->gf->string_from_array($myParts, NULL, '/');
			$realCwd = $this->gf->create_list($this->root, $myCwd, '/');
			if(file_exists($realCwd)) {
				$retval = TRUE;
				$this->realcwd = $realCwd;
				$this->cwd = '/'. $myCwd;
			}
		}
		
		return($retval);
	}//end cdup()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Think of the linux version of "cd": we're changing the current directory. 
	 * 
	 * @param $newDir	(str) dir to change to, either absolutte or relative.
	 * 
	 * @return 0		(FAIL) unable to change directory
	 * @return 1		(PASS) success.
	 */
	public function cd($newDir) {
		
		//check to see if it's a relative path or not...
		//NOTE: non-relative paths should NOT include $this->root.
		if((preg_match('/^\//', $newDir)) AND (is_dir($this->root .'/'. $newDir))) {
			//not a relative path.
			$this->cwd = '/'. $newDir;
			$this->realcwd = $this->root . $newDir;
			$retval = 1;
		} elseif(is_dir($this->realcwd .'/'. $newDir)) {
			//relative path...
			$this->cwd = $this->gf->create_list($this->cwd, $newDir, '/');
			$this->realcwd .= '/'. $newDir;
			$retval = 1;
		} else {
			//bad.
			$retval = 0;
		}
		$this->cwd = preg_replace('/\/\//', '/', $this->cwd);
		$this->realcwd = preg_replace('/\/\//', '/', $this->realcwd);
		
		return($retval);
	}//end cd()
	//========================================================================================
	
	
	//========================================================================================
	/**
	 * Just like the linux version of the 'ls' command.
	 */
	public function ls($filename=NULL, $args=NULL) {
		
		clearstatcache();
		//open the directory for reading.
		$this->dh = opendir($this->realcwd);
		clearstatcache();
		if(is_string($filename)) {
			//check to make sure the file exists.
			$tFile=$this->filename2absolute($filename);
			if(file_exists($tFile)) {
				//it's there... get info about it.
				$retval[$filename] = $this->get_fileinfo($tFile);
			} else {
				//stupid!
				$retval[$filename] = "FILE NOT FOUND.";
			}
		} else {
			//array if file/directory names to ignore if matched exactly.
			$ignoreArr = array("CVS", ".svn", ".", "..");
			while (($file = readdir($this->dh)) !== false) {
				if(!in_array($file, $ignoreArr)) {
					$tFile = $this->realcwd .'/'. $file;
					$tType = filetype($tFile);
					$retval[$file] = $this->get_fileinfo($tFile);
					if(!$tType) {
						debug_print("FILE: $tFile || TYPE: $tType || is_file(): ". is_file($tFile) ."is_dir(): ". is_dir($tFile));
						exit;
					}
	#debug_print("FILE: $file || $dir". $file);
					unset($tType);
				}
			}
		}
		#debug_print($retval);
		#debug_print(readdir($this->dh));
		return($retval);
	}//end ls()
	//========================================================================================
	
	
	//========================================================================================
	/**
	 * Grabs an array of information for a given file.
	 */
	public function get_fileinfo($tFile) {
		
		$retval = array(
			"size"		=> filesize($tFile),
			"type"		=> @filetype($tFile),
			"accessed"	=> fileatime($tFile),
			"modified"	=> filemtime($tFile),
			"owner"		=> $this->my_getuser_group(fileowner($tFile), 'uid'),
			"uid"		=> fileowner($tFile),
			"group"		=> $this->my_getuser_group(filegroup($tFile), 'gid'),
			"gid"		=> filegroup($tFile),
			"perms"		=> $this->translate_perms(fileperms($tFile)),
			"perms_num"	=> substr(sprintf('%o', fileperms($tFile)), -4)
		);
		
		return($retval);
	}//end get_fileinfo()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Gets the username/groupname of the given uid/gid.
	 * 
	 * @param $int		(int) uid/gid to check.
	 * @param $type		(str) is it a uid or a gid?
	 * 
	 * @return (string)	groupname/username
	 */
	private function my_getuser_group($int, $type='uid') {
			
		if($type == 'uid') {
			$func = 'posix_getpwuid';
		} elseif($type == 'gid') {
			$func = 'posix_getgrgid';
		} else {
			$retval = $int;
		}
		$t = $func($int);
		return($t['name']);
	
	}//end my_getpwuid()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Translates the permissions string (like "0700") into a *nix-style permissions
	 * 	string (i.e. "rwx------").
	 * 
	 * @param $in_Perms		(int) permission number string
	 * 
	 * @return (string)		permissions string.
	 * 
	 * NOTE: pretty sure I copied this from php.net, though I don't know the owner.  If anybody
	 * can enlighten me, I'd be glad to give them credit.
	 */
	private function translate_perms($in_Perms) {
		$sP .= (($in_Perms & 0x0100) ? 'r' : '-') .
			(($in_Perms & 0x0080) ? 'w' : '-') .
			(($in_Perms & 0x0040) ? (($in_Perms & 0x0800) ? 's' : 'x' ) :
						(($in_Perms & 0x0800) ? 'S' : '-'));
		// group
		$sP .= (($in_Perms & 0x0020) ? 'r' : '-') .
			(($in_Perms & 0x0010) ? 'w' : '-') .
			 (($in_Perms & 0x0008) ? (($in_Perms & 0x0400) ? 's' : 'x' ) :
						(($in_Perms & 0x0400) ? 'S' : '-'));
		
		// world
		$sP .= (($in_Perms & 0x0004) ? 'r' : '-') .
			(($in_Perms & 0x0002) ? 'w' : '-') .
			(($in_Perms & 0x0001) ? (($in_Perms & 0x0200) ? 't' : 'x' ) :
						(($in_Perms & 0x0200) ? 'T' : '-'));
		return($sP);
	}//end translate_perms()
	//========================================================================================
	
	
	//========================================================================================
	/**
	 * Creates an empty file... think of the linux command "touch".
	 * 
	 * @param $filename		(string) filename to create.
	 * 
	 * @return 0			(FAIL) unable to create file.
	 * @return 1			(PASS) file created successfully.
	 */
	public function create_file($filename, $truncateFile=FALSE) {
		
		$retval = 0;
		//check to see if the file exists...
		if(!file_exists($filename)) {
			//no file.  Create it.
			$createFileRes = touch($this->realcwd .'/'. $filename);
			if($createFileRes) {
				$retval = 1;
			}
		}
		elseif($truncateFile === TRUE) {
			$this->filename = $filename;
			if($this->openFile($filename)) {
				ftruncate($this->fh,0);
				$this->closeFile();
			}
			else {
				throw new exception(__METHOD__ .": unable to open specified file");
			}
		}
		return($retval);
	}//end create_file()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Opens a stream/resource handle to use for doing file i/o.
	 * 
	 * @param $filename		(string) filename to open: should be relative to the current dir.
	 * @param $mode			(string) mode to use: consult PHP.net's info for fopen().
	 * 
	 * @return 0			(FAIL) unable to open file.
	 * @return 1			(PASS) file opened successfully.
	 */
	public function openFile($filename=NULL, $mode="r+") {
	
		//make sure we've got a mode to use.
		if(!$filename) {
			$filename = $this->filename;
		}
		$this->filename = $filename;
		$filename = $this->filename2absolute($filename);
		
		if(!file_exists($this->filename)) {
			throw new exception(__METHOD__ .': filename does not exist ('. $this->filename .')');
		}
		
		//make sure the file exists...
		$this->create_file($filename);
		
		//make sure $filename is absolute...
		$filename = $this->filename2absolute($filename);
		
		if(!is_string($mode)) {
			$mode = "r+";
		}
		$this->mode = $mode;
	
		//attempt to open a stream to a file...
		$this->fh = fopen($this->filename, $this->mode);
		if(is_resource($this->fh)) {
			//looks like we opened successfully.
			$retval = 1;
			$this->lineNum = 0;
		} else {
			//something bad happened.
			$retval = 0;
		}
		
		return($retval);
	}//end openFile()
	//========================================================================================
	
	
	//========================================================================================
	/**
	 * Write the given contents into the current file or the filename given.
	 * 
	 * @param $content		(str) Content to write into the file.
	 * @param $filename		(str,optional) filename to use.  If none given, the current one is used.
	 * 
	 * @return 0			(FAIL) unable to write content to the file.
	 * @return (n)			(PASS) wrote (n) bytes.
	 */
	public function write($content, $filename=NULL) {
		
		//open the file for writing.
		if(!$filename) {
			$filename= $this->filename;
		}
		$this->filename = $filename;
		
		//open the file...
		$openResult = $this->openFile($this->filename, $this->mode);
		
		//looks like we made it... 
		$retval = fwrite($this->fh, $content, strlen($content));
	
		//done... return the result.
		return($retval);
	}//end write()
	//========================================================================================
	
	
	//========================================================================================
	/**
	 * Takes the given filename & returns the ABSOLUTE pathname: checks to see if the given
	 * 	string already has the absolute path in it.
	 */
	private function filename2absolute($filename=NULL) {
		
		if(!strlen($filename)) {
			$filename = $this->filename;
		}
		
		//see if it starts with a "/"...
		if(preg_match("/^\//", $filename)) {
			//it's an absolute path... see if it's one we can use.
			#if() {
			#
			#} else {
			#
			#}
		} else {
			//not absolute... see if it's a valid file; if it is, return proper string.
			if(file_exists($this->realcwd .'/'. $filename)) {
				//looks good.
				$this->filename=$this->realcwd .'/'. $filename;
			} else {
				/*/bad filename... die.
				print "filename2absolute(): INVALID FILENAME: $filename<BR>\n
				CURRENT CWD: ". $this->cwd ."<BR>\n
				REAL CWD: ". $this->realcwd;
				debug_print($this->ls(),1);
				exit;
				#*/
			}
		}
		
		return($this->filename);
		
	}//end filename2absolute()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Reads-in the contents of an entire file.
	 */
	 function read($filename) {
	 	$data = file_get_contents($this->realcwd ."/$filename");
	 	return($data);
	 }//end read()
	//========================================================================================
	
	
	
	//========================================================================================
	public function rm($filename) {
		$filename = $this->filename2absolute($filename);
		return(unlink($filename));
	}//end rm()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Return the next line for a file.
	 * 
	 * When the end of the file is found, this method returns FALSE (returning NULL might be 
	 * misconstrued as a blank line).
	 */
	public function get_next_line($maxLength=NULL, $trimLine=TRUE) {
		if(is_resource($this->fh) && get_resource_type($this->fh) == 'stream') {
			if(feof($this->fh)) {
				$retval = FALSE;
			}
			else {
				if(!is_numeric($maxLength)) {
					$retval = @fgets($this->fh);
				}
				else {
					$retval = fgets($this->fh, $maxLength);
				}
				if($trimLine) {
					$retval = trim($retval);
				}
				
				if(is_null($this->lineNum) || !is_numeric($this->lineNum) || $this->lineNum < 0) {
					throw new exception(__METHOD__ .": invalid data for lineNum (". $this->lineNum .")");
				}
				$this->lineNum++;
			}
		}
		else {
			throw new exception(__METHOD__ .": invalid filehandle");
		}
		
		return($retval);
	}//end get_next_line()
	//========================================================================================
	
	
	
	//========================================================================================
	public function append_to_file($data, $eolChar="\n") {
		$retval = FALSE;
		if(is_resource($this->fh)) {
			$result = fwrite($this->fh, $data . $eolChar);
			if($result === FALSE) {
				throw new exception(__METHOD__ .": failed to write data to file");
			}
			else {
				$this->lineNum++;
				$retval = TRUE;
			}
		}
		else {
			throw new exception(__METHOD__ .": invalid filehandle");
		}
		
		return($retval);
	}//end append_to_file()
	//========================================================================================
	
	
	
	//========================================================================================
	public function closeFile() {
		$retval = FALSE;
		if(is_resource($this->fh)) {
			fclose($this->fh);
			$retval = TRUE;
		}
		
		//reset internal pointers.
		$this->filename = NULL;
		$this->lineNum = NULL;
		
		return($retval);
	}//end closeFile()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Compare the given filename to the open filename to see if they match (using this allows 
	 * giving a filename instead of comparing the whole path).
	 */
	public function compare_open_filename($compareToFilename) {
		if(!strlen($compareToFilename) || is_null($compareToFilename)) {
			throw new exception(__METHOD__ .": invalid filename to compare");
		}
		elseif(!strlen($this->filename)) {
			$retval = FALSE;
		}
		else {
			$internalFilename = $this->filename2absolute($this->filename);
			$compareToFilename = $this->filename2absolute($compareToFilename);
			if($internalFilename == $compareToFilename) {
				$retval = TRUE;
			}
			else {
				$retval = FALSE;
			}
		}
		
		return($retval);
	}//end compare_open_filename()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Give a file a new name.
	 * 
	 * TODO: check to make sure both files exist within our root.
	 */
	public function rename($currentFilename, $newFilename) {
		if($newFilename == $currentFilename) {
			$this->gf->debug_print(func_get_args());
			throw new exception(__METHOD__ .": renaming file to same name");
		}
		
		//TODO: figure out why this breaks... 
		#$currentFilename = $this->filename2absolute($currentFilename);
		#$newFilename = $this->filename2absolute($newFilename);
		#if($newFilename == $currentFilename) {
		#	$this->gf->debug_print(func_get_args());
		#	throw new exception(__METHOD__ .": internally changed file to same name....????");
		#}
		
		if($this->compare_open_filename($currentFilename)) {
			$this->closeFile();
		}
		
		if($this->compare_open_filename($newFilename)) {
			//renaming a different file to our currently open file... 
			$this->gf->debug_print(func_get_args());
			throw new exception(__METHOD__ .": renaming another file (". $currentFilename .") to the currently open filename (". $newFilename .")");
		}
		else {
			
			$retval = rename($currentFilename, $newFilename);
			if($retval !== TRUE) {
				throw new exception(__METHOD__ .": failed to rename file");
			}
			else {
				$this->gf->debug_print(__METHOD__ ."Renamed ($currentFilename) to ($newFilename)");
			}
		}
		
		return($retval);
		
	}//end rename()
	//========================================================================================
	
	
}//end cs_filesystemClass{}
?>
