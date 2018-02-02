<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet exclude-result-prefixes="php" version="1.0" xmlns:php="http://php.net/xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- load english labels as default always -->
  <xsl:import href="labels/eng.xsl"/>

  <!--
	VARIABLES
-->
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>

  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

  <xsl:variable name="app_url" select="//config/app_url"/>

  <xsl:variable name="home_url" select="//config/home_url"/>

  <xsl:variable name="app_title" select="//config/app_title"/>

  <xsl:variable name="home_title" select="//config/home_title"/>

  <xsl:variable name="base_url" select="//config/base_url"/>

  <xsl:variable name="primo_search_url" select="//config/primo_search_url"/>

  <xsl:variable name="xerxes_search_url" select="//config/xerxes_search_url"/>

  <xsl:variable name="umlaut_search_url" select="//config/umlaut_search_url"/>

  <xsl:variable name="libguides_search_url" select="//config/libguides_search_url"/>

  <xsl:variable name="id">

    <xsl:choose>

      <xsl:when test="(//request/disp_select_view) and not(//request/disp_select_view = '')">
        <xsl:value-of select="//request/disp_select_view"/>
      </xsl:when>

      <xsl:otherwise><xsl:value-of select="//view[@default='true']/@id"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="vid">

    <xsl:choose>

      <xsl:when test="//view[@id=$id]/@vid">
        <xsl:value-of select="//view[@id=$id]/@vid"/>
      </xsl:when>

      <xsl:otherwise><xsl:value-of select="//view[@id=$id]/@id"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="unique_key" select="//request/unique_key"/>

  <!--
	TEMPLATE: SURROUND
	generate surrounding html for generator script
-->
  <xsl:template name="surround">

    <xsl:element name="html">

      <xsl:attribute name="xml:lang">en</xsl:attribute>

      <xsl:attribute name="lang">en</xsl:attribute>

      <xsl:element name="head">

        <xsl:element name="meta">

          <xsl:attribute name="http-equiv">Content-Type</xsl:attribute>

          <xsl:attribute name="content">text/html; charset=utf-8</xsl:attribute>
        </xsl:element>

        <xsl:element name="title"><xsl:value-of select="$app_title"/>:

          <xsl:call-template name="page_name"/></xsl:element>

        <xsl:call-template name="additional_headers"/>

      </xsl:element>

      <xsl:element name="body">

        <xsl:element name="div">

          <xsl:attribute name="id">header</xsl:attribute>
          <a href="https://library.nyu.edu" target="_blank">
            <img alt="NYU Libraries" height="30" src="https://library.nyu.edu/assets/images/nyulibraries-logo.svg" width="233"/>
          </a>
        </xsl:element>

        <xsl:element name="div">

          <xsl:attribute name="id">nav1</xsl:attribute>

          <xsl:element name="ul">

            <xsl:attribute name="class">floatLeft</xsl:attribute>

            <xsl:element name="li">

              <xsl:element name="a">

                <xsl:attribute name="href"><xsl:value-of select="$home_url"/></xsl:attribute>

                <xsl:value-of select="$home_title"/>
              </xsl:element>
            </xsl:element>

            <xsl:element name="li">
              <xsl:value-of select="$breadcrumb_separator"/>
            </xsl:element>

            <xsl:element name="li">

              <xsl:element name="a">

                <xsl:attribute name="href"><xsl:value-of select="$app_url"/></xsl:attribute>

                <xsl:value-of select="$app_title"/>
              </xsl:element>
            </xsl:element>

            <xsl:element name="li">
              <xsl:value-of select="$breadcrumb_separator"/>
            </xsl:element>

            <xsl:element name="li">
              <xsl:call-template name="page_name"/>
            </xsl:element>
          </xsl:element>

          <xsl:element name="ul">

            <xsl:attribute name="class">floatRight</xsl:attribute>

            <xsl:element name="li"></xsl:element>
          </xsl:element>
        </xsl:element>

        <xsl:element name="div">

          <xsl:attribute name="id">maincontent</xsl:attribute>

          <xsl:attribute name="class">clearBoth</xsl:attribute>

          <xsl:call-template name="main"/>

          <xsl:element name="div">

            <xsl:attribute name="id">ft</xsl:attribute>

            <xsl:element name="p"><xsl:value-of select="$text_footer"/></xsl:element>
          </xsl:element>
        </xsl:element>

      </xsl:element>

    </xsl:element>

  </xsl:template>

  <!--
	TEMPLATE: ADDITIONAL_HEADERS
	for surround include necessary javascript and stylesheets
-->
  <xsl:template name="additional_headers">

    <link href="{$home_url}/favicon.ico" rel="SHORTCUT ICON"/>

    <link href="{$base_url}/css/reset-fonts-grids.css" rel="stylesheet" type="text/css"/>
    <link href="https://cdn.library.nyu.edu/bobcat_embed/bobcat-widget.css" rel="stylesheet" type="text/css" />
    <link href="{$base_url}/css/local.css" rel="stylesheet" type="text/css"/>

  </xsl:template>

  <!--
	TEMPLATE: SEARCHBOX_EMBED
	based on url options, generate a searchbox
-->
  <xsl:template name="searchbox_embed">

    <!--
		option to load javascript librar(y/ies)
	-->
    <script src="https://cdn.library.nyu.edu/bobcat_embed/embed-functions-nolib.js" type="text/javascript"></script>

    <xsl:if test="//request/action = 'embed' and //request/disp_embed_css = 'true'">
      <link href="https://cdn.library.nyu.edu/bobcat_embed/bobcat-widget.css" rel="stylesheet" type="text/css" />
    </xsl:if>

    <div class="bobcat_embed" id="bobcat_embed_{$unique_key}">

      <!-- create tabs as an unordered list for each tab in this view -->

      <div class="bobcat_embed_tabs_wrapper" id="bobcat_embed_tabs_wrapper_{$unique_key}">
        <div class="bobcat_embed_tabs" id="bobcat_embed_tabs_{$unique_key}">
          <ul>

            <xsl:for-each select="//view[@id=$id]/tabs/tab">
              <li id="{@name}_{$unique_key}">

                <xsl:attribute name="class">

                  <!-- give tabs classes based on position for better styling capabilities -->
                  <xsl:choose>

                    <xsl:when test="position() = 1">
                      <xsl:text>bobcat_embed_tabs_first</xsl:text>
                    </xsl:when>

                    <xsl:when test="position() = count(//view[@id=$id]/tabs/tab)">
                      <xsl:text>bobcat_embed_tabs_last</xsl:text>
                    </xsl:when>

                    <xsl:otherwise>
                      <xsl:text>bobcat_embed_tabs_inside</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>

                  <xsl:if test="(//request/disp_default_tab = @name) or (not(//request/disp_default_tab) and (./@default = 'true'))">
                    <xsl:text> bobcat_embed_tabs_selected bobcat_embed_tabs_selected_</xsl:text><xsl:value-of select="$unique_key"/>
                  </xsl:if>

                </xsl:attribute>
                <a>

                  <xsl:if test="not(@link_out = 'true')">

                    <xsl:attribute name="onclick">javascript:bobcat_embed_switch_tab('<xsl:value-of select="./@name"/>_<xsl:value-of select="$unique_key"/>','<xsl:value-of select="$unique_key"/>');return false;</xsl:attribute>
                  </xsl:if>

                  <xsl:if test="(@link_out = 'true') and @link_out_target">

                    <xsl:attribute name="target"><xsl:value-of select="@link_out_target"/></xsl:attribute>
                  </xsl:if>

                  <xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>

                  <xsl:attribute name="alt"><xsl:value-of select="@description"/></xsl:attribute>

                  <xsl:attribute name="href">

                    <xsl:choose>

                      <xsl:when test="@link_out = 'true' and @link_out_href">
                        <xsl:value-of select="@link_out_href"/>
                      </xsl:when>

                      <xsl:when test="@system = 'xerxes' and @name = 'articles'">

                        <xsl:value-of select="$xerxes_search_url"/>
                        <xsl:text>?institution=</xsl:text>

                        <xsl:value-of select="translate($vid, $uppercase, $smallcase)"/>
                      </xsl:when>

                      <xsl:when test="@system = 'xerxes' and @name = 'databases'">

                        <xsl:value-of select="$xerxes_search_url"/>
                        <xsl:text>/databases/alphabetical</xsl:text>
                        <xsl:text>?institution=</xsl:text>

                        <xsl:value-of select="translate($vid, $uppercase, $smallcase)"/>
                      </xsl:when>

                      <xsl:when test="@system = 'umlaut' and @name = 'journals'">

                        <xsl:value-of select="$umlaut_search_url"/>/<xsl:value-of select="translate($vid, $uppercase, $smallcase)"/>
                      </xsl:when>

                      <xsl:when test="@system = 'libguides' and @name = 'subjectguides'">
                        <xsl:value-of select="$libguides_search_url"/>
                      </xsl:when>

                      <xsl:otherwise>

                        <xsl:value-of select="$primo_search_url"/>?vid=<xsl:value-of select="$vid"/>&amp;tab=<xsl:value-of select="@name"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>

                  <xsl:value-of select="@title"/>
                </a>
              </li>
            </xsl:for-each>
          </ul>
        </div>
      </div>
      <!-- /tabs wrapper -->

      <div class="bobcat_embed_searchbox" id="bobcat_embed_searchbox_{$unique_key}">

        <!-- FOR EACH TAB IN VIEW -->
        <xsl:for-each select="//view[@id=$id]/tabs/tab">

          <div class="bobcat_embed_tab_content bobcat_embed_tab_content_{$unique_key}">

            <xsl:attribute name="id">bobcat_embed_tab_content_<xsl:value-of select="./@name"/>_<xsl:value-of select="$unique_key"/></xsl:attribute>

            <!-- hide this tab if it's not the default tab -->
            <xsl:if test="(./@name != //request/disp_default_tab) or (not(//request/disp_default_tab) and (position() != 1))">

              <xsl:attribute name="style">display:none;</xsl:attribute>
            </xsl:if>

            <!-- start form to send search request -->
            <form accept-charset="utf-8" action="{$base_url}/index.php" method="get" name="form1" target="_blank">
              <!-- necessary fields for primo search -->
              <input name="action" type="hidden" value="search"/>
              <input name="tab" type="hidden" value="{./@name}"/>
              <input name="vid" type="hidden" value="{$vid}"/>
              <input name="system" type="hidden" value="{./@system}"/>
              <input name="search" type="hidden" value="{./@search}"/>

              <xsl:for-each select="./fields/field[@type='hidden']">
                <xsl:copy-of select="./node()"/>
              </xsl:for-each>

              <!-- search text field and submit button -->
              <xsl:if test="count(./fields/field) &gt; 0">
                <div class="bobcat_embed_search_field">

                  <xsl:for-each select="./fields/field[@type!='hidden']">
                    <span class="bobcat_embed_{./@class}">

                      <xsl:if test="./@name != ''">
                        <label for="{./@name}"><xsl:value-of select="./@title"/>
                        </label>
                      </xsl:if>

                      <xsl:copy-of select="./node()"/>
                    </span>
                  </xsl:for-each>

                  <xsl:if test="./fields/field[@type!='hidden']">
                    <span class="bobat_embed_searchbox_submit_container">
                      <input aria-label="Search" class="bobcat_embed_searchbox_submit" name="Submit" type="submit" value="GO"/>
                    </span>
                  </xsl:if>
                </div>
              </xsl:if>

              <xsl:if test="count(./fields/field) = 0">
                <div class="bobcat_embed_search_spacer"></div>
              </xsl:if>

              <xsl:if test="./limit_to">
                <!-- "limit to" options -->
                <div class="bobcat_embed_limit_to">

                  <!-- hide if set in query string -->
                  <xsl:if test="//request/disp_show_limit_to = 'false'">

                    <xsl:attribute name="style">display:none;</xsl:attribute>
                  </xsl:if>

                  <xsl:text>Limit to </xsl:text>

                  <!-- if there are any media types and they aren't set to display=false in config, print them -->
                  <xsl:if test="count(./limit_to/media_types/media_type) &gt; 0">
                    <span class="bobcat_embed_media_types">

                      <xsl:if test="./limit_to/media_types[@display = 'none']">

                        <xsl:attribute name="style">display:none;</xsl:attribute>
                      </xsl:if>
                      <label for="input_{./limit_to/media_types/@name}" style="display:none;">Media types</label>
                      <select aria-label="Media types" id="input_{./limit_to/media_types/@name}" name="{./limit_to/media_types/@name}">

                        <xsl:for-each select="./limit_to/media_types/media_type">
                          <option value="{./@name}"><xsl:value-of select="."/></option>
                        </xsl:for-each>
                      </select>
                    </span>
                  </xsl:if>

                  <xsl:text> </xsl:text>

                  <!-- if there are any search types and they aren't set to display=false in config, print them -->
                  <xsl:if test="count(./limit_to/search_types/search_type) &gt; 0">
                    <span class="bobcat_embed_search_type">
                      <label for="input_{./limit_to/search_types/@name}" style="display:none;">Precision operator</label>
                      <select aria-label="Precision operator" id="input_{./limit_to/search_types/@name}" name="{./limit_to/search_types/@name}">

                        <xsl:for-each select="./limit_to/search_types/search_type">
                          <option value="{./@name}"><xsl:value-of select="."/></option>
                        </xsl:for-each>
                      </select>
                    </span>
                  </xsl:if>

                  <xsl:text> </xsl:text>

                  <!-- if there are any record attributes and they aren't set to display=false in config, print them -->
                  <xsl:if test="count(./limit_to/record_attributes/record_attribute) &gt; 0">
                    <span class="bobcat_embed_record_attributes">

                      <xsl:if test="./limit_to/record_attributes[@display = 'none']">

                        <xsl:attribute name="style">display:none;</xsl:attribute>
                      </xsl:if>
                      <label for="input_{./limit_to/record_attributes/@name}" style="display:none;">Record attributes</label>
                      <select aria-label="Record attributes" id="input_{./limit_to/record_attributes/@name}" name="{./limit_to/record_attributes/@name}">

                        <xsl:for-each select="./limit_to/record_attributes/record_attribute">
                          <option value="{./@name}"><xsl:value-of select="."/></option>
                        </xsl:for-each>
                      </select>
                    </span>
                  </xsl:if>

                  <xsl:text> </xsl:text>

                  <!-- if there are any scopes and they aren't set to display=false in config, print them -->
                  <xsl:if test="count(./limit_to/scopes/scope) &gt; 0">
                    <span class="bobcat_embed_scopes">

                      <xsl:if test="./limit_to/scopes[@display = 'none']">

                        <xsl:attribute name="style">display:none;</xsl:attribute>
                      </xsl:if>
                      <xsl:text>In </xsl:text>
                      <label for="{./limit_to/scopes/@name}" style="display:none;">Scopes</label>
                      <select aria-label="Scopes" name="{./limit_to/scopes/@name}">

                        <xsl:for-each select="./limit_to/scopes/scope">
                          <option value="{./@name}"><xsl:value-of select="."/></option>
                        </xsl:for-each>
                      </select>
                    </span>
                  </xsl:if>

                </div>
                <!-- /end bobcat_embed_limit_to -->
              </xsl:if>

              <xsl:if test="count(./links/link) &gt; 0">
                <div class="bobcat_embed_links">
                  <ul>

                    <xsl:for-each select="./links/link">
                      <li>

                        <xsl:element name="a">

                          <xsl:attribute name="target">_blank</xsl:attribute>

                          <xsl:attribute name="href">

                            <xsl:choose>

                              <xsl:when test="starts-with(@href, 'http')">
                                <xsl:value-of select="@href"/>
                              </xsl:when>

                              <xsl:otherwise>

                                <xsl:choose>

                                  <xsl:when test="ancestor::tab[@system='primo']">

                                    <xsl:value-of select="$primo_search_url"/><xsl:value-of select="@href"/>
                                  </xsl:when>

                                  <xsl:when test="ancestor::tab[@system='umlaut']">

                                    <xsl:value-of select="$umlaut_search_url"/><xsl:value-of select="@href"/>
                                  </xsl:when>

                                  <xsl:when test="ancestor::tab[@system='xerxes']">

                                    <xsl:value-of select="$xerxes_search_url"/><xsl:value-of select="@href"/>
                                  </xsl:when>

                                  <xsl:when test="ancestor::tab[@system='libguides']">

                                    <xsl:value-of select="$libguides_search_url"/><xsl:value-of select="@href"/>
                                  </xsl:when>

                                  <xsl:otherwise/>
                                </xsl:choose>
                              </xsl:otherwise>
                            </xsl:choose>

                            <xsl:if test="./querystring">?</xsl:if>

                            <xsl:for-each select="./querystring/@*">
                              <xsl:text>&amp;</xsl:text>

                              <xsl:choose>

                                <xsl:when test="name() = 'pass-vid'">

                                  <xsl:choose>

                                    <xsl:when test=". = 'true'">

                                      <xsl:choose>

                                        <xsl:when test="ancestor::view/@vid">
                                          <xsl:text>vid</xsl:text>=<xsl:value-of select="ancestor::view/@vid"/></xsl:when>

                                        <xsl:otherwise>
                                          <xsl:text>vid</xsl:text>=<xsl:value-of select="ancestor::view/@id"/></xsl:otherwise>
                                      </xsl:choose>
                                    </xsl:when>

                                    <xsl:when test=". = 'false'"></xsl:when>

                                    <xsl:otherwise>

                                      <xsl:value-of select="."/>=<xsl:value-of select="ancestor::view/@id"/>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </xsl:when>

                                <xsl:when test="name() = 'pass-tab'">
                                  <xsl:text>tab</xsl:text>=<xsl:value-of select="ancestor::tab/@name"/>
                                </xsl:when>

                                <xsl:otherwise>

                                  <xsl:value-of select="name()"/>=<xsl:value-of select="."/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:for-each>
                          </xsl:attribute>

                          <xsl:choose>

                            <xsl:when test="./text">
                              <xsl:value-of select="./text"/>
                            </xsl:when>

                            <xsl:otherwise>
                              <xsl:value-of select="text()"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:element>
                      </li>
                    </xsl:for-each>
                  </ul>
                </div>
              </xsl:if>

            </form>
          </div>
          <!-- /end bobcat_embed_tab_content -->

        </xsl:for-each>

      </div>
      <!-- /end bobcat_embed_searchbox -->

    </div>
    <!-- /end bobcat_embed -->

  </xsl:template>

</xsl:stylesheet>
