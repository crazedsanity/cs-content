<?php

/*
 * FILE INFORMATION:
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */

require_once(dirname(__FILE__) ."/abstract/cs_content.abstract.class.php");

class cs_fileSystem extends cs_contentAbstract {

	public $root;		//actual root directory.
	public $cwd;		//current directory; relative to $this->root
	public $realcwd;	//$this->root .'/'. $this->cwd
	public $dh;		//directory handle.
	public $fh;		//file handle.
	public $filename;	//filename currently being used.
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
		
		parent::__construct();
		
		$this->root = $this->resolve_path_with_dots($this->root);
		
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
			$myCwd = $this->gfObj->string_from_array($myParts, NULL, '/');
			$realCwd = $this->gfObj->create_list($this->root, $myCwd, '/');
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
			$this->cwd = $this->gfObj->create_list($this->cwd, $newDir, '/');
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
				$info = $this->get_fileinfo($tFile);
				if($info['type'] == 'dir') {
					$oldCwd = $this->cwd;
					$oldRealCwd = $this->realcwd;
					
					$this->cd($filename);
					$retval = $this->ls();
					
					$this->cwd = $oldCwd;
					$this->realcwd = $oldRealCwd;
				}
				else {
					$retval[$filename] = $info;
				}
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
		
		if(!function_exists($func)) {
			throw new exception(__METHOD__ .": required function missing (". $func .")");
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
		$sP = "";
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
		$filename = $this->filename2absolute($filename);
		$filename = $this->resolve_path_with_dots($filename);
		$this->filename = $filename;
		
		//check to see if the file exists...
		if(!file_exists($filename)) {
			if($this->is_writable(dirname($filename))) {
				//no file.  Create it.
				$createFileRes = touch($filename);
				if($createFileRes) {
					$retval = 1;
				}
				else {
					throw new exception(__METHOD__ .": invalid return from touch(". $filename ."), return was (". $createFileRes .")");
				}
			}
			else {
				throw new exception(__METHOD__ .": directory (". dirname($filename) .") is not writable");
			}
		}
		elseif($truncateFile === TRUE) {
			$this->truncate_file($filename);
		}
		else {
			throw new exception(__METHOD__ .": file (". $filename .") exists and truncate not set");
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
		clearstatcache();
		if(!strlen($filename) || is_null($filename)) {
			$filename = $this->filename;
		}
		$filename = $this->filename2absolute($filename);
		$this->filename = $filename;
		
		if($this->is_readable($filename)) {
			//make sure we've got a mode to use.
			
			if(!is_string($mode)) {
				$mode = "r+";
			}
			$this->mode = $mode;
			
			if(in_array($this->mode, array("r+", "w", "w+", "a", "a+", "x", "x+")) && !$this->is_writable($filename)) {
				throw new exception(__METHOD__ .": file is not writable (". $filename .") (". $this->is_writable($filename) ."), mode=(". $this->mode .")");
			}
			
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
		} 
		else {
			throw new exception(__METHOD__ .": file is unreadable (". $filename .")");
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
	private function filename2absolute($filename) {
		
		clearstatcache();
		
		$filename = $this->resolve_path_with_dots($filename);
		
		//If it's a single filename beginning with a slash, strip the slash.
		$x = array();
		$numSlashes  = preg_match_all('/\//', $filename, $x);
		if(preg_match('/^\/[\w]/', $filename) && !preg_match('/^\/\./', $filename) && $numSlashes == 1) {
			$filename = preg_replace('/^\//', '', $filename);
		}
		
		
		if(preg_match("/^\//", $filename)) {
			$retval = $filename;
		} else {
			$retval=$this->realcwd .'/'. $filename;
			$retval = $this->resolve_path_with_dots($retval);
		}
		
		if(!$this->check_chroot($retval, FALSE)) {
			$this->gfObj->debug_print(func_get_args());
			throw new exception(__METHOD__ .": file is outside of allowed directory (". $retval .")");
		}
		
		return($retval);
		
	}//end filename2absolute()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Reads-in the contents of an entire file.
	 */
	 function read($filename, $returnArray=FALSE) {
	 	$myFile = $this->filename2absolute($filename);
	 	if(!file_exists($myFile)) {
	 		throw new exception(__METHOD__ .": file doesn't exist (". $myFile .")");
	 	}
	 	elseif($this->is_readable($myFile)) {
	 		if($returnArray) {
	 			$data = file($myFile);
	 		}
	 		else {
		 		$data = file_get_contents($myFile);
	 		}
	 		
		 	if($data === FALSE) {
		 		throw new exception(__METHOD__. ": file_get_contents() returned FALSE");
		 	}
	 	}
	 	else {
	 		throw new exception(__METHOD__. ": File isn't readable (". $myFile .")");
	 	}
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
	public function rmdir($dirname) {
		$dirname = $this->filename2absolute($dirname);
		return(rmdir($dirname));
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
				$retval = $result;
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
			$this->gfObj->debug_print(func_get_args());
			throw new exception(__METHOD__ .": renaming file to same name");
		}
		
		if($this->compare_open_filename($currentFilename)) {
			$this->closeFile();
		}
		
		if($this->compare_open_filename($newFilename)) {
			//renaming a different file to our currently open file... 
			$this->gfObj->debug_print(func_get_args());
			throw new exception(__METHOD__ .": renaming another file (". $currentFilename .") to the currently open filename (". $newFilename .")");
		}
		else {
			
			$currentFilename = $this->filename2absolute($currentFilename);
			$newFilename = $this->filename2absolute($newFilename);
			
			if(!$this->is_writable(dirname($newFilename))) {
				throw new exception(__METHOD__ .": directory isn't writable... ");
			}
			$retval = rename($currentFilename, $newFilename);
			if($retval !== TRUE) {
				throw new exception(__METHOD__ .": failed to rename file (". $retval .")");
			}
		}
		
		return($retval);
		
	}//end rename()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Check if the given filename is executable.
	 */
	public function is_executable($filename) {
		$filename = $this->filename2absolute($filename);
		$retval = FALSE;
		if(strlen($filename)) {
			$retval = is_executable($filename);
		}
		
		return($retval);
	}//end is_executable()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Check if the given filename is readable.
	 */
	public function is_readable($filename) {
		$filename = $this->filename2absolute($filename);
		$retval = FALSE;
		if(strlen($filename)) {
			$retval = is_readable($filename);
		}
		
		return($retval);
	}//end is_readable()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Check if the given filename/path is writable
	 */
	public function is_writable($filenameOrPath) {
		$filenameOrPath = $this->filename2absolute($filenameOrPath);
		$retval = FALSE;
		if(strlen($filenameOrPath)) {
			$retval = is_writable($filenameOrPath);
		}
		
		return($retval);
	}//end is_writable()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Determines how many lines are left in the current file.
	 */
	public function count_remaining_lines() {
		if(is_resource($this->fh) && get_resource_type($this->fh) == 'stream') {
			$originalLineNum = $this->lineNum;
			
			$myFilename = $this->filename;
			$myNextLine = $this->get_next_line();
			$retval = 0;
			while($myNextLine !== FALSE) {
				$retval++;
				$myNextLine = $this->get_next_line();
			}
			
			$this->closeFile();
			$this->openFile($myFilename, $this->mode);
			
			if($originalLineNum > 0) {
				while($originalLineNum > $this->lineNum) {
					$this->get_next_line();
				}
			}
			
			if($this->lineNum !== $originalLineNum) {
				throw new exception(__METHOD__ .": failed to match-up old linenum (". $originalLineNum .") with the current one (". $this->lineNum .")");
			}
		}
		else {
			throw new exception(__METHOD__ .": Invalid filehandle, can't count remaining lines");
		}
		
		return($retval);
	}//end count_remaining_files()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Moves the cursor to the given line number.
	 * 
	 * NOTE: remember if you're trying to get line #1 (literally), then you'll 
	 * want to go to line #0, then call get_next_line() to retrieve it... this 
	 * is the traditional logical vs. programatic numbering issue. A.k.a. the 
	 * "off-by-one problem".
	 */
	public function go_to_line($lineNum) {
		$retval = FALSE;
		if(is_resource($this->fh) && get_resource_type($this->fh) == 'stream') {
			if($this->lineNum > $lineNum) {
				//gotta "rewind" the cursor back to the beginning.
				rewind($this->fh);
				$this->lineNum=0;
			}
			
			if($lineNum == $this->lineNum) {
				$retval = TRUE;
			}
			elseif($this->lineNum < $lineNum) {
				while($this->lineNum < $lineNum) {
					//don't grab any data, just move the cursor...
					$this->get_next_line();
				}
				if($this->lineNum == $lineNum) {
					$retval = TRUE;
				}
				else {
					throw new exception(__METHOD__ .": couldn't reach the line (". $lineNum ."), failed at (". $this->lineNum .")");
				}
			}
			else {
				throw new exception(__METHOD__ .": internal lineNum (". $this->lineNum .") couldn't be retrieved or reset to (". $lineNum .")");
			}
		}
		
		return($retval);
	}//end go_to_line()
	//========================================================================================
	
	
	
	//========================================================================================
	/**
	 * Fix a path that contains "../".
	 * 
	 * EXAMPLE: changes "/home/user/blah/blah/../../test" into "/home/user/test"
	 */
	public function resolve_path_with_dots($path) {
		
		while(preg_match('/\/\//', $path)) {
			$path = preg_replace('/\/\//', '/', $path);
		}
		$retval = $path;
		if(strlen($path) && preg_match('/\./', $path)) {
			
			$isAbsolute = FALSE;
			if(preg_match('/^\//', $path)) {
				$isAbsolute = TRUE;
				$path = preg_replace('/^\//', '', $path);
			}
			$pieces = explode('/', $path);
			
			$finalPieces = array();
			for($i=0; $i < count($pieces); $i++) {
				$dirName = $pieces[$i];
				if($dirName == '.') {
					//do nothing; don't bother appending.
				}
				elseif($dirName == '..') {
					$rippedIndex = array_pop($finalPieces);
				}
				else {
					$finalPieces[] = $dirName;
				}
			}
			
			$retval = $this->gfObj->string_from_array($finalPieces, NULL, '/');
			if($isAbsolute) {
				$retval = '/'. $retval;
			}
		}
		
		return($retval);
	}//end resolve_path_with_dots()
	//========================================================================================
	
	
	
	//========================================================================================
	private function check_chroot($path, $translatePath=TRUE) {
		if($translatePath === TRUE) {
			$path = $this->filename2absolute($path);
		}
		
		//now, let's go through the root directory structure, & make sure $path is within that.
		$rootPieces = explode('/', $this->root);
		$pathPieces = explode('/', $path);
		
		
		if($rootPieces[0] == '') {
			array_shift($rootPieces);
		}
		if($rootPieces[(count($rootPieces) -1)] == '') {
			array_pop($rootPieces);
		}
		if($pathPieces[0] == '') {
			array_shift($pathPieces);
		}
		
		$retval = TRUE;
		$tmp = '';
		foreach($rootPieces as $index=>$dirName) {
			$pathDir = $pathPieces[$index];
			if($pathDir != $dirName) {
				$retval = FALSE;
				$this->gfObj->debug_print(__METHOD__ .": failed... tmp=(". $tmp ."), dirName=(". $dirName .")");
				break;
			}
			$tmp = $this->gfObj->create_list($tmp, $dirName, '/');
		}
		
		return($retval);
	}//end check_chroot()
	//========================================================================================
	
	
	
	//========================================================================================
	public function copy_file($filename, $destination) {
		$retval = FALSE;
		if($this->openFile($filename)) {
			if($this->check_chroot($destination)) {
				//okay, try to copy.
				$retval = copy($this->fh, $destination);
			}
			else {
				throw new exception(__METHOD__ .':: destination is not in the directory path');
			}
		}
		
		return($retval);
	}//end copy_file()
	//========================================================================================
	
	
	
	//========================================================================================
	public function move_file($filename, $destination) {
		$retval = FALSE;
		if($this->is_readable($filename)) {
			if($this->check_chroot($destination)) {
				//do the move.
				$retval = rename($filename, $destination);
			}
			else {
				$this->gfObj->debug_print(__METHOD__ .":: ". $this->check_chroot($destination),1);
				throw new exception(__METHOD__ .':: destination is not in the directory path (from=['. $filename .'], to=['. $destination .']');
			}
		}
		
		return($retval);
	}//end move_file()
	//========================================================================================
	
	
	
	//========================================================================================
	public function mkdir($name, $mode=0777) {
		if(!is_numeric($mode) || strlen($mode) != 4) {
			$mode = 0777;
		}
		$retval = NULL;
		if(!is_null($name) && strlen($name)) {
			$name = $this->filename2absolute($name);
			if($this->check_chroot($name)) {
				$retval = mkdir($name, $mode);
				chmod($name, $mode);
			}
			else {
				throw new exception(__METHOD__ .': ('. $name .') isn\'t within chroot');
			}
		}
		else {
			cs_debug_backtrace(1);
			throw new exception(__METHOD__ .': invalid data: ('. $name .')');
		}
		
		return($retval);
	}//end mkdir()
	//========================================================================================
	
	
	
	//========================================================================================
	public function truncate_file($filename) {
		if($this->is_writable($filename)) {
			if($this->openFile($filename)) {
				$retval = ftruncate($this->fh,0);
				$this->closeFile();
			}
			else {
				throw new exception(__METHOD__ .": unable to open specified file (". $filename .")");
			}
		}
		else {
			throw new exception(__METHOD__ .": Cannot truncate, file (". $filename .") is not writable");
		}
		
		return($retval);
	}//end truncate_file()
	//========================================================================================
	
	
	
	//========================================================================================
	public function go_to_last_line() {
		if(is_resource($this->fh) && get_resource_type($this->fh) == 'stream') {
			if(feof($this->fh)) {
				$retval = TRUE;
			}
			else {
				//NOTE::: fseek() doesn't update the file pointer in $this->fh, so we have to use fgets(), which seems faster anyway.
				while(!feof($this->fh)) {
					fgets($this->fh);
					$this->lineNum++;
				}
				$retval = TRUE;
			}
		}
		else {
			throw new exception(__METHOD__ .": invalid filehandle");
		}
		
		return($retval);
	}//end go_to_last_line()
	//========================================================================================
	
	
}//end cs_filesystemClass{}
?>
