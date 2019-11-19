<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="pages.xsl" />

<xsl:output method="xml"
  doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
  omit-xml-declaration="yes"
  encoding="UTF-8"
  indent="yes" />

<xsl:template match="//data/pages/entry">
	<xsl:variable name="hasHeadImgClass"><xsl:if test="header-img">has-background</xsl:if></xsl:variable>

	<xsl:variable name="accentHexHashQuery"><xsl:value-of select="substring(accent-hex, 1, 1)" /></xsl:variable>
	<xsl:variable name="accentHex">
		<xsl:choose>
			<xsl:when test="$accentHexHashQuery = '#'"><xsl:value-of select="accent-hex" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('#', accent-hex)" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<header class="page-header">
		<xsl:choose>
			<xsl:when test="header-img">
				<div class="header-img">
					<xsl:attribute name="style">
						background-image:url(<xsl:value-of select="$workspace"/><xsl:value-of select="header-img/@path"/>/<xsl:value-of select="header-img/filename"/>)
					</xsl:attribute>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="style">
					background-color: #f1f2f3
				</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="accent-hex">
			<div class="header-background-colour" style="background-color: {$accentHex}"></div>
		</xsl:if>

		<div class="header-content {$hasHeadImgClass} has-flex">

			<div class="container">
				<div class="row">
					<div class="col-xs-12 page-title">
						<h1>
							<xsl:value-of select="title[@lang=$lang]" />
						</h1>
					</div>
					<xsl:if test="blurb">
						<div class="col-xs-12 col-sm-9 col-md-8 col-lg-6 page-blurb">
							<xsl:copy-of select="blurb[@lang=$lang]/*" />
						</div>
					</xsl:if>
				</div>
			</div>
		</div>

	</header>
		
	<main class="main">

		<xsl:apply-templates select="//data/pages/entry/content/item" mode="page-content" />

		<xsl:if test="//data/params/ds-is-map">
			<xsl:call-template name="get-map" />
		</xsl:if>

		<div class="page-footer">
			<xsl:if test="accent-hex">
				<xsl:attribute name="style">background-color: <xsl:value-of select="$accentHex" /></xsl:attribute>
			</xsl:if>
			<div class="container">
				<div class="row">
					<div class="col-xs-12 col-sm-6 page-back">

						<xsl:if test="back">
							<a href="{back-btn[@lang=$lang]}"><i class="fas fa-angle-left"></i><xsl:value-of select="back[@lang=$lang]" /></a>
						</xsl:if>

					</div>
					<div class="col-xs-12 col-sm-6">
						<div class="page-share">
							<span>Share this: </span>
							<a href="http://www.facebook.com/share.php?u={$current-url}" target="_blank" aria-label="share this post on facebook">
								<!--<img src="{$workspace}/assets/images/facebook-icon.png" />-->
								<i title="Share on Facebook" class="fab fa-facebook-square fa-fw"></i>
							</a>
							<a href="http://twitter.com/intent/tweet?text=Rhydycar%20West%3A%20{title[@lang=$lang]}%20-%20{$current-url}" target="_blank" aria-label="share this post on twitter">
								<!--<img src="{$workspace}/assets/images/twitter-icon.png" />-->
								<i title="Share on Twitter" class="fab fa-twitter-square fa-fw"></i>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>

	</main>


</xsl:template>

</xsl:stylesheet>