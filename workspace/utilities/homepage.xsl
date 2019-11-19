<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="data" name="home">
	<main class="homepage" id="home">
		<div class="homepage-title container">
			<div class="rhydycar">Rhydycar</div>
			<div class="message">
				<xsl:copy-of select="//data/messages/entry/message[@lang=$lang]/p" />
			</div>
			<div class="west">West</div>
		</div>
		<div class="homepage-content">
			<!--<xsl:apply-templates select="//data/pages/entry/content/item" mode="page-content" />-->
			<div class="container">
				<div class="col-xs-12 col-md-10">
					<xsl:copy-of select="//data/homepage-copy/entry/copy[@lang=$lang]/*" />
				</div>
			</div>
		</div>
		<div class="homepage-blocks" aria-label="homepage content blocks">
			<xsl:apply-templates select="//data/homepage-blocks/entry" />

			<xsl:if test="//data/prefs/entry/show-news = 'Yes'">
				<section id="latest-blog" class="block">
					<div class="block-head grey hp-blog">
						<div class="container">
							<div class="row">
								<div class="col-xs-12">
									<h2><xsl:value-of select="//data/translation-fields/entry[@id='646']/field-name[@lang=$lang]" /></h2>
								</div>
							</div>
						</div>
					</div>
					<div class="block-body grey-accent">

						<div class="container">
							<div class="row">
								<div class="col-xs-12">
									<h3 class="no-margin"><xsl:value-of select="//data/translation-fields/entry[@id='648']/field-name[@lang=$lang]" /></h3>
								</div>
							</div>
							<div class="row homepage-blog-container">
								<xsl:apply-templates select="//data/homepage-news/entry" mode="get-homepage-blog" />
							</div>
							<div class="row">
								<div class="col-xs-12 col-md-10 col-md-offset-1 u-center homepage-block-cta-container">
									<a href="{$root}/{$lang}/news" class="homepage-block-cta">
										<span class="buttontxt"><xsl:value-of select="//data/translation-fields/entry[@id='660']/field-name[@lang=$lang]" /></span> <i class="fas fa-angle-right"></i>
									</a>
								</div>
							</div>
						</div>

					</div>
				</section>
			</xsl:if>

		</div>

	</main>
</xsl:template>

<!-- HOMEPAGE BLOCKS -->
<xsl:template match="//data/homepage-blocks/entry">
	<xsl:variable name="openFirst">
		<xsl:choose>
			<xsl:when test="position() = '1' and //data/prefs/entry/open-first-block = 'Yes'">
				openFirst
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<section id="{title/@handle}" class="block">
		<button class="block-head {accent/item/@handle} accBlock_head {$openFirst}" id="{title/@handle}-button" aria-controls="{title/@handle}-content" aria-expanded="false">
			<div class="container">
				<div class="row">
					<div class="col-xs-12">
						<h2><xsl:value-of select="title[@lang=$lang]" /><span class="expand">+</span></h2>
					</div>
				</div>
			</div>
		</button>
		<div class="block-body accBlock_body" id="{title/@handle}-content" aria-hidden="true">
			<xsl:choose>
				<xsl:when test="tab-2-title">
					<xsl:attribute name="role">tablist</xsl:attribute>
					<xsl:attribute name="aria-label"><xsl:value-of select="title[@lang=$lang]" /></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">block-body accBlock_body <xsl:value-of select="accent/item/@handle" />-accent </xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>


			<xsl:choose>
				<xsl:when test="tab-2-title">
					<!-- has more than one tab, actually set up tabs -->
					
					<div class="block-tabs">

						<button data-mh="{@id}" class="block-tab-link {accent/item/@handle}-tab active" id="{tab-1-title/@handle}-tab" role="tab" aria-selected="false" aria-controls="{tab-1-title/@handle}" data-tab="{tab-1-title/@handle}">
							<xsl:value-of select="tab-1-title[@lang=$lang]" />
						</button>

						<button data-mh="{@id}" class="block-tab-link {accent-2/item/@handle}-tab" id="{tab-2-title/@handle}-tab" role="tab" aria-selected="false" aria-controls="{tab-2-title/@handle}" data-tab="{tab-2-title/@handle}">
							<xsl:value-of select="tab-2-title[@lang=$lang]" />
						</button>

						<xsl:if test="tab-3-title">
							<button data-mh="{@id}" class="block-tab-link {accent-3/item/@handle}-tab" id="{tab-3-title/@handle}-tab" role="tab" aria-selected="false" data-tab="{tab-3-title/@handle}">
								<xsl:value-of select="tab-3-title[@lang=$lang]" />
							</button>
						</xsl:if>
					</div>

					<div class="block-tab-content {accent/item/@handle}-block" id="{tab-1-title/@handle}" role="tabpanel" aria-labelledby="{tab-1-title/@handle}-tab">
						<div class="container">
							<xsl:apply-templates select="tab-1/item" mode="homepage-block-content" />
						</div>
					</div>
					<div class="block-tab-content not-first-tab {accent-2/item/@handle}-block" id="{tab-2-title/@handle}" role="tabpanel" aria-labelledby="{tab-2-title/@handle}-tab">
						<div class="container">
							<xsl:apply-templates select="tab-2/item" mode="homepage-block-content" />
						</div>
					</div>
					<xsl:if test="tab-3-title">
						<div class="block-tab-content not-first-tab {accent-3/item/@handle}-block" id="{tab-3-title/@handle}" role="tabpanel" aria-labelledby="{tab-3-title}-tab">
							<div class="container">
								<xsl:apply-templates select="tab-3/item" mode="homepage-block-content" />
							</div>
						</div>
					</xsl:if>

				</xsl:when>
				<xsl:otherwise>
					<!-- straight up content -->
					<div class="container">
						<xsl:apply-templates select="tab-1/item" mode="homepage-block-content" />
					</div>
				</xsl:otherwise>
			</xsl:choose>

		</div>
	</section>
</xsl:template>

<!-- HOMEPAGE BLOCK CONTENT -->
<xsl:template match="item" mode="homepage-block-content">
	<xsl:choose>

		<!-- COLUMN WITH TEXT -->
		<xsl:when test="@section = 'just-text'">
			<div class="row">
				<div class="col-xs-12 col-md-10 col-md-offset-1">
					<xsl:if test="subtitle"><h3><xsl:value-of select="subtitle[@lang=$lang]"/></h3></xsl:if>
					<xsl:copy-of select="copy[@mode='formatted'][@lang=$lang]/*"/>
				</div>
			</div>
		</xsl:when>

		<!-- TWO COLUMNS WITH IMAGE & TEXT -->
		<xsl:when test="@section = 'text-and-img'">
			<div class="row flex-sm">
				<xsl:if test="side/item/@handle='right'">
					<xsl:attribute name="class">row flex-sm u-flex-right</xsl:attribute>
				</xsl:if>

				<div>
					<xsl:choose>
						<xsl:when test="side/item/@handle='right'">
							<xsl:attribute name="class">col-xs-12 col-sm-6 img-col u-pull-right right</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">col-xs-12 col-sm-6 img-col left col-fix-margin</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:if test="image">
						<xsl:choose>
							<xsl:when test="crop">
								<xsl:variable name="cropHeight">
									<xsl:choose>
										<xsl:when test="crop/@ratio='1.5'">333</xsl:when>
										<xsl:when test="crop/@ratio='0.667'">750</xsl:when>
										<xsl:when test="crop/@ratio='1'">500</xsl:when>
										<xsl:otherwise><xsl:value-of select="image/meta/@height" /></xsl:otherwise>
									</xsl:choose>
								</xsl:variable>

								<img src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/500/{$cropHeight}{image/@path}/{image/filename}" />
							</xsl:when>
							<xsl:otherwise>
								<img class="u-max-full-width" src="{$root}/image/2/{image/meta/@width}/{image/meta/@height}/5{image/@path}/{image/filename}"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</div>

				<div class="col-xs-12 col-sm-6 text-col">
					<xsl:copy-of select="copy[@mode='formatted'][@lang=$lang]/*" />
				</div>
			</div>
		</xsl:when>

		<!-- TWO COLUMNS WITH POLL -->
		<xsl:when test="@section='poll-and-other'">
			<div class="row flex-sm">
				<xsl:if test="poll-side/item/@handle='right'">
					<xsl:attribute name="class">row flex-sm u-flex-right</xsl:attribute>
				</xsl:if>

				<div>
					<xsl:choose>
						<xsl:when test="poll-side/item/@handle='right'">
							<xsl:attribute name="class">col-xs-12 col-sm-6 u-pull-right right</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">col-xs-12 col-sm-6 left col-fix-margin</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:variable name="thisPollId" select="poll/item/poll-id" />
					<xsl:variable name="thisPollData" select="//data/*[name() = $thisPollId]/entry" />

					<xsl:call-template name="poll">
						<xsl:with-param name="pollId" select="$thisPollId" />
						<xsl:with-param name="pollData" select="$thisPollData" />
					</xsl:call-template>
				</div>

				<xsl:variable name="isColType">
					<xsl:if test="other-column/item/@section = 'just-text'">text-col</xsl:if>
					<xsl:if test="other-column/item/@section = 'img-col'">img-col</xsl:if>
				</xsl:variable>
				<div>
					<xsl:choose>
						<xsl:when test="poll-side/item/@handle='right'">
							<xsl:attribute name="class">col-xs-12 col-sm-6 left col-fix-margin <xsl:value-of select="$isColType" /></xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">col-xs-12 col-sm-6 right <xsl:value-of select="$isColType" /></xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:apply-templates select="other-column/item" mode="homepage-poll-second-col" />
				</div>

			</div>
		</xsl:when>

		<!-- CALL TO ACTION -->
		<xsl:when test="@section='cta'">
			<div class="row">
				<div class="col-xs-12 u-center homepage-block-cta-container">
					<a href="{link[@lang=$lang]}" class="homepage-block-cta"><span class="buttontxt"><xsl:value-of select="text[@lang=$lang]"/></span><i class="fas fa-angle-right"></i></a>
				</div>
			</div>
		</xsl:when>


	</xsl:choose>
</xsl:template>

<!-- SECOND COLUMN WITH POLL -->
<xsl:template match="item" mode="homepage-poll-second-col">
	<!-- second column = image -->
	<xsl:if test="@section = 'img-col'">
		<xsl:if test="image">
			<xsl:choose>
				<xsl:when test="crop">
					<xsl:variable name="cropHeight">
						<xsl:choose>
							<xsl:when test="crop/@ratio='1.5'">333</xsl:when>
							<xsl:when test="crop/@ratio='0.667'">750</xsl:when>
							<xsl:when test="crop/@ratio='1'">500</xsl:when>
							<xsl:otherwise><xsl:value-of select="image/meta/@height" /></xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<img src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/500/{$cropHeight}{image/@path}/{image/filename}" />
				</xsl:when>
				<xsl:otherwise>
					<img class="u-max-full-width" src="{$root}/image/2/{image/meta/@width}/{image/meta/@height}/5{image/@path}/{image/filename}"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:if>

	<!-- second column = text -->
	<xsl:if test="@section = 'just-text'">
		<xsl:if test="subtitle"><h3><xsl:value-of select="subtitle[@lang=$lang]"/></h3></xsl:if>
		<xsl:copy-of select="copy[@mode='formatted'][@lang=$lang]/*"/>
	</xsl:if>
</xsl:template>

<!-- LATEST NEWS/BLOG ENTRIES -->
<xsl:template match="entry" mode="get-homepage-blog">
	<xsl:variable name="accentColour">
		<xsl:choose>
			<xsl:when test="accent/item"><xsl:value-of select="accent/item/@handle" /></xsl:when>
			<xsl:otherwise>grey</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<div class="col-xs-12 col-sm-4 blog-entry">
		<div class="{$accentColour}-block blog-block" data-mh="homepage-blog">
			<div class="featured-image">
				<xsl:choose>
					<xsl:when test="featured-image">

						<xsl:choose>
							<xsl:when test="crop">
								<img src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/550/367{featured-image/@path}/{featured-image/filename}" />
							</xsl:when>
							<xsl:otherwise>
								<img class="u-max-full-width" src="{$root}/image/2/550/367/5{featured-image/@path}/{featured-image/filename}"/>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:when>
					<xsl:otherwise><img src="{$workspace}/assets/images/rhydycar_west_placehold.png" /></xsl:otherwise>
				</xsl:choose>
			</div>

			<div class="title">
				<h4><a href="{$root}/{$lang}/news/0/{@id}/{title[@lang=$lang]/@handle}">
					<xsl:value-of select="title[@lang=$lang]" />
				</a></h4>
			</div>

			<xsl:if test="abstract">
				<div class="abstract">
					<p><xsl:value-of select="abstract[@lang=$lang]" /></p>
				</div>
			</xsl:if>
		</div>
		<div class="{$accentColour}-block date">
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="date"/>
				<xsl:with-param name="format">d.n.Y</xsl:with-param>
			</xsl:call-template>
		</div>
		<div class="{$accentColour}-block read-more">
			<a href="{$root}/{$lang}/news/0/{@id}/{title[@lang='en']/@handle}" aria-label="Keep reading: {title[@lang=$lang]}">
				<span class="linktxt"><xsl:value-of select="//data/translation-fields/entry[@id='659']/field-name[@lang=$lang]" /></span> <i class="fas fa-angle-right"></i>
			</a>
		</div>
	</div>
</xsl:template>

</xsl:stylesheet>

