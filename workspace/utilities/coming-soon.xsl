<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="/" name="coming-soon">

	<xsl:variable name="backgroundHexHashQuery"><xsl:value-of select="substring(//data/prefs/entry/holding-background-hex, 1, 1)" /></xsl:variable>
	<xsl:variable name="backgroundHex">
		<xsl:choose>
			<xsl:when test="$backgroundHexHashQuery = '#'"><xsl:value-of select="//data/prefs/entry/holding-background-hex" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('#', //data/prefs/entry/holding-background-hex)" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

<html>
	<head>
		<title>Rhydycar West</title>

		<meta charset="UTF-8" />
		<meta name="description" content="{//data/prefs/entry/meta-desc}" />
		<meta name="keywords" content="{//data/prefs/entry/meta-tags}" />
		<meta name="author" content="Rhydycar West" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<meta property="og:url" content="{$current-url}" />
		<!-- FAVICON -->
		<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png" />
		<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png" />
		<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png" />
		<link rel="manifest" href="/site.webmanifest" />
		<link rel="mask-icon" href="/safari-pinned-tab.svg" color="#000000" />
		<meta name="apple-mobile-web-app-title" content="Rhydycar West" />
		<meta name="application-name" content="Rhydycar West" />
		<meta name="msapplication-TileColor" content="#ffc40d" />
		<meta name="theme-color" content="#ffffff" />

		<!-- NIVEAU GROTEST FROM TYPEKIT -->
		<link rel="stylesheet" href="https://use.typekit.net/lgu2dof.css" />
		<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/maintenance.css" />

		<!--*modernizr-->
		<script src="{$workspace}/assets/js/modernizr-offcanvas.js"></script>
		<!--*respond.js-->
		<script src="{$workspace}/assets/js/respond.js"></script>
	</head>
	<body>
		<xsl:if test="//data/prefs/entry/holding-background-hex">
			<xsl:attribute name="style">background-color: <xsl:value-of select="$backgroundHex" /></xsl:attribute>
		</xsl:if>
		<main>
			<!-- <img id="large-logo" src="{$workspace}/assets/images/rhydycar_logo_large.png" alt="Rhydycar West" /> -->
			<img id="large-logo" src="{$workspace}/assets/images/rhydycar_west_with_text.png" alt="Rhydycar West: new sports and leisure destination and neighbourhood for Merthyr Tydfil" />

			<xsl:copy-of select="//data/prefs/entry/holding-message/*" />

			<xsl:if test="$auth = 'no' and $current-page != 'coming-soon'">
				<xsl:choose>
					<xsl:when test="//data/params/page1">
						<xsl:choose>
							<xsl:when test="//data/params/page1 = '' or //data/params/page1 = 'home'">
							</xsl:when>
							<xsl:otherwise>
								<form method="post" action="{$current-url}/">
									<input type="text" name="storage[auth][password]" />
									<input type="submit" name="storage-action[set]" />
								</form>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<form method="post" action="{$current-url}/">
							<input type="text" name="storage[auth][password]" />
							<input type="submit" name="storage-action[set]" />
						</form>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>

			<xsl:if test="$auth = 'yes' and $cookie-username = 'jo'">
				<form method="post" action="?debug"> 
					<input type="submit" value="drop password" name="storage-action[drop][auth]" />
				</form>
			</xsl:if>

		</main>
		<footer>
			<img id="small-logo" src="{$workspace}/assets/images/rhydycar_west_black.png" alt="Rhydycar West" />
			<a href="mailto:{//data/prefs/entry/email}"><b>info@rhydycar</b>west<b>.com</b></a>
		</footer>
	</body>
</html>


</xsl:template>

</xsl:stylesheet>
