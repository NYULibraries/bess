<?php
/**
* Shared functions dealing with loading and processing XML files
*/

/**
 * transformXML: transforms an XML document with the XSLT stylesheet and returns the content as a string, usually of HTML
 *
 * @param xsl_filename			absolute location to XSLT file
 * @param xml_filename			absolute location to XML file
 * @param xsl_params			any additional xsl parameters
 * @return 						processed XML through the XSLT, mostly in HTML or plain text
 */
function transformXML ($xsl_filename, $xml_filename, $xsl_params) {
  $return_xml = "";
  if (PHP_VERSION >= 5) {
    //Load XSL
    $xsl = new DOMDocument;
    $xsl->load($xsl_filename);
    
    //Load XML
    $xml = new DOMDocument;
    if (file_exists($xml_filename)) {
      $xml->loadXML(getXML($xml_filename));
    } else {
      $xml->loadXML($xml_filename);
    }
    
    //Configure XSLT Processor
    $proc = new XSLTProcessor();
    
    //Attach XSL
    $proc->importStyleSheet($xsl);
    
    //Set XSL Parameters
    if(!is_null($xsl_params) && is_array($xsl_params)) {
      foreach ($xsl_params as $param_name => $param_value) {
        $proc->setParameter("", "$param_name", "$param_value");
      }
    }
    
    //Transform XML
    $return_xml = $proc->transformToXML($xml);
    $proc = null;
  }
  return $return_xml;
}


/**
 * getXML: retrieve XML contents as a string from file 
 *
 * @param xml_filename		absolute location to XML file
 * @return 					retrieved XML
 */
function getXML ($xml_filename) {
  $xml = file_get_contents($xml_filename);
  return $xml;
}
