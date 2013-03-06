<?php
require_once('BobcatEmbed.php');
/**
 * Shows user-friendly page for creating embeddable snippets
 *
 * @author Barnaby Alter
 * @copyright 2013 New York University
 * @link http://web1.library.nyu.edu/bobcat
 * @license http://www.gnu.org/licenses/
 */
class Bobcat_Embed_Generate extends BobCat_Embed
{
	
	/**
	 * Find request format and translate page appropriately
	 */
	public function init() {
		$xsl_params = "";
		$this->populateViews();
		
		// Decide which format to print results in
		// As XML, mainly for debugging...no real reason to view generate page as XML
		if ($this->page_xml->request->format == "xml") {
			@header("Content-type: text/xml");
			echo $this->page_xml->asXML();
		} 
		// Default view is as XSLT translated HTM:
		else {
			$html = transformXML("xsl/embed_gen.xsl", $this->page_xml->asXML(), $xsl_params);
			@header("Content-type: text/html");
			echo $html;
		}
	}
	

}