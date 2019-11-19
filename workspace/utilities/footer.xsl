<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="data" name="footer">
	<footer>
		<div class="container footer-top-container">
			<div class="row flex-sm">
				<div class="col-xs-12 col-sm-6 footer-logo">
					<img class="u-max-full-width" src="{$workspace}/assets/images/rhydycar_west_white.png" />
<p style="color:#fff;font-size:14px;">A project by Marvel Limited (Guernsey)</p>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-md-offset-2 contact-info">
					<xsl:if test="//data/prefs/entry/phone">
						<span><b><xsl:value-of select="//data/translation-fields/entry[@id='785']/field-name[@lang=$lang]" />:</b> <a href="tel:{//data/prefs/entry/phone}"><xsl:value-of select="//data/prefs/entry/phone" /></a></span>
					</xsl:if>
					<xsl:if test="//data/prefs/entry/email">
						<span><b><xsl:value-of select="//data/translation-fields/entry[@id='786']/field-name[@lang=$lang]" />:</b> <a href="mailto:{//data/prefs/entry/email}"><xsl:value-of select="//data/prefs/entry/email" /></a></span>
					</xsl:if>
				</div>
			</div>
			<div class="row footer-nav-container">
				<xsl:if test="$current-page != 'projectlaunch'">
					<div class="footer-nav" role="navigation">
						<button id="footer-expand">
							<xsl:value-of select="//data/translation-fields/entry[@id='787']/field-name[@lang=$lang]" />
							<span class="btnicon">+</span>
						</button>
						<ul class="footer-collapse"><xsl:apply-templates select="//data/footer-navigation/entry[not(parent/item)]" mode="get-footer-navigation-one"  /></ul>
						<xsl:apply-templates select="//data/footer-navigation/entry[not(parent/item)]" mode="get-footer-navigation-two" />
						<ul><xsl:apply-templates select="//data/secondary-footer-navigation/entry[not(parent/item)]" mode="get-navigation" /></ul>
					</div>
				</xsl:if>
			</div>
		</div>
	</footer>

</xsl:template>

</xsl:stylesheet>