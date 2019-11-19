<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="../utilities/master.xsl" />
<xsl:include href="../utilities/homepage-timeline.xsl" />
<xsl:include href="../utilities/homepage.xsl" />
<xsl:include href="../utilities/get-map.xsl" />
<xsl:include href="../utilities/generic.xsl" />


<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="data">
	
	<xsl:choose>

	<!-- home -->
		<xsl:when test="$page1 = '' or $page1 = 'home'">
			<xsl:call-template name="home-timeline" />
			<xsl:call-template name="home" />
		</xsl:when>

	<!-- no page exists in datasource with this name -->
		<xsl:when test="//data/pages/error">
			<xsl:call-template name="errorpage">
				<xsl:with-param name="type" select="404" />
			</xsl:call-template>

		</xsl:when>
	<!-- show generic page ? -->
		<xsl:otherwise>
			<xsl:apply-templates select="//data/pages/entry" />
		</xsl:otherwise>
		
	</xsl:choose>

</xsl:template>

</xsl:stylesheet>
