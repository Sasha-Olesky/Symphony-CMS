<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="../utilities/master.xsl" />

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="data">
	
	<xsl:variable name="hasHeadImgClass"><xsl:if test="//data/pages-project-launch/entry/header-img">has-background</xsl:if></xsl:variable>

	<xsl:variable name="accentHexHashQuery"><xsl:value-of select="substring(//data/pages-project-launch/entry/accent-hex, 1, 1)" /></xsl:variable>
	<xsl:variable name="accentHex">
		<xsl:choose>
			<xsl:when test="$accentHexHashQuery = '#'"><xsl:value-of select="//data/pages-project-launch/entry/accent-hex" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('#', //data/pages-project-launch/entry/accent-hex)" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

		<header class="page-header">
			<xsl:choose>
				<xsl:when test="//data/pages-project-launch/entry/header-img">
					<div class="header-img">
						<xsl:attribute name="style">
							background-image:url(<xsl:value-of select="$workspace"/><xsl:value-of select="//data/pages-project-launch/entry/header-img/@path"/>/<xsl:value-of select="//data/pages-project-launch/entry/header-img/filename"/>)
						</xsl:attribute>
					</div>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="style">
						background-color: #f1f2f3
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:if test="//data/pages-project-launch/entry/accent-hex">
				<div class="header-background-colour" style="background-color: {$accentHex}"></div>
			</xsl:if>

			<div class="header-content {$hasHeadImgClass} has-flex">
				<div class="container">
					<div class="row">
						<div class="col-xs-12 page-title">
							<h1>
								<xsl:value-of select="//data/pages-project-launch/entry/title[@lang=$lang]" />
							</h1>
						</div>
						<xsl:if test="//data/pages-project-launch/entry/blurb">
							<div class="col-xs-12 col-sm-9 col-md-8 col-lg-6 page-blurb">
								<xsl:copy-of select="//data/pages-project-launch/entry/blurb[@lang=$lang]/*" />
							</div>
						</xsl:if>
					</div>
				</div>
			</div>

		</header>

		<main class="main">

			<xsl:apply-templates select="//data/pages-project-launch/entry/content/item" mode="page-content" />

			<xsl:variable name="response">
				<xsl:if test="//data/events/project-launch/@result='success'">
					<xsl:choose>
						<xsl:when test="//data/events/project-launch/post-values/attend='No'">no</xsl:when>
						<xsl:when test="//data/events/project-launch/post-values/attend='Yes'">yes</xsl:when>
					</xsl:choose>
				</xsl:if>
			</xsl:variable>

			<xsl:choose>
				<xsl:when test="$response = ''">
					<section class="rsvp">
						<div class="container">
							<div class="col-xs-12 col-md-10 col-md-offset-1">

								<!-- errors -->
								<xsl:variable name="fnameError">
									<xsl:if test="//data/events/project-launch/first/@type='missing'">error</xsl:if>
								</xsl:variable>
								<xsl:variable name="lnameError">
									<xsl:if test="//data/events/project-launch/last/@type='missing'">error</xsl:if>
								</xsl:variable>
								<xsl:variable name="emailError">
									<xsl:if test="//data/events/project-launch/email/@type='missing'">error</xsl:if>
									<xsl:if test="//data/events/project-launch/email/@type='invalid'">error</xsl:if>
								</xsl:variable>
								<xsl:variable name="orgError">
									<xsl:if test="//data/events/project-launch/org/@type='missing'">error</xsl:if>
								</xsl:variable>
								<xsl:variable name="attendError">
									<xsl:if test="//data/events/project-launch/attend/@type='missing'">error</xsl:if>
								</xsl:variable>
								<xsl:variable name="robotError">
									<xsl:if test="//data/events/project-launch/filter/@status='failed'">error</xsl:if>
								</xsl:variable>


								<form method="post" action="{$current-url}/" enctype="multipart/form-data">
									<fieldset name="name">
										<label class="fname {$fnameError}">
											<span class="label"><xsl:value-of select="//data/translation-fields/entry[@id='790']/field-name[@lang=$lang]" /></span>
											<input name="fields[first]" type="text" required="required" />
											<xsl:if test="$fnameError = 'error'">
												<span class="error-message"><xsl:value-of select="//data/translation-fields/entry[@id='800']/field-name[@lang=$lang]" /></span>
											</xsl:if>
										</label>
										<label class="lname {$lnameError}">
											<span class="label"><xsl:value-of select="//data/translation-fields/entry[@id='791']/field-name[@lang=$lang]" /></span>
											<input name="fields[last]" type="text" required="required" />
											<xsl:if test="$lnameError = 'error'">
												<span class="error-message"><xsl:value-of select="//data/translation-fields/entry[@id='801']/field-name[@lang=$lang]" /></span>
											</xsl:if>
										</label>
									</fieldset>
									<label class="email block {$emailError}">
										<span class="label"><xsl:value-of select="//data/translation-fields/entry[@id='786']/field-name[@lang=$lang]" /></span>
										<input name="fields[email]" type="email" required="required" />
										<xsl:if test="$lnameError = 'error'">
											<span class="error-message"><xsl:value-of select="//data/translation-fields/entry[@id='802']/field-name[@lang=$lang]" /></span>
										</xsl:if>
									</label>
									<label class="organisation block">
										<span class="label"><xsl:value-of select="//data/translation-fields/entry[@id='831']/field-name[@lang=$lang]" /></span>
										<input name="fields[org]" type="text" />
										<!--
										<xsl:if test="$orgError = 'error'">
											<span class="error-message"><xsl:value-of select="//data/translation-fields/entry[@id='830']/field-name[@lang=$lang]" /></span>
										</xsl:if>
										-->
									</label>
									<fieldset name="attend" class="attend {$attendError}">
										<xsl:if test="$attendError = 'error'">
											<span class="error-message"><xsl:value-of select="//data/translation-fields/entry[@id='803']/field-name[@lang=$lang]" /></span>
										</xsl:if>
										<label>
											<input type="radio" name="fields[attend]" value="Yes" />
											<span class="check"></span>
											<xsl:value-of select="//data/translation-fields/entry[@id='792']/field-name[@lang=$lang]" />
										</label>
										<label>
											<input type="radio" name="fields[attend]" value="No" />
											<span class="check"></span>
											<xsl:value-of select="//data/translation-fields/entry[@id='793']/field-name[@lang=$lang]" />
										</label>
									</fieldset>
									<div class="recaptacha-container {$robotError}">
										<xsl:if test="$robotError='error'">
											<span class="error-message"><xsl:value-of select="//data/translation-fields/entry[@id='804']/field-name[@lang=$lang]" /></span>
										</xsl:if>
										<div data-callback="recaptcha_callback" class="g-recaptcha" data-sitekey="{//data/params/recaptcha-sitekey}"></div>
     									<input class="recaptcha_class" name="fields[google_recaptcha]" type="hidden" value="" />
     								</div>
									<div class="submit-container">
										<input class="submit" name="action[project-launch]" type="submit" value="{//data/translation-fields/entry[@id='794']/field-name[@lang=$lang]}" />
									</div>
								</form>
							</div>
						</div>
					</section>
				</xsl:when>
				<xsl:otherwise>
					<section class="thankyou">
						<div class="container">
							<div class="col-xs-12 col-md-10 col-md-offset-1 u-center">
								
								<h2><xsl:value-of select="//data/translation-fields/entry[@id='805']/field-name[@lang=$lang]" /></h2>
								<xsl:choose>
									<xsl:when test="$response = 'no'">
										<p><xsl:value-of select="//data/translation-fields/entry[@id='806']/field-name[@lang=$lang]" /></p>
									</xsl:when>
									<xsl:when test="$response = 'yes'">
										<p><xsl:value-of select="//data/translation-fields/entry[@id='807']/field-name[@lang=$lang]" /></p>
									</xsl:when>
								</xsl:choose>

							</div>
						</div>
					</section>
				</xsl:otherwise>
			</xsl:choose>
			

		</main>

</xsl:template>

</xsl:stylesheet>
