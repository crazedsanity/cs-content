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
		}
		$tryThis[] = $class .'.class.php';
		$tryThis[] = $class .'Class.php';
		$tryThis[] = $class .'.php';
		
	_autoload_directory_checker($fs, $class, $tryThis);
	if(!class_exists($class)) {
		$gf = new cs_globalFunctions;
		$gf->debug_print(__FILE__ ." - line #". __LINE__ ."::: couldn't find (". $class ."), realcwd=(". $fs->realcwd .")",1);
		$gf->debug_print($tried,1);
		$gf->debug_print($tryThis,1);
		if(function_exists('cs_debug_backtrace')) {
			cs_debug_backtrace(1);
		}
		$gf->debug_print($lsData,1);
		exit;
	}
}//end __autoload()


function _autoload_directory_checker($fs, $class, $lookForFiles) {
	$lsData = $fs->ls();
	$dirNames = array();
	$curDirectory = $fs->realcwd;
	
	$found = false;
	
	if(is_array($lsData)) {
		foreach($lsData as $objectName => $objectData) {
			if($objectData['type'] == 'dir') {
				$dirNames[] = $objectName;
			}
			elseif($objectData['type'] == 'file') {
				if(in_array($objectName, $lookForFiles)) {
					require_once($fs->realcwd .'/'. $objectName);
					if(class_exists($class)) {
						$found = true;
						break;
					}
				}
			}
		}
	}
	
	if(!$found && is_array($dirNames) && count($dirNames)) {
		foreach($dirNames as $dir) {
			$fs->cd($dir);
			$found = _autoload_directory_checker($fs, $class, $lookForFiles);
			$fs->cdup();
			
			if($found === true) {
				break;
			}
		}
	}
	
	return($found);
}

?>
