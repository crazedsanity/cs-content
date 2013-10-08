<?php
/*
 * Created on Aug 28, 2009]
 */

//these libraries are **REQUIRED** to make __autoload() function without chicken-or-the-egg issues.
require_once(dirname(__FILE__) .'/cs_fileSystem.class.php');
require_once(dirname(__FILE__) .'/abstract/cs_version.abstract.class.php');
require_once(dirname(__FILE__) .'/abstract/cs_content.abstract.class.php');
require_once(dirname(__FILE__) .'/cs_globalFunctions.class.php');




function __autoload($class) {
	
	$tried = array();
	
	$fsRoot = dirname(__FILE__) .'/../../';
	if(defined('LIBDIR')) {
		$fsRoot = constant('LIBDIR');
	}
	$fs = new cs_fileSystem($fsRoot);
	$fs->cd('lib');
	if(!_autoload_hints_parser($class, $fs)) {
		$lsData = $fs->ls(null,false);
		
		$existsFunction = 'class_exists';
		//attempt to find it here...
		$tryThis = array();
		if(preg_match('/[aA]bstract/', $class)) {
			$myClass = preg_replace('/[aA]bstract/', '', $class);
			$tryThis[] = $class .'.abstract.class.php';
			$tryThis[] = $class .'.abstract.php';
			$tryThis[] = $myClass .'.abstract.class.php';
			$tryThis[] = $myClass .'.abstract.php';
		}
		elseif(preg_match('/[iI]nterface/', $class)) {
			$myClass = preg_replace('/[iI]nterface/', '', $class);
			$tryThis[] = $class .'.interface.class.php';
			$tryThis[] = $class .'.interface.php';
			$tryThis[] = $myClass .'.interface.class.php';
			$tryThis[] = $myClass .'.interface.php';
			$existsFunction = 'interface_exists';
		}
		$tryThis[] = $class .'.class.php';
		$tryThis[] = $class .'Class.php';
		$tryThis[] = $class .'.php';
		
		_autoload_directory_checker($fs, $class, $tryThis, $existsFunction);
		if(!class_exists($class) && !interface_exists($class)) {
			$gf = new cs_globalFunctions;
			$gf->debug_print(__FILE__ ." - line #". __LINE__ ."::: couldn't find (". $class ."), realcwd=(". $fs->realcwd ."), function=(". $existsFunction .")",1);
			$gf->debug_print($tried,1);
			$gf->debug_print($tryThis,1);
			if(function_exists('cs_debug_backtrace')) {
				cs_debug_backtrace(1);
			}
			exit;
		}
	}
}//end __autoload()

function _autoload_hints_parser($class, $fs) {
	$foundClass=false;
	if(defined('AUTOLOAD_HINTS') && file_exists(constant('AUTOLOAD_HINTS'))) {
		$data = $fs->read(constant('AUTOLOAD_HINTS'),true);
		$myHints = array();
		foreach($data as $s) {
			$bits = explode('|', rtrim($s));
			if(count($bits) == 2) {
				$myHints[$bits[1]] = $bits[0];
			}
		}
		#print "<pre>";
		#print_r($myHints);
		if(isset($myHints[$class])) {
			$tryFile = constant('LIBDIR') .'/'. $myHints[$class];
			if(file_exists($tryFile)) {
				require_once($tryFile);
				if(class_exists($class)) {
					$foundClass=true;
				}
			}
		}
	}
	return($foundClass);
}//end _autoload_hints_parser()


function _autoload_directory_checker($fs, $class, $lookForFiles, $existsFunction='class_exists') {
	$lsData = $fs->ls(null,false);
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
					if(class_exists($class)||interface_exists($class)) {
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
			$found = _autoload_directory_checker($fs, $class, $lookForFiles, $existsFunction);
			$fs->cdup();
			
			if($found === true) {
				break;
			}
		}
	}
	
	return($found);
}

?>
