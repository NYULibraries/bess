<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl" exclude-result-prefixes="php">
	
<xsl:import href="includes.xsl" />

<!--xsl:output method="html" encoding="utf-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/-->

<xsl:output method="html" encoding="utf-8" indent="yes" />

<!--
	TEMPLATE
-->
<xsl:template match="/*">
	<xsl:call-template name="main" />
	<xsl:call-template name="gauges" />
</xsl:template>

<!--
	TEMPLATE: PAGE_NAME
-->
<xsl:template name="page_name">
</xsl:template>

<!--
	TEMPLATE: MAIN
-->
<xsl:template name="main">
	<!-- call template to show searchbox -->
	<xsl:call-template name="searchbox_embed" />
</xsl:template>

<xsl:template name="gauges">
  <xsl:if test="//gauges">
    <xsl:element name="script">
      <xsl:attribute name="type">text/javascript</xsl:attribute>
      var gauges_apikey = '<xsl:value-of select="//gauges" />';
      var _gauges = _gauges || [];
      (function() {
        var t   = document.createElement('script');
        t.type  = 'text/javascript';
        t.async = true;
        t.id    = 'gauges-tracker';
        t.setAttribute('data-site-id', gauges_apikey);
        t.src = '//secure.gaug.es/track.js';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(t, s);
      })();
    </xsl:element>
  </xsl:if>
</xsl:template>


</xsl:stylesheet>