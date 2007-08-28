<?php
/*
 * Created on Jan 9, 2007
 * 
 */

class cs_tabs {
	private $tabsArr;
	private $selectedTab;
	
	private $csPageObj;
	private $templateVar;
	
	/** Block row with the "selected" tab */
	private $selectedTabContent;
	
	/** Block row with the "unselected" tab */
	private $unselectedTabContent;
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Build the object, and parses the given template.  Tabs must be added & selected manually.
	 * 
	 * @param $csPageObj	(object) Instance of the class "cs_genericPage".
	 * @param $templateVar	(str,optional) What template var to find the tab blockrows in.
	 */
	public function __construct($csPageObj, $templateVar="tabs") {
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
			$this->load_tabs_template();
		}
	}//end __construct()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Returns a version string.
	 */
	public function get_version($asArray=FALSE) {
		return('0.7');
	}//end get_version()
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
		
		if(count($blockRows) < 2 || !isset($blockRows['selected_tab']) || !isset($blockRows['unselected_tab'])) {
			//not enough blocks, or they're not properly named.
			throw new exception("cs_tabs::load_tabs_template(): failed to retrieve the required block rows");
		}
		else {
			//got the rows.  Yay!
			$this->selectedTabContent = $blockRows['selected_tab'];
			$this->unselectedTabContent = $blockRows['unselected_tab'];
		}
	}//end load_tabs_template()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	public function add_tab_array(array $tabs) {
		$retval = 0;
		foreach($tabs as $name=>$url) {
			//call an internal method to do it.
			$retval += $this->add_tab($name, $url);
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
	public function add_tab($tabName, $url) {
		//add it to an array.
		$this->tabsArr[$tabName] = $url;
	}//end add_tab()
	//---------------------------------------------------------------------------------------------
	
	
	
	//---------------------------------------------------------------------------------------------
	/**
	 * Call this to add the parsed tabs into the page.
	 */
	public function display_tabs() {
		if(is_array($this->tabsArr) && count($this->tabsArr)) {
			$finalString = "";
			//loop through the array.
			foreach($this->tabsArr as $tabName=>$url) {
				$useTabContent = $this->unselectedTabContent;
				if(strtolower($tabName) === strtolower($this->selectedTab)) {
					//it's selected.
					$useTabContent = $this->selectedTabContent;
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
			throw new exception("cs_tabs::display_tabs(): no tabs to add");
		}
		
	}//end display_tabs()
	//---------------------------------------------------------------------------------------------
	
}
?>
