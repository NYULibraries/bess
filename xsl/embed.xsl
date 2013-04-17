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
	<xsl:value-of select="//gauges" />
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


</xsl:stylesheet>