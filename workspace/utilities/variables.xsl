<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:variable name="lang">
	<xsl:value-of select="//data/events/language-redirect/current-language/@handle" />
</xsl:variable>

<xsl:variable name="gdpr">
	<xsl:choose>
		<xsl:when test="//data/storage/group[@id='gdpr']/item[@id='accept'] = 'yes'">yes</xsl:when>
		<xsl:otherwise>no</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:variable name="auth">
	<xsl:choose>
		<xsl:when test="//data/storage/group[@id='auth']/item[@id='password'] = 'enterRhydycar'">yes</xsl:when>
		<xsl:otherwise>no</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

</xsl:stylesheet>