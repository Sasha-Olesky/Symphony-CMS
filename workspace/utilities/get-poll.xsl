<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

	<!-- 
	* TO CREATE A NEW POLL:
	* 1. CREATE SECTION FOR POLL, FOR BACKEND DATA COLLECTION
	* 2. CREATE DATASOURCE & EVENT - WITH SLUG/HANDLE THE SAME AS POLL
	* 3. CREATE NEW ENTRY IN POLL SECTION
	* 
	* MAKE SURE HANDLES ARE THE SAME FOR ALL POLL OPTIONS
	-->

<xsl:template name="poll">
	<xsl:param name="pollId" />
	<xsl:param name="pollData" />

	<xsl:variable name="formId"><xsl:value-of select="$pollId" />-form</xsl:variable>
	<xsl:variable name="resultsId"><xsl:value-of select="$pollId" />-results</xsl:variable>
	<xsl:variable name="selectedClass"><xsl:value-of select="$pollId" />-selected</xsl:variable>
	<xsl:variable name="submitButton">
		<xsl:choose>
			<xsl:when test="//data/polls/entry/submit-button[../poll-id=$pollId]">
				<xsl:value-of select="//data/polls/entry/submit-button[../poll-id=$pollId][@lang=$lang]" />
			</xsl:when>
			<xsl:otherwise>Submit</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

<!-- 
	* POLL USES COOKIES, SO ONLY SHOW IF USER HAS ACCEPTED SITE USE OF COOKIES
-->

<xsl:if test="$gdpr = 'yes'">
	<div class="poll" id="{$pollId}">
		<div class="poll-inner">
			<xsl:if test="//data/polls/entry/poll-colour[../poll-id=$pollId]">
				<xsl:variable name="backgroundColour" select="//data/polls/entry/poll-colour[../poll-id=$pollId]/item" />
				<xsl:attribute name="style">background-color:<xsl:value-of select="//data/colours/entry/hex[../name=$backgroundColour]" /></xsl:attribute>
			</xsl:if>
			<h4><xsl:value-of select="//data/polls/entry/question[../poll-id=$pollId][@lang=$lang]" /></h4>

			<form id="{$formId}" method="post" action="{$current-url}/#{$pollId}" enctype="multipart/form-data">
				<xsl:for-each select="//data/polls/entry/options[../poll-id=$pollId]/item">
					<label for="{option-handle}" class="poll-option">
						<xsl:value-of select="option-name[@lang=$lang]" />
						<input class="poll-radio-input" id="{option-handle}" type="radio" name="thing" value="{position()}" />
						<span class="poll-radio"></span>
					</label>
				</xsl:for-each>

				<xsl:for-each select="//data/polls/entry/options[../poll-id=$pollId]/item">
					<input type="hidden" name="fields[{option-handle}]" id="{option-handle}-val" />
				</xsl:for-each>

				<xsl:if test="//data/polls/entry/options[../poll-id=$pollId]/item/has-text-input='Yes'">
					<xsl:variable name="textInputId"><xsl:value-of select="//data/polls/entry/options[../poll-id=$pollId]/item/text-input-handle" /></xsl:variable>

					<label for="{$textInputId}" class="{$textInputId}"><xsl:value-of select="//data/polls/entry/options[../poll-id=$pollId]/item/text-input-title[@lang=$lang]" /></label>
					<textarea id="{$textInputId}" class="{$textInputId}" name="fields[{$textInputId}]" maxlength="500"></textarea>
				</xsl:if>

				<xsl:if test="//data/polls/entry/collect-emails[../poll-id=$pollId] = 'Yes'">
					<div class="{$selectedClass} show-when-selected collect-email">
				  		<span>To get updates on this issue, enter your email address:</span>
				  	
						<input type="email" name="fields[email]" class="emailInput" />
						<label for="{$pollId}-consentbox" class="{$pollId}-consentbox"><input type="checkbox" name="consent" class="{$pollId}-consentbox" id="{$pollId}-consentbox" /> 
							I consent to being emailed by Rhydycar West <br /> 
							<span class="privacy-policy">for more information, read our <a href="{$root}/{$lang}/gdpr">privacy policy</a></span>
						</label>
					 </div>
			 	</xsl:if>
			  	<input name="redirect" type="hidden" value="{$current-url}/" />
			  	<div class="poll-submit {$selectedClass} show-when-selected">
			  		<input class="btn-style" name="action[{$pollId}]" type="submit" value="{$submitButton}" />
			  	</div>

			</form>

			<div id="{$resultsId}">
				<xsl:for-each select="//data/polls/entry/options[../poll-id=$pollId]/item">
					<xsl:variable name="optionHandle" select="option-handle" />
					<xsl:variable name="theOption" select="$pollData/*[name() = $optionHandle]" />

					<span id="{option-handle}-total" class="forJS">
						<xsl:value-of select="count($theOption[. = 'Yes'])" />
					</span>
				</xsl:for-each>

				<span id="{$pollId}-total" class="forJS">
					<xsl:value-of select="count($pollData)" />
				</span>

				<div>
					<xsl:for-each select="//data/polls/entry/options[../poll-id=$pollId]/item">
						<div class="poll-result">
							<span class="option-name">
								<xsl:value-of select="option-name[@lang=$lang]" />
								<xsl:text> </xsl:text>
								<span id="{option-handle}-percent"></span>
							</span>
							<div id="{option-handle}-result" class="result-bar">
								<xsl:if test="bar-colour">
									<xsl:variable name="colourName" select="bar-colour/item" />
									<xsl:attribute name="style">background-color:<xsl:value-of select="//data/colours/entry/hex[../name=$colourName]" /></xsl:attribute>
								</xsl:if>
							</div>
						</div>
					</xsl:for-each>
				</div>
			</div>

			<xsl:variable name="options">[<xsl:for-each select="//data/polls/entry/options[../poll-id=$pollId]/item">'<xsl:value-of select="option-handle" />'<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>]</xsl:variable>
			<xsl:variable name="hasTextInput">
				<xsl:choose>
					<xsl:when test="//data/polls/entry/options[../poll-id=$pollId]/item/has-text-input"><xsl:value-of select="//data/polls/entry/options[../poll-id=$pollId]/item/text-input-handle" /></xsl:when>
					<xsl:otherwise>false</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="textInputPos">
				<xsl:choose>
					<xsl:when test="//data/polls/entry/options[../poll-id=$pollId]/item/has-text-input"><xsl:value-of select="count(//data/polls/entry/options[../poll-id=$pollId]/item/text-input-handle/../preceding-sibling::item) + 1" /></xsl:when>
					<xsl:otherwise>-1</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<script type="text/javascript">

				var thisPollId = '#' + '<xsl:value-of select="$pollId" />';

				$(thisPollId).pollWidget({
					pollId: '<xsl:value-of select="$pollId" />',
					optionsNames: <xsl:value-of select="$options" />,
					hasTextInput: '<xsl:value-of select="$hasTextInput" />',
					textInputPos: <xsl:value-of select="$textInputPos" />

				});

			</script>
		</div>
	</div>
</xsl:if>
</xsl:template>

</xsl:stylesheet>