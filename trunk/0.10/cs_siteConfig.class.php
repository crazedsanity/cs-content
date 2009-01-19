<?php

/*
 * A class for handling configuration of database-driven web applications.
 * 
 * NOTICE::: this class requires that cs-phpxml and cs-arraytopath are both available
 * at the same directory level as cs-content; all projects are SourceForge.net projects,
 * using their unix names ("cs-phpxml" and "cs-arrayToPath").  The cs-phpxml project 
 * requires cs-arrayToPath for parsing XML paths.
 * 
 * SVN INFORMATION:::
 * SVN Signature:::::::: $Id$
 * Last Committted Date: $Date$
 * Last Committed Path:: $HeadURL$
 * 
 */

require_once(dirname(__FILE__). '/../cs-phpxml/xmlParserClass.php');
require_once(dirname(__FILE__) .'/../cs-phpxml/xmlBuilderClass.php');

class cs_siteConfig {
	
	private $xmlReader;
	private $xmlWriter;
	private $xmlBuilder;
	private $fs;
	private $readOnly;
	private $configDirname;
	
	/** Active section of the full site configuration. */
	private $activeSection;
	
	/** The FULL configuration file, instead of just the active section. */
	private $fullConfig=array();
	
	/** arrayToPath{} object. */
	private $a2p;
	
	
	//-------------------------------------------------------------------------
	/**
	 * Constructor.
	 * 
	 * @$configFileLocation		(str) URI for config file.
	 */
	public function __construct($configFileLocation, $section='MAIN', $setVarPrefix=null) {
		
		//TODO: don't use cs_globalFunctions{} if unneeded.
		$this->gf = new cs_globalFunctions;
		$this->gf->debugPrintOpt=1;
		
		$this->set_active_section($section);
		
		if(strlen($configFileLocation) && file_exists($configFileLocation)) {
			
			$this->configDirname = dirname($configFileLocation);
			$this->fs = new cs_fileSystemClass($this->configDirname);
			
			$this->xmlReader = new XMLParser($this->fs->read($configFileLocation));
			
			if($this->fs->is_writable($configFileLocation)) {
				$this->readOnly = false;
			}
			else {
				$this->readOnly = true;
			}
		}
		else {
			throw new exception(__METHOD__ .": invalid configuration file (". $configFileLocation .")");
		}
		
		if(strlen($section)) {
			try {
				$this->parse_config();
				$this->config = $this->get_section($section);
			}
			catch(exception $e) {
				throw new exception(__METHOD__ .": invalid section (". $section ."), DETAILS::: ". $e->getMessage());
			}
		}
		else {
			throw new exception(__METHOD__ .": no section given (". $section .")");
		}
	}//end __construct()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function set_active_section($section) {
		$this->activeSection = strtoupper($section);
	}//end set_active_section($section)
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	private function parse_config() {
		$data = $this->xmlReader->get_path($this->xmlReader->get_root_element());
		
		$specialVars = array(
			'_DIRNAMEOFFILE_'	=> $this->configDirname
		);
		$parseThis = array();
		
		foreach($data as $section=>$secData) {
			//only handle UPPERCASE index names; lowercase indexes are special entries (i.e. "type" or "attributes"
			if($section == strtoupper($section)) {
				$this->gf->debug_print(__METHOD__ .": handling (". $section .")");
				foreach($secData as $itemName=>$itemValue) {
					$itemValue = $itemValue['value'];
					if(preg_match("/{/", $itemValue)) {
						$origVal = $itemValue;
						$itemValue = $this->gf->mini_parser($itemValue, $specialVars, '{', '}');
						$itemValue = $this->gf->mini_parser($itemValue, $parseThis, '{', '}');
						$itemValue = preg_replace("/[\/]{2,}/", "/", $itemValue);
					}
					$parseThis[$itemName] = $itemValue;
					$parseThis[$section ."/". $itemName] = $itemValue;
					$data[$section][$itemName]['value'] = $itemValue;
				}
			}
		}
		$this->a2p = new arrayToPath($data);
	}//end parse_config()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function get_section($section) {
		$this->gf->debug_print(__METHOD__ .": section=(". $section .")");
		$data = $this->a2p->get_data($section);
		
		if(is_array($data) && count($data) && $data['type'] == 'open') {
			unset($data['type']);
			$retval = $data;
		}
		else {
			throw new exception(__METHOD__ .": invalid section or no data (". $data['type'] .")");
		}
		
		return($retval);
	}//end get_section()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	public function get_value($index) {
		if(preg_match("/\//", $index)) {
			//section NOT given, assume they're looking for something in the active section.
			$index = $this->activeSection ."/". $index;
		}
		$retval = $this->a2p->get_data($index .'/value');
		return($retval);
	}//end get_value()
	//-------------------------------------------------------------------------
	
	
}//end cs_siteConfig

?>
