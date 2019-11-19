<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="data" name="contact">

	<section class="homepage-section grey-background-yellow-text" id="contact">
		<div class="container">
			<h2>Contact</h2>
			<div class="row">
				<div class="one-half column connect x">
					<xsl:choose>
						<xsl:when test="//data/events/contact/@result = 'success'">
							<br /><br /><br />
							<h3>Thanks, we'll be in touch soon!</h3>
						</xsl:when>
						<xsl:otherwise>
							<h3>Let's connect</h3>
							<form id="contactform" method="post" action="{$current-url}/#contact">
								<input type="hidden" name="fields[location]" value="{$current-url}" />
								<label>
									Name
									<xsl:if test="//data/events/contact/name/@type='missing'">
										<span class="form-error"><xsl:value-of select="//data/events/contact/name/@message"/></span>
									</xsl:if>
									<input type="text" name="fields[name]" value="{//data/events/contact/post-values/name}" />
								</label>
								<label>
									Email
									<xsl:if test="//data/events/contact/email/@type='missing'">
										<span class="form-error"><xsl:value-of select="//data/events/contact/email/@message"/></span>
									</xsl:if>
									<xsl:if test="//data/events/contact/email/@type='invalid'">
										<span class="form-error">Please enter a valid email address.</span>
									</xsl:if>
									<input type="email" name="fields[email]" value="{//data/events/contact/post-values/email}" />
								</label>
								<label>
									Message
									<xsl:if test="//data/events/contact/message/@type='missing'">
										<span class="form-error"><xsl:value-of select="//data/events/contact/message/@message"/></span>
									</xsl:if>
									<textarea name="fields[message]">
										<xsl:value-of select="//data/events/contact/post-values/message"/>
									</textarea>
								</label>
								<input role="button" type="submit" value="Submit" name="action[contact]" />
							</form>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div class="one-half column contact x">
					<xsl:choose>
						<xsl:when test="//data/prefs/entry/contact-header">
							<h3><xsl:value-of select="//data/prefs/entry/contact-header"/></h3>
						</xsl:when>
						<xsl:otherwise><h3>We're always keen to help</h3></xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="//data/prefs/entry/contact-text">
							<p><xsl:copy-of select="//data/prefs/entry/contact-text"/></p>
						</xsl:when>
						<xsl:otherwise>
							<p>drop us a line with whatever it is you may wish to discuss and we'll be in touch very soon.</p>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="//data/prefs/entry/phone-uk">
						<p class="us">
							UK:
							<a href="tel:+{//data/prefs/entry/phone-uk/@handle}"><xsl:value-of select="//data/prefs/entry/phone-uk"/></a>
						</p>
					</xsl:if>
					<xsl:if test="//data/prefs/entry/phone-us">
						<p class="us">
							USA / CAN:
							<a href="tel:+{//data/prefs/entry/phone-us/@handle}"><xsl:value-of select="//data/prefs/entry/phone-us"/></a>
						</p>
					</xsl:if>
					<p class="us">
						<a href="mailto:{//data/prefs/entry/email}">
							<xsl:value-of select="//data/prefs/entry/email"/>
						</a>
					</p>
				</div>
			</div>
		</div>
	</section>

	<section class="homepage-section yellow-background-grey-text" id="newsletter">
			<div class="container">
				<xsl:if test="//data/prefs/entry/newsletter = 'Yes'">
					<h3>Newsletter</h3>
					<div id="newsletter-form">
						<script type="text/javascript" src="https://signup.ymlp.com/signup.js?id=geqwhjqgmgbm"></script>
					</div>
					<!--<form id="newsletter-form">
						<input type="email" name="email" placeholder="Enter Email" />
						<input role="button" type="submit" name="submit" value="Sign Up" />
					</form>-->
				</xsl:if>

				<ul class="social">
					<xsl:if test="//data/prefs/entry/facebook">
						<li>
							<a href="{//data/prefs/entry/facebook}">
								<img src="{$workspace}/assets/images/social-grey/facebook.png" />
							</a>
						</li>
					</xsl:if>
					<xsl:if test="//data/prefs/entry/twitter">
						<li>
							<a href="{//data/prefs/entry/twitter}">
								<img src="{$workspace}/assets/images/social-grey/twitter.png" />
							</a>
						</li>
					</xsl:if>
					<xsl:if test="//data/prefs/entry/instagram">
						<li>
							<a href="{//data/prefs/entry/instagram}">
								<img src="{$workspace}/assets/images/social-grey/instagram.png" />
							</a>
						</li>
					</xsl:if>
					<xsl:if test="//data/prefs/entry/linkedin">
						<li>
							<a href="{//data/prefs/entry/linkedin}">
								<img src="{$workspace}/assets/images/social-grey/linkedin.png" />
							</a>
						</li>
					</xsl:if>
				</ul>

				<footer> © Yellow Sub Geo 2018 | <a href="{$root}/how-we-use-cookies">How We Use Cookies</a> | Website by <a href="http://thinkorchard.com">Orchard</a></footer>
			</div>
		</section>

</xsl:template>

</xsl:stylesheet>