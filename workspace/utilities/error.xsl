<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
  doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
  omit-xml-declaration="yes"
  encoding="UTF-8"
  indent="yes" />

<xsl:template match="data" name="errorpage">
	<xsl:param name="type" select="other" />

	<header class="page-header" style="background-color:#f1f2f3">
		<div class="header-content has-flex">
			<div class="container">
				<div class="row">
					<div class="col-xs-12 page-title">
						<h1>
							<xsl:choose>
								<xsl:when test="$type = '404'">Page not Found</xsl:when>
								<xsl:when test="$type = 'news'">Article not Found</xsl:when>
								<xsl:otherwise>Something went wrong</xsl:otherwise>
							</xsl:choose>
						</h1>
					</div>
				</div>
			</div>
		</div>
	</header>
	<main class="main container" style="padding-bottom:50px;">
		<div class="row">
			<div class="col-xs-12 col-md-10 col-md-offset-1 u-center">
				<h2>Oops, we couldn't find whatever you were looking for.</h2>
				<div class="item-cta-container">
					<xsl:choose>
						<xsl:when test="$type = 'news'">
							<a class="item-cta" href="{$root}/{$lang}/news"><span class="buttontxt">Return to News</span><i class="fas fa-angle-right"></i></a>
						</xsl:when>
						<xsl:otherwise>
							<a class="item-cta" href="{$root}"><span class="buttontxt">Return to Homepage</span><i class="fas fa-angle-right"></i></a>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</div>
		</div>
	</main>

</xsl:template>
</xsl:stylesheet>