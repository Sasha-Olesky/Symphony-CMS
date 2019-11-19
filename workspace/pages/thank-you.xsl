<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="../utilities/master.xsl" />
	<xsl:include href="../utilities/pages.xsl" />
	<xsl:include href="../utilities/client-list.xsl" />

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="data">

	<div class="thankyou page page-general yellow">	
		<section class="gen">
			<div class="container">
				<img class="u-max-full-width" src="{$workspace}/assets/images/sub-placeholder-g.gif"/>
			</div>
		</section>
		<section class="gen">
			<div class="container">
				<xsl:choose>
					<xsl:when test="//data/prefs/entry/thank-you">
						<xsl:copy-of select="//data/prefs/entry/thank-you/*"/>
					</xsl:when>
					<xsl:otherwise>
						<h2>Thank you for signing up to our newsletter</h2>
						<p>We will be in touch will all the latest Yellow Sub news.</p>
					</xsl:otherwise>
				</xsl:choose>

				<p><a href="{$root}">Return to Homepage</a></p>
			</div>
		</section>
	</div>

</xsl:template>


</xsl:stylesheet>

