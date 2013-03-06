<?php
require_once('BobcatEmbed.php');
/**
 * Generates actual code for embedding based on format options
 *
 * @author Barnaby Alter
 * @copyright 2013 New York University
 * @link http://web1.library.nyu.edu/bobcat
 * @license http://www.gnu.org/licenses/
 */
class Bobcat_Embed_Embed extends BobCat_Embed
{
	
	/**
	 * Find request format and translate page appropriately
	 */
	public function init() {
		$xsl_params = "";
		$this->populateViews();

		// Decide which format to print results in
		// As XML
		if ($this->page_xml->request->format == "xml") {
			header("Content-type: text/xml");
			echo $this->page_xml->asXML();
		} 
		// As plain text
		elseif ($this->page_xml->request->format == "text") {
			$html = transformXML("xsl/embed.xsl", $this->page_xml->asXML(), $xsl_params);
			header("Content-type: text/plain");
			echo $html;
		} 
		// As embeddable Javascript text
		elseif ($this->page_xml->request->format == "embed_html_js") {
			$html = transformXML("xsl/embed.xsl", $this->page_xml->asXML(), $xsl_params);
			header("Content-type: text/plain");
			echo $this->javascriptWrap($html);
		} 
		// By default as XSLT translated HTML
		else {
			$html = transformXML("xsl/embed.xsl", $this->page_xml->asXML(), $xsl_params);
			header("Content-type: text/html");
			echo $html;
		}

	}
	
	/**
	 * javascriptWrap: wrap a string in document.write javascript commands to print as javascript document
	 *
	 * @param $html			[string] containing the html to convert into javascript
	 * @return 				[string] the input value with each line wrapped in a document.write()
	 */
	private function javascriptWrap($html) {
		$html_lines = explode("\n",$html);
		$wrapped = "//Javascript output\n";
		foreach ($html_lines as $line) {
			$wrapped .= "document.write('" . preg_replace("/\'/","\\'",$line) . "');\n";
		}
		return $wrapped;
	}


}