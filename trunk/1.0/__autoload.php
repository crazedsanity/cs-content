<?php
/*
 * Created on Aug 28, 2009
 *
 *  SVN INFORMATION:::
 * -------------------
 * Last Author::::::::: $Author$ 
 * Current Revision:::: $Revision$ 
 * Repository Location: $HeadURL$ 
 * Last Updated:::::::: $Date$
 */

//these libraries are **REQUIRED** to make __autoload() function without chicken-or-the-egg issues.
require_once(dirname(__FILE__) .'/abstract/cs_version.abstract.class.php');
require_once(dirname(__FILE__) .'/abstract/cs_content.abstract.class.php');
require_once(dirname(__FILE__) .'/cs_fileSystem.class.php');
require_once(dirname(__FILE__) .'/cs_globalFunctions.class.php');




function __autoload($class) {
	
	if(is_array($GLOBALS['__autoload__libDefs']) && isset($GLOBALS['__autoload__libDefs'][$class])) {
		require_once($GLOBALS['__autoload__libDefs'][$class]);
	}
	else {
		
		$tried = array();
		
		$fsRoot = dirname(__FILE__) .'/../../';
		if(defined('LIBDIR')) {
			$fsRoot = constant('LIBDIR');
		}
		$fs = new cs_fileSystem($fsRoot);
		
		//try going into a "lib" directory.
		$fs->cd('lib');
		$lsData = $fs->ls();
		
		//attempt to find it here...
		$tryThis = array();
		if(preg_match('/[aA]bstract/', $class)) {
			$myClass = preg_replace('/[aA]bstract/', '', $class);
			$tryThis[] = $class .'.abstract.class.php';
			$tryThis[] = $myClass .'.abstract.class.php';
			$tryThis[] = 'abstract/'. $myClass .'.abstract.class.php';
		}
		$tryThis[] = $class .'.class.php';
		$tryThis[] = $class .'.php';
		
		$found=false;
		foreach($tryThis as $filename) {
			if(isset($lsData[$filename])) {
				$tried[] = $fs->realcwd .'/'. $filename;
				require_once($fs->realcwd .'/'. $filename);
				$found=true;
				break;
			}
		}
		
		if(!$found) {
			//try going into sub-directories to pull the files.
			foreach($lsData as $i=>$d) {
				if($d['type'] == 'dir') {
					$subLs = $fs->ls($i);
					foreach($tryThis as $filename) {
						$fileLocation = $fs->realcwd .'/'. $i .'/'. $filename;
						if(file_exists($fileLocation)) {
							$tried[] = $fileLocation;
							require_once($fileLocation);
							$found=true;
							break;
						}
					}
				}
				if($found) {
					break;
				}
			}
		}
	}
	
	if(!$found) {
		$gf = new cs_globalFunctions;
		$gf->debug_print(__FILE__ ." - line#". __LINE__ ."::: couldn't find (". $class .")",1);
		$gf->debug_print($tried,1);
		$gf->debug_print($tryThis,1);
		exit;
	}
}//end __autoload()
?>
