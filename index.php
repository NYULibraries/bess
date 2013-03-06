<?php
require_once('lib/BobcatEmbedEmbed.php');
require_once('lib/BobcatEmbedGenerate.php');
require_once('lib/BobcatEmbedSearch.php');
/**
 * Make the decision of which class to instantiate based on URL given
 *
 * @author Barnaby Alter
 * @copyright 2013 New York University
 * @link http://web1.library.nyu.edu/bobcat
 * @license http://www.gnu.org/licenses/
 */
try {
	// Choose option based on querystring
	if (isset($_REQUEST['action'])) {
	  if ($_REQUEST['action'] == "generate") {
			// Initialize generator
			$bobcat_embed_generate = new Bobcat_Embed_Generate();
			$bobcat_embed_generate->init();
	  } elseif ($_REQUEST['action'] == "embed") {
			// Initialize embed
			$bobcat_embed = new Bobcat_Embed_Embed();
			$bobcat_embed->init();
		} elseif ($_REQUEST['action'] == "search") {
			// Initialize search
			$bobcat_search = new Bobcat_Embed_Search();
			$bobcat_search->init();
	  } else {
			throw new Exception($_REQUEST['action'] . " is not a recognized action");
	  }
	} else {
		throw new Exception("no action specified");
	}
} catch (Exception $e) {
	print "Error: " . $e->getMessage();
	exit ;
}