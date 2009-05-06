<?php
/*
 * Created on Jan 9, 2007
 * 
 */

require_once(dirname(__FILE__) .'/abstract/cs_content.abstract.class.php');


class cs_tabs extends cs_contentAbstract {
	private $tabsArr=array();
	private $selectedTab;
	
	private $csPageObj;
	private $templateVar;
	
	/** This is the default suffix to use when none is given during the add_tab() call. */
	private $defaultSuffix='tab';
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Build the object, and parses the given template.  Tabs must be added & selected manually.
	 * 
	 * @param $csPageObj	(object) Instance of the class "cs_genericPage".
	 * @param $templateVar	(str,optional) What template var to find the tab blockrows in.
	 */
	public function __construct(cs_genericPage $csPageObj, $templateVar="tabs") {
		parent::__construct(false);
		if(is_null($csPageObj) || !is_object($csPageObj) || get_class($csPageObj) !== 'cs_genericPage') {
			//can't continue without that!
			throw new exception("cs_tabs::__construct(): cannot load without cs_genericPage{} object (". get_class($csPageObj) .")");
		}
		else {
			//set it as a member.
			$this->csPageObj = $csPageObj;
		}
		
		
		if(is_null($templateVar) || strlen($templateVar) < 3) {
			//no template name?  AHH!!!
			throw new exception("cs_tabs::__construct(): failed to specify proper template file");
		}
		else {
			//set the internal var.
			$this->templateVar = $templateVar;
		}
	}//end __construct()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Loads & parses the given tabs template.  Requires that the given template has "selected_tab" 
	 * and "unselected_tab" block row definitions.
	 * 
	 * @param (void)
	 * @return (void)
	 */
	private function load_tabs_template() {
		//now let's parse it for the proper block rows.
		$blockRows = $this->csPageObj->rip_all_block_rows($this->templateVar);
		
		#if(count($blockRows) < 2) {
		#	//not enough blocks, or they're not properly named.
		#	throw new exception("cs_tabs::load_tabs_template(): failed to retrieve the required block rows");
		#}
	}//end load_tabs_template()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function add_tab_array(array $tabs, $useSuffix=null) {
		$retval = 0;
		foreach($tabs as $name=>$url) {
			//call an internal method to do it.
			$retval += $this->add_tab($name, $url, $useSuffix);
		}
		
		return($retval);
	}//end add_tab_array()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Sets the given tab as selected, provided it exists.
	 * 
	 * @param $tabName		(str) Sets this tab as selected.
	 * @return (void)
	 */
	public function select_tab($tabName) {
		$this->selectedTab = $tabName;
	}//end select_tab()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function add_tab($tabName, $url, $useSuffix=null) {
		
		//set the default suffix.
		if(is_null($useSuffix)) {
			$useSuffix = $this->defaultSuffix;
		}
		
		//add it to an array.
		$this->tabsArr[$tabName] = array(
			'url'		=> $url,
			'suffix'	=> $useSuffix
		);
	}//end add_tab()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Call this to add the parsed tabs into the page.
	 */
	public function display_tabs() {
		
		if(!strlen($this->selectedTab)) {
			$keys = array_keys($this->tabsArr);
			$this->select_tab($keys[0]);
		}
		
		if(is_array($this->tabsArr) && count($this->tabsArr)) {
			$this->load_tabs_template();
			$finalString = "";
			//loop through the array.
			foreach($this->tabsArr as $tabName=>$tabData) {
				
				$url = $tabData['url'];
				$suffix = $tabData['suffix'];
				
				$blockRowName = 'unselected_'. $suffix;
				if(strtolower($tabName) == strtolower($this->selectedTab)) {
					$blockRowName = 'selected_'. $suffix;
				}
				
				if(isset($this->csPageObj->templateRows[$blockRowName])) {
					$useTabContent = $this->csPageObj->templateRows[$blockRowName];
				}
				else {
					throw new exception(__METHOD__ ."(): failed to load block row (". $blockRowName .") for tab (". $tabName .")". $this->csPageObj->gfObj->debug_print($this->csPageObj->templateRows,0));
				}
				
				$parseThis = array(
					'title'	=> $tabName,
					'url'	=> $url
				);
				$finalString .= $this->csPageObj->mini_parser($useTabContent, $parseThis, '%%', '%%');
			}
			
			//now parse it onto the page.
			$this->csPageObj->add_template_var($this->templateVar, $finalString);
		}
		else {
			//something bombed.
			throw new exception(__METHOD__ ."(): no tabs to add");
		}
		
	}//end display_tabs()
	//---------------------------------------------------------------------------------------------
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Determine if the given named tab exists (returns boolean true/false)
	 */
	public function tab_exists($tabName) {
		$retval = false;
		if(isset($this->tabsArr[$tabName])) {
			$retval = true;
		}
		return($retval);
	}//end tab_exists()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function rename_tab($tabName, $newTabName) {
		if($this->tab_exists($tabName) && !$this->tab_exists($newTabName)) {
			$tabContents = $this->tabsArr[$tabName];
			unset($this->tabsArr[$tabName]);
			$this->tabsArr[$newTabName] = $tabContents;
		}
		else {
			throw new exception(__METHOD__ .": tried to rename non-existent tab (". $tabName .") to (". $newTabName .")");
		}
	}//end rename_tab();
	//---------------------------------------------------------------------------------------------
	
}
?>
