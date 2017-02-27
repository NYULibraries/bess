<?php
require_once('BobcatEmbed.php');
/**
 * Generate search URL from embedded search box
 *
 * @author Barnaby Alter
 * @copyright 2013 New York University
 * @link http://web1.library.nyu.edu/bobcat
 * @license http://www.gnu.org/licenses/
 */
class Bobcat_Embed_Search extends BobCat_Embed
{
	const DEBUG = false;
  /**
   * Upon submission of the form, generate the correct url to redirect to
   */
	public function init() {
		$url = "";
		$querystring = "";

    if (self::DEBUG) print_r($_REQUEST);

    foreach (array('addSearchFields', 'system') as $required_field) {
      if (!isset($_REQUEST[$required_field]))
        goto redirect_me;
    }

	  foreach ($_REQUEST['addSearchFields'] as $addField => $addFieldValue)
		  $querystring .= "&".$addField."=".urlencode($addFieldValue);

    if (self::DEBUG) print $querystring;

		// Structure search URL for Xerxes
	  if ($_REQUEST['system'] == 'xerxes') {
	  	$url .= $this->xerxes_search_url;
	  	$url .= ($_REQUEST['vid'] && strtolower($_REQUEST['vid']) != "nyu") ? "/".strtolower($_REQUEST['vid'])."?" : "?";
	  	$url .= $querystring;
	  	if ($_REQUEST['query'])	$url .= "&query=".urlencode($_REQUEST['query']);
	  }
	  // Structure search URL for Umlaut
	  elseif ($_REQUEST['system'] == 'umlaut') {
	  	$url .= $this->umlaut_search_url."/search/journal_search?";
	  	$url .= $querystring;
	  	if ($_REQUEST['vid'])	$url .= "&umlaut.institution=".$_REQUEST['vid'];
	  }
		// Structure search URL for LibGuides
		elseif ($_REQUEST['system'] == 'libguides') {
			$url .= $this->libguides_search_url;
			$url .= $querystring;
		}
	  // Structure search URL for Primo
	  elseif ($_REQUEST['system'] == 'primo') {
	  	if ($_REQUEST['search'] == 'dl') {
	  		$url .= $this->primo_dlsearch_url."?";
	  	  $url .= $querystring;
	  		$url .= "&loc=local,".$_REQUEST['scp_scps'];
	  		$url .= "&scp.scps=".$_REQUEST['scp_scps'];
	  		$url .= "&query=";
	  		$url .= ($_REQUEST['indexField']) ? $_REQUEST['indexField'] : "any";
	  		$url .= ",";
	  		$url .= ($_REQUEST['precisionOperator']) ? $_REQUEST['precisionOperator'] : "contains";
	  		$url .= ",";
	  		$url .= ($_REQUEST['addSearchFields']['vl(freeText0)']) ? $_REQUEST['addSearchFields']['vl(freeText0)'] : " ";
 	  	} else {
 	      $url .= $this->primo_search_url."?";
 	      $url .= $querystring;
 	      $url .= "&scp.scps=".$_REQUEST['scp_scps'];
 	  	}
	  	if ($_REQUEST['vid'])	$url .= "&institution=".$_REQUEST['vid']."&vid=".$_REQUEST['vid'];
	  	if ($_REQUEST['tab'])	$url .= "&tab=".$_REQUEST['tab'];
	  }

    if (self::DEBUG) {
      print $url;
      exit;
    }

    redirect_me:
		if ($url != "") @header("Location: ".$url."\n\n");
	}

}
