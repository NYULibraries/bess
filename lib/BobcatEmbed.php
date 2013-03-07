<?php
require_once('xml_functions.php');
/**
 * Super class for Embed and Generate to load config options and shared functions
 *
 * @author Barnaby Alter
 * @copyright 2013 New York University
 * @link http://web1.library.nyu.edu/bobcat
 * @license http://www.gnu.org/licenses/
 */
class BobCat_Embed
{
	
	private $config_file = "config/settings.xml";
	private $metalib_url = null;
	private $metalib_user = null;
	private $metalib_pass = null;
	private $metalib_inst = null;
	
	protected $config_xml = null;
	protected $page_xml = null;
	protected $base_url = null;
	protected $primo_search_url = null;
	protected $primo_dlsearch_url = null;
	protected $xerxes_search_url = null;
	protected $umlaut_search_url = null;

  /**
   * Turn the page into an XML document based on the config 
   * settings so it can be translated by XSLT
   */
	public function __construct() {
	  
    // Find environment specific settings file, if config/settings is not present
    if (file_exists("config/settings." . $_SERVER['PHP_ENV'] . ".xml")) {
      $this->config_file = "config/settings." . $_SERVER['PHP_ENV'] . ".xml";
	  } elseif (!file_exists($this->config_file)) {
	    $this->config_file = "settings.local.xml";
	  }
		
		//Retrieve config file and validate that it is in the proper format
		if ( ! $this->config_xml instanceof SimpleXMLElement ) {
			try {
				if ( file_exists($this->config_file) ) {
					$this->config_xml = simplexml_load_file($this->config_file);
				} else {
					throw new Exception("__construct: could not find configuration file");
				}
			} catch (Exception $e) {
				print "Error: " . $e->getMessage();
				exit ;
			}
		}
	
		//Initialize private vars
		$this->metalib_url = $this->getConfigOption('metalib_url');
		$this->metalib_user = $this->getConfigOption('metalib_user');
		$this->metalib_pass = $this->getConfigOption('metalib_pass');
		$this->metalib_inst = $this->getConfigOption('metalib_inst');
	
		//Initialize this page's XML
		$this->page_xml = new SimpleXMLElement("<bobcat_embed />");
		
		//Add all config variables
		$this->page_xml->addChild('config','');
		if (count($this->config_xml->xpath("//config[not(@pass) or @pass='true']")) > 0) {
			foreach ($this->config_xml->xpath("//config[not(@pass) or @pass='true']") as $config) {
				$this->page_xml->config->addChild($this->getAttributeValue($config, "name"), $config);
			}
		}

		//Populate additional global vars for sub class use
		$this->primo_search_url = $this->getConfigOption('primo_search_url');
		$this->primo_dlsearch_url = $this->getConfigOption('primo_dlsearch_url');
		$this->xerxes_search_url = $this->getConfigOption('xerxes_search_url');
		$this->umlaut_search_url = $this->getConfigOption('umlaut_search_url');
		
		$this->page_xml->config->addChild("base_url", $_SERVER["SERVER_NAME"] . $_SERVER["SCRIPT_NAME"]);
		
		//$this->page_xml->addChild('metalib_config','');
		//$this->page_xml->metalib_config->addChild('session_id',$this->retrieveMetaLibSessionId());	
		
		//Add query string options to XML
		$this->page_xml->addChild('request','');
		$this->page_xml->request->addChild('unique_key',$this->getUniqueKey(10));

    if (isset($_SERVER["QUERY_STRING"])) {
  		$request_params = explode('&',$_SERVER["QUERY_STRING"]);
  		if (count($request_params) > 0) {
  			$this->page_xml->request->addChild('querystring', urlencode($_SERVER["QUERY_STRING"]));
  			foreach ($request_params as $p) {
  				if ($p != "") {
  				$p_parts = explode('=',$p);
  				$this->page_xml->request->addChild($p_parts[0],$p_parts[1]);
  				}
  			}
  		}
	  }

	}
	
	/**
	 * getConfigOption: retrieve config option value from config file
	 *
	 * @param $option			[string] containing the title of the value to retrieve form the config file
	 * @return 					[string] containing the value of $option
	 */
	protected function getConfigOption($option) {
		try {
			$option_container = $this->config_xml->xpath("//config[@name='".$option."']"); 
			if ($option_container[0] instanceof SimpleXMLElement) {
			 	return $option_container[0][0];
			} else {
				throw new Exception("getConfigOption: could not retrieve config option");
			}
		} catch (Exception $e) {
			print "Error: " . $e->getMessage();
			exit ;
		}
	}
	
	/**
	 * getAttributeValue retrieve attribute value from config file
	 *
	 * @param $el				[string] SimplXMLElement with the attribute
	 * @param $attr			[string] Attribute to extract
	 * @return 					[string] containing the value of $option
	 */
	protected function getAttributeValue($el, $attr) {
		try {
			if ($el instanceof SimpleXMLElement) {
				foreach($el->attributes() as $a => $b) {
					if ($a == $attr)
						return $b;
				}
			 	return null;
			} else {
				throw new Exception("getAttributeValue: element is not SimpleXMLElement");
			}
		} catch (Exception $e) {
			print "Error: " . $e->getMessage();
			exit ;
		}
	}

	/**
	 * getViews: retrieve an object containing all the views specified in the config file
	 *
	 * @return 			[SimpleXMLElement] object containing objects of views
	 */
	protected function getViews() {
		try {
			if (isset($_REQUEST['action']) && $_REQUEST['action'] == "embed" && isset($_REQUEST['disp_select_view'])) {
				$views_container = $this->config_xml->xpath("//views/view[@id='".$_REQUEST['disp_select_view']."']"); 
			} else {
				$views_container = $this->config_xml->xpath("//views"); 
			}
			if ($views_container[0] instanceof SimpleXMLElement) {
			 	return $views_container;
			} else {
				throw new Exception("getViews: could not retrieve view information");
			}
		} catch (Exception $e) {
			print "Error: " . $e->getMessage();
			exit ;
		}
	}
	
	/**
	 * retrieveMetaLibSessionId: retrieve a MetaLib session ID for making other x-service calls
	 *
	 * @return 			[string] containing session ID
	 */
	private function retrieveMetaLibSessionId() {
		try {
			//Retrieve ML session id
			$ml_auth = simplexml_load_string(getXML($this->metalib_url."/X?op=login_request&user_name=".$this->metalib_user."&user_password=".$this->metalib_pass));
			$ml_auth_path = $ml_auth->xpath("//session_id");
		
			if ($ml_auth_path[0] instanceof SimpleXMLElement) {
			 	return $ml_auth_path[0][0];
			} else {
				throw new Exception("retrieveMetaLibSessionId: could not retrieve metalib session");
			}
		} catch (Exception $e) {
			print "Error: " . $e->getMessage();
			exit ;
		}
	}
	
	/**
	 * retrieveMetaLibQuickSets: retrieve an object with all the PRIMO user quicksets from MetaLib
	 *
	 * @return 			[SimpleXMLElement] object containing all PRIMO user quicksets
	 */
	private function retrieveMetaLibQuickSets() {
		//Retrieve MLQuickSets
		$ml_qs = simplexml_load_string(getXML("$this->metalib_url/X?op=retrieve_quick_sets_request&verification=$this->metalib_pass&source_id=$this->metalib_user&institute=$this->metalib_inst&session_id=".$this->page_xml->metalib_config->session_id));
		$ml_qs_path = $ml_qs->xpath("//retrieve_quick_sets_response");
		return $ml_qs_path;
	}
		
	/**
	 * populateViews: generate an XML subtree for each view in the config table
	 */
	protected function populateViews() {
		//load up subtree of views from config file
		$views = $this->getViews();
		
		// Create new DOMElements from the two SimpleXMLElements
		$dom_master = dom_import_simplexml($this->page_xml);
		$dom_sub  = dom_import_simplexml($views[0]);

		// Import the views into the page xml document
		$dom_sub  = $dom_master->ownerDocument->importNode($dom_sub, TRUE);

		// Append the view tree to page xml in the dictionary
		$dom_master->appendChild($dom_sub);
	}
	
	/**
	 * getUniqueKey: generate a unique key of size $length
	 */
	private function getUniqueKey($length = 0) {
    	$code = md5(uniqid(rand(), true));
    	if ($length > 0) return substr($code, 0, $length);
		else return $code;
    }

}