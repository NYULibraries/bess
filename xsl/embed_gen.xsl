<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl" exclude-result-prefixes="php">

<xsl:import href="includes.xsl" />

<xsl:output method="html" encoding="utf-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>

<xsl:variable name="noscript_content">
	<a>
		<xsl:attribute name="href">
			<xsl:call-template name="embed_direct_url" />
		</xsl:attribute>
		<xsl:value-of select="$text_snippet_noscript" />
	</a>
</xsl:variable>

<!--
	TEMPLATE: EMBED_DIRECT_URL
	create url for direct link to embed widget
-->
<xsl:template name="embed_direct_url">
	<xsl:value-of select="$base_url" />
	<xsl:text>/embed?</xsl:text>
	<xsl:call-template name="construct_options_from_querystring" />
</xsl:template>

<!--
	TEMPLATE: EMBED_JS_CALL_URL
	create url for javascript widget
-->
<xsl:template name="embed_js_call_url">
	<xsl:call-template name="embed_direct_url" />
	<xsl:text>&amp;format=embed_html_js</xsl:text>
</xsl:template>

<!--
	TEMPLATE: CONSTRUCT_OPTIONS_FROM_QUERYSTRING
	generate options (as query string) for embed url
	from current settings, or use defaults
-->
<xsl:template name="construct_options_from_querystring">
	<xsl:text>disp_select_view=</xsl:text>
	<xsl:choose>
		<xsl:when test="//request/disp_select_view"><xsl:value-of select="//request/disp_select_view" /></xsl:when>
		<xsl:otherwise><xsl:value-of select="//views/view[@default='true']/@id" /></xsl:otherwise>
	</xsl:choose>
	<xsl:text>&amp;disp_default_tab=</xsl:text>
	<xsl:choose>
		<xsl:when test="//request/disp_default_tab">
			<xsl:value-of select="//request/disp_default_tab" />
		</xsl:when>
		<xsl:when test="//request/disp_select_view">
			<xsl:value-of select="//view[@id=//request/disp_select_view]/tabs/tab[@default='true']/@name" />
		</xsl:when>
		<xsl:otherwise><xsl:value-of select="//views/view[@default='true']/tabs/tab[@default='true']/@name" /></xsl:otherwise>
	</xsl:choose>
	<xsl:text>&amp;disp_show_limit_to=</xsl:text>
	<xsl:choose>
		<xsl:when test="//request/disp_show_limit_to">
			<xsl:value-of select="//request/disp_show_limit_to" />
		</xsl:when>
		<xsl:otherwise>true</xsl:otherwise>
	</xsl:choose>
	<xsl:text>&amp;disp_embed_css=</xsl:text>
	<xsl:choose>
		<xsl:when test="//request/disp_embed_css">
			<xsl:value-of select="//request/disp_embed_css" />
		</xsl:when>
		<xsl:otherwise>true</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
	TEMPLATE
-->
<xsl:template match="/*">
	<xsl:call-template name="surround" />
</xsl:template>

<!--
	TEMPLATE: PAGE_NAME
-->
<xsl:template name="page_name">
	<xsl:value-of select="$text_header_snippet_generate" />
</xsl:template>


<!--
	TEMPLATE: MAIN
-->
<xsl:template name="main">

	<script type="text/javascript">
		var bobcat_embed_base_url = '<xsl:call-template name="embed_direct_url" />';
		var bobcat_embed_noscript_content = '<xsl:copy-of select="$text_snippet_noscript"/>';
	</script>

	<h1><xsl:call-template name="page_name" /></h1>

	<div class="yui-gd">

		<div class="yui-u first">

			<div id="snippetControl">

				<!-- widget generator form -->

				<form method="GET" name="form_generator" id="generator" action="{$base_url}/embed_gen">

					<fieldset id="snippetDisplay">
						<legend><h2><xsl:copy-of select="$text_snippet_display_options" /></h2></legend>

						<table class="snippetDisplayTable">

							<!-- select primo view to use, refreshed page and drives all other options -->

							<tr>
							<td><label for="disp_select_view"><xsl:copy-of select="$text_snippet_select_view" /></label></td>
							<td>
								<select onchange="javascript:bobcat_embed_submit_form(this);" id="disp_select_view" name="disp_select_view">
									<xsl:for-each select="//views/view">
									<option value="{@id}">
										<xsl:if test="//request/disp_select_view = @id">
										<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="@title" />
									</option>
									</xsl:for-each>
								</select>
							</td>
							</tr>

							<!-- select which tab to display by default, ajax calls to change example and embed urls -->

							<tr>
							<td><label for="disp_default_tab"><xsl:copy-of select="$text_snippet_default_tab" /></label></td>
							<td>
								<select onchange="javascript:bobcat_embed_update('disp_default_tab','{$unique_key}');" name="disp_default_tab" id="disp_default_tab">

									<xsl:for-each select="//views/view[@id=$id]/tabs/tab">
									<option value="{@name}">
										<xsl:if test="//request/disp_default_tab = @name">
										<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="@title" />
									</option>
									</xsl:for-each>

								</select>

							</td>
							</tr>

							<!-- display limit to options -->

							<tr>
							<td><label for="disp_show_limit_to"><xsl:copy-of select="$text_snippet_show_limit_to" /></label></td>
							<td>
							<select onchange="javascript:bobcat_embed_update('disp_show_limit_to','{$unique_key}');"  name="disp_show_limit_to" id="disp_show_limit_to">
								<option value="true">
									<xsl:if test="//request/disp_show_limit_to = 'true'">
									<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="$text_snippet_display_yes" />
								</option>
								<option value="false">
									<xsl:if test="//request/disp_show_limit_to = 'false'">
									<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="$text_snippet_display_no" />
								</option>
							</select>
							</td>
							</tr>


							<tr>
							<td><label for="disp_embed_css"><xsl:copy-of select="$text_snippet_show_css" /></label></td>
							<td>
							<select onchange="javascript:bobcat_embed_update('disp_embed_css','{$unique_key}');" id="disp_embed_css" name="disp_embed_css">
								<option value="true">
									<xsl:if test="request/disp_embed_css = 'true'">
									<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="$text_snippet_display_yes" />
								</option>
								<option value="false">
									<xsl:if test="request/disp_embed_css = 'false'">
									<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="$text_snippet_display_no" />
								</option>
							</select>
							</td>
							</tr>

						</table><!-- / end table with display options -->

					<!-- CSS include options -->

					<p class="optionInfo"><xsl:copy-of select="$text_snippet_show_css_explain" /></p>

					<p><input type="submit" value="{$text_snippet_refresh}" /></p>

					</fieldset>

					<!-- show options for embedding -->

					<div id="snippetInclude">

						<h2><xsl:copy-of select="$text_snippet_include_options" /></h2>

						<!-- SSI include - direct link -->

						<h3>1. <label for="direct_url_content"><xsl:copy-of select="$text_snippet_include_server" /></label></h3>
						<p><xsl:copy-of select="$text_snippet_include_server_explain" /></p>

						<textarea id="direct_url_content" readonly="yes" class="displayTextbox">
							<xsl:call-template name="embed_direct_url" />
						</textarea>

						<!-- JavaScript code -->

						<h3>2. <label for="js_widget_content"><xsl:copy-of select="$text_snippet_include_javascript" /></label></h3>
						<p><xsl:copy-of select="$text_snippet_include_javascript_explain" /></p>

						<textarea id="js_widget_content" readonly="yes" class="displayTextbox">
							<script type="text/javascript" charset="utf-8" >
								<xsl:attribute name="src"><xsl:call-template name="embed_js_call_url" /></xsl:attribute>
							</script>
							<noscript>
								<xsl:copy-of select="$noscript_content" />
							</noscript>
						</textarea>

						<!-- Link to HTML code - plain text -->

						<h3>3. <xsl:copy-of select="$text_snippet_include_html" /></h3>
						<p><xsl:copy-of select="$text_snippet_include_html_explain" /></p>

						<a target="_blank" id="view_source_link">
							<xsl:attribute name="href" >
							<xsl:call-template name="embed_direct_url" />
							<xsl:text>&amp;format=text</xsl:text>
							</xsl:attribute>
							<xsl:copy-of select="$text_snippet_include_html_source" />
						</a>
					</div>

				</form><!-- / end form for changing display options -->
			</div>
		</div>

		<!-- display example of widget -->

		<div class="yui-u">

			<fieldset id="example">
				<legend id="example_legend"><xsl:copy-of select="$text_snippet_example" /></legend>
				<div id="example_container">
				<div id="example_content">
					<!-- call template to show searchbox -->
					<xsl:call-template name="searchbox_embed" />
				</div>
				</div>
			</fieldset>

		</div>

	</div>

</xsl:template>

</xsl:stylesheet>
