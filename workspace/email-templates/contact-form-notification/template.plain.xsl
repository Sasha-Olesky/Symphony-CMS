<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="no"/>

<xsl:template match="/">
    Message from <xsl:value-of select="/data/contact-form/entry/name"/>:
    <xsl:value-of select="/data/contact-form/entry/message"/>

    Sent from: <xsl:value-of select="/data/contact-form/entry/location"/>

--------------------------------------

To respond, you can send an email to <xsl:value-of select="/data/contact-form/entry/email"/> or reply to this email. 
</xsl:template>
</xsl:stylesheet>
