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
	
	<xsl:variable name="hasHeadImgClass"><xsl:if test="//data/pages-suggestions/entry/header-img">has-background</xsl:if></xsl:variable>

	<xsl:variable name="accentHexHashQuery"><xsl:value-of select="substring(//data/pages-suggestions/entry/accent-hex, 1, 1)" /></xsl:variable>
	<xsl:variable name="accentHex">
		<xsl:choose>
			<xsl:when test="$accentHexHashQuery = '#'"><xsl:value-of select="//data/pages-suggestions/entry/accent-hex" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('#', //data/pages-suggestions/entry/accent-hex)" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>


		<header class="page-header">
			<xsl:choose>
				<xsl:when test="//data/pages-suggestions/entry/header-img">
					<div class="header-img">
						<xsl:attribute name="style">
							background-image:url(<xsl:value-of select="$workspace"/><xsl:value-of select="//data/pages-suggestions/entry/header-img/@path"/>/<xsl:value-of select="//data/pages-suggestions/entry/header-img/filename"/>)
						</xsl:attribute>
					</div>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="style">
						background-color: #f1f2f3
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:if test="//data/pages-suggestions/entry/accent-hex">
				<div class="header-background-colour" style="background-color: {$accentHex}"></div>
			</xsl:if>

			<div class="header-content {$hasHeadImgClass} has-flex">
				<div class="container">
					<div class="row">
						<div class="col-xs-12 page-title">
							<h1>
								<xsl:value-of select="//data/pages-suggestions/entry/title[@lang=$lang]" />
							</h1>
						</div>
						<xsl:if test="//data/pages-suggestions/entry/blurb">
							<div class="col-xs-12 col-sm-9 col-md-8 col-lg-6 page-blurb">
								<xsl:copy-of select="//data/pages-suggestions/entry/blurb[@lang=$lang]/*" />
							</div>
						</xsl:if>
					</div>
				</div>
			</div>

		</header>

		<main class="main">

			<xsl:apply-templates select="//data/pages-suggestions/entry/content/item" mode="page-content" />

			<xsl:choose>
				<xsl:when test="//data/events/suggestions/@result='success'">
					<section class="thankyou">
						<div class="container">
							<div class="col-xs-12 col-md-10 col-md-offset-1 u-center">
								
								<h2><xsl:value-of select="//data/translation-fields/entry[@id='805']/field-name[@lang=$lang]" /></h2>

							</div>
						</div>
					</section>
				</xsl:when>
				<xsl:otherwise>
					<section class="rsvp">
						<div class="container">
							<div class="col-xs-12 col-md-10 col-md-offset-1">

								<!-- errors -->
								
								<xsl:variable name="robotError">
									<xsl:if test="//data/events/suggestions/filter/@status='failed'">error</xsl:if>
								</xsl:variable>
								<xsl:variable name="nameError">
									<xsl:if test="//data/events/suggestions/name/@type='missing'">error</xsl:if>
								</xsl:variable>
								<xsl:variable name="emailError">
									<xsl:if test="//data/events/suggestions/email/@type='missing'">error</xsl:if>
									<xsl:if test="//data/events/suggestions/email/@type='invalid'">error</xsl:if>
								</xsl:variable>
								<xsl:variable name="commentError">
									<xsl:if test="//data/events/suggestions/comment/@type='missing'">error</xsl:if>
								</xsl:variable>
								<xsl:variable name="privacyError">
									<xsl:if test="//data/events/suggestions/privacy/@type='missing'">error</xsl:if>
								</xsl:variable>


								<form method="post" action="{$current-url}/" enctype="multipart/form-data">
									<label class="block {$nameError}">
										<div>Name (optional)</div>
										<input type="text" name="fields[name]" />
										<xsl:if test="$nameError = 'error'">
											<span class="error-message">Please enter your name</span>
										</xsl:if>
									</label>

									<label class="block {$emailError}">
										<div>Email (optional)</div>
										<input type="email" name="fields[email]" />
										<xsl:if test="$emailError = 'error'">
											<span class="error-message">Please enter a valid email</span>
										</xsl:if>
									</label>

									<label class="block {$commentError}">
										<div>Comments</div>
										<textarea name="fields[comment]" rows="10"></textarea>
										<xsl:if test="$commentError = 'error'">
											<span class="error-message">Enter a comment!</span>
										</xsl:if>
									</label>

									<div class="checkbox-container {$privacyError}">
										<xsl:if test="$privacyError = 'error'">
											<span class="error-message">Please check to confirm you agree to our privacy policy</span>
										</xsl:if>
										<label class="checkbox">
											<input name="fields[privacy]" type="checkbox" value="yes" /><span class="checkbox"></span> <span class="text">I agree to privacy policy</span>
										</label>
									</div>

									<div class="recaptacha-container {$robotError}">
										<xsl:if test="$robotError='error'">
											<span class="error-message"><xsl:value-of select="//data/translation-fields/entry[@id='804']/field-name[@lang=$lang]" /></span>
										</xsl:if>
										<div data-callback="recaptcha_callback" class="g-recaptcha" data-sitekey="{//data/params/recaptcha-sitekey}"></div>
     									<input class="recaptcha_class" name="fields[google_recaptcha]" type="hidden" value="" />
     								</div>
									<div class="submit-container">
										<input class="submit" name="action[suggestions]" type="submit" value="{//data/translation-fields/entry[@id='794']/field-name[@lang=$lang]}" />
									</div>
								</form>

							</div>
						</div>
					</section>
				</xsl:otherwise>
			</xsl:choose>
			

		</main>

</xsl:template>

</xsl:stylesheet>
