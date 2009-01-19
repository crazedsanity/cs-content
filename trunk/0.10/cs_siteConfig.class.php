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
	
	/** XMLParser{} object, for reading XML config file. */
	private $xmlReader;
	
	/** cs_fileSystemClass{} object, for writing/updating XML config file 
	 * (only available if file is writable)
	 */
	private $xmlWriter;
	
	/** XMLBuilder{} object, for updating XML. */
	private $xmlBuilder;
	
	/** cs_fileSystemClass{} object, for handling generic file operations (i.e. reading) */
	private $fs;
	
	/** boolean flag indicating if the given config file is readOnly (false=read/write) */
	private $readOnly;
	
	/** Directory for the config file. */
	private $configDirname;
	
	/** Active section of the full site configuration. */
	private $activeSection;
	
	/** The FULL configuration file, instead of just the active section. */
	private $fullConfig=array();
	
	/** arrayToPath{} object. */
	private $a2p;
	
	/** Prefix to add to every index in GLOBALS and CONSTANTS. */
	private $setVarPrefix;
	
	/** Sections available within the config */
	private $configSections=array();
	
	
	//-------------------------------------------------------------------------
	/**
	 * Constructor.
	 * 
	 * @param $configFileLocation	(str) URI for config file.
	 * @param $section				(str,optional) set active section (default=MAIN)
	 * @param $setVarPrefix			(str,optional) prefix to add to all global & constant names.
	 * 
	 * @return NULL					(PASS) object successfully created
	 * @return exception			(FAIL) failed to create object (see exception message)
	 */
	public function __construct($configFileLocation, $section='MAIN', $setVarPrefix=null) {
		
		$section = strtoupper($section);
		$this->setVarPrefix=$setVarPrefix;
		
		$this->gf = new cs_globalFunctions;
		$this->gf->debugPrintOpt=1;
		
		if(strlen($configFileLocation) && file_exists($configFileLocation)) {
			
			$this->configDirname = dirname($configFileLocation);
			$this->fs = new cs_fileSystemClass($this->configDirname);
			
			$this->xmlReader = new XMLParser($this->fs->read($configFileLocation));
			
			if($this->fs->is_writable($configFileLocation)) {
				$this->readOnly = false;
				$this->xmlWriter = new cs_fileSystemClass($this->configDirname);
				
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
				$this->set_active_section($section);
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
	/** 
	 * Sets the active section.
	 * 
	 * @param $section		(str) section to be set as active.
	 * 
	 * @return VOID			(PASS) section was set successfully.
	 * @return exception	(FAIL) problem encountred setting section. 
	 */
	public function set_active_section($section) {
		$section = strtoupper($section);
		if(in_array($section, $this->configSections)) {
			$this->activeSection = $section;
		}
		else {
			throw new exception(__METHOD__ .": invalid section (". $section .")");
		}
	}//end set_active_section($section)
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Parse the configuration file.  Handles replacing {VARIABLES} in values, 
	 * sets items as global or as constants, and creates array indicating the 
	 * available sections from the config file.
	 * 
	 * @param VOID			(void) no arguments accepted.
	 * 
	 * @return NULL			(PASS) successfully parsed configuration
	 * @return exception	(FAIL) exception indicates problem encountered.
	 */
	private function parse_config() {
		$data = $this->xmlReader->get_path($this->xmlReader->get_root_element());
		
		$specialVars = array(
			'_DIRNAMEOFFILE_'	=> $this->configDirname
		);
		$parseThis = array();
		
		
		$this->configSections = array();
		
		foreach($data as $section=>$secData) {
			//only handle UPPERCASE index names; lowercase indexes are special entries (i.e. "type" or "attributes"
			if($section == strtoupper($section)) {
				$this->configSections[] = $section;
				foreach($secData as $itemName=>$itemValue) {
					$attribs = array();
					if(is_array($itemValue['attributes'])) {
						$attribs = $itemValue['attributes'];
					}
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
					
					if($attribs['SETGLOBAL']) {
						$GLOBALS[$this->setVarPrefix . $itemName] = $itemValue;
					}
					if($attribs['SETCONSTANT']) {
						define($this->setVarPrefix . $itemName, $itemValue);
					}
				}
			}
		}
		$this->a2p = new arrayToPath($data);
	}//end parse_config()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Retrieve all data about the given section.
	 * 
	 * @param $section		(str) section to retrieve.
	 * 
	 * @return array		(PASS) array contains section data.
	 * @return exception	(FAIL) exception indicates problem.
	 */
	public function get_section($section) {
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
	/**
	 * Retrieves value from the active section, or from another (other sections 
	 * specified like "SECTION/INDEX").
	 * 
	 * @param $index		(str) index name of value to retrieve.
	 * 
	 * @return mixed		(PASS) returns value of given index.
	 * 
	 * NOTE::: this will return NULL if the given index or section/index does
	 * not exist.
	 */
	public function get_value($index) {
		if(preg_match("/\//", $index)) {
			//section NOT given, assume they're looking for something in the active section.
			$index = $this->activeSection ."/". $index;
		}
		$retval = $this->a2p->get_data($index .'/value');
		return($retval);
	}//end get_value()
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	/**
	 * Retrieves list of valid configuration sections, as defined by 
	 * parse_config().
	 * 
	 * @param VOID			(void) no parameters accepted.
	 * 
	 * @return array		(PASS) array holds list of valid sections.
	 * @return exception	(FAIL) exception gives error.
	 */
	public function get_valid_sections() {
		if(is_array($this->configSections) && count($this->configSections)) {
			$retval = $this->configSections;
		}
		else {
			throw new exception(__METHOD__ .": no sections defined, probably invalid configuration");
		}
		
		return($retval);
	}//end get_valid_sections()
	//-------------------------------------------------------------------------
	
}//end cs_siteConfig

?>
