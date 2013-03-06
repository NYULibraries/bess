<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl" exclude-result-prefixes="php">
	
<xsl:variable name="breadcrumb_separator">&gt;</xsl:variable>

<xsl:variable name="text_header_snippet_generate">Embed</xsl:variable>
<xsl:variable name="text_snippet_example">Example</xsl:variable>
<xsl:variable name="text_snippet_display_options">Display Options</xsl:variable>
<xsl:variable name="text_snippet_noscript">Bobcat Embedded Search Box</xsl:variable>

<xsl:variable name="text_snippet_select_view">Select view:</xsl:variable>
<xsl:variable name="text_snippet_show_limit_to">Show "Limit to" options: <br /> (where applicable)</xsl:variable>
<xsl:variable name="text_snippet_default_tab">Default tab:</xsl:variable>

<xsl:variable name="text_snippet_display_yes">yes</xsl:variable>
<xsl:variable name="text_snippet_display_no">no</xsl:variable>
<xsl:variable name="text_snippet_display_all">All items</xsl:variable>
<xsl:variable name="text_snippet_display_all_record_parts">Anywhere in record</xsl:variable>

<xsl:variable name="text_snippet_which_jslib">Use JavaScript library:</xsl:variable>
<xsl:variable name="text_snippet_jslib_none">None</xsl:variable>
<xsl:variable name="text_snippet_jslib_prototype">Prototype</xsl:variable>

<xsl:variable name="text_snippet_show_css">Include CSS:</xsl:variable>
<xsl:variable name="text_snippet_show_css_explain">Including the CSS works imperfectly. If you need to, it's better to define CSS styles for the snippet in the external website itself. </xsl:variable>
<xsl:variable name="text_snippet_refresh">Refresh</xsl:variable>

<xsl:variable name="text_snippet_include_options">Include Options</xsl:variable>
<xsl:variable name="text_snippet_include_server">Server-side include url</xsl:variable>
<xsl:variable name="text_snippet_include_server_explain">Preferred method of inclusion, if your external website can support a server-side include. </xsl:variable>
<xsl:variable name="text_snippet_include_javascript">Javascript widget</xsl:variable>
<xsl:variable name="text_snippet_include_javascript_explain">Should work in any external website that allows javascript, but viewers' browsers must support javascript. </xsl:variable>

<xsl:variable name="text_snippet_include_html">HTML Source</xsl:variable>
<xsl:variable name="text_snippet_include_html_explain">Last resort. If this is your only option, you can embed this HTML source directly into your external website. However, if data or features change here, your snippet will not reflect those changes, and may even stop working. Use with care. </xsl:variable>
<xsl:variable name="text_snippet_include_html_source">View snippet source</xsl:variable>

<xsl:variable name="text_footer">NYU Division of Libraries</xsl:variable>

</xsl:stylesheet>