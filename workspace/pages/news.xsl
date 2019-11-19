<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="../utilities/master.xsl" />
<xsl:include href="../utilities/pagination.xsl" />

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="data">

	<xsl:choose>
		<xsl:when test="//data/params/id = ''">
			<xsl:variable name="hasHeadImgClass"><xsl:if test="//data/pages-news/entry/header-img">has-background</xsl:if></xsl:variable>

			<xsl:variable name="accentHexHashQuery"><xsl:value-of select="substring(//data/pages-news/entry/accent-hex, 1, 1)" /></xsl:variable>
			<xsl:variable name="accentHex">
				<xsl:choose>
					<xsl:when test="$accentHexHashQuery = '#'"><xsl:value-of select="//data/pages-news/entry/accent-hex" /></xsl:when>
					<xsl:otherwise><xsl:value-of select="concat('#', //data/pages-news/entry/accent-hex)" /></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<header class="page-header">
				<xsl:choose>
					<xsl:when test="//data/pages-news/entry/header-img">
						<div class="header-img">
							<xsl:attribute name="style">
								background-image:url(<xsl:value-of select="$workspace"/><xsl:value-of select="//data/pages-news/entry/header-img/@path"/>/<xsl:value-of select="//data/pages-news/entry/header-img/filename"/>)
							</xsl:attribute>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="style">
							background-color: #f1f2f3
						</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:if test="//data/pages-news/entry/accent-hex">
					<div class="header-background-colour" style="background-color: {$accentHex}"></div>
				</xsl:if>

				<div class="header-content {$hasHeadImgClass} has-flex">
					<div class="container">
						<div class="row">
							<div class="col-xs-12 page-title">
								<h1>
									<xsl:value-of select="//data/pages-news/entry/title[@lang=$lang]" />
								</h1>
							</div>
							<xsl:if test="//data/pages-news/entry/blurb">
								<div class="col-xs-12 col-sm-9 col-md-8 col-lg-6 page-blurb">
									<xsl:copy-of select="//data/pages-news/entry/blurb[@lang=$lang]/*" />
								</div>
							</xsl:if>
						</div>
					</div>
				</div>

			</header>

			<main class="blog-list">
				<div class="container fw-to-sm">
					<div class="row blog-grid">
						<xsl:apply-templates select="//data/news/entry" mode="list" />
					</div>
					<div class="row pagination">
						<div class="col-xs-12">
							<xsl:call-template name="pagination">
								<xsl:with-param name="pagination" select="//data/news/pagination" />
								<xsl:with-param name="pagination-url" select="'?page=$'" />
								<xsl:with-param name="label-next" select="//data/translation-fields/entry[@id='687']/field-name[@lang=$lang]" />
								<xsl:with-param name="label-previous" select="//data/translation-fields/entry[@id='688']/field-name[@lang=$lang]" />
							</xsl:call-template>
						</div>
					</div>
				</div>
			</main>

		</xsl:when>
		<xsl:otherwise>
			
			<xsl:choose>
				<xsl:when test="//data/news/entry">
					<xsl:apply-templates select="//data/news/entry" mode="single" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="errorpage">
						<xsl:with-param name="type">news</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<!-- BLOG LIST -->
<xsl:template match="//data/news/entry" mode="list">

	<xsl:variable name="accentColour">
		<xsl:choose>
			<xsl:when test="accent/item"><xsl:value-of select="accent/item/@handle" /></xsl:when>
			<xsl:otherwise>grey</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="onPage">
		<xsl:value-of select="../pagination/@current-page" />
	</xsl:variable>

	<div class="col-xs-12 col-sm-6 col-lg-4 blog-entry">
		<div class="{$accentColour}-block blog-block">

			<div class="featured-image">
				<xsl:choose>
					<xsl:when test="featured-image">

						<xsl:choose>
							<xsl:when test="crop">
								<img src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/550/367{featured-image/@path}/{featured-image/filename}" />
							</xsl:when>
							<xsl:otherwise>
								<img src="{$root}/image/2/550/367/5{featured-image/@path}/{featured-image/filename}" />
							</xsl:otherwise>
						</xsl:choose>

					</xsl:when>
					<xsl:otherwise>
						<img src="{$workspace}/assets/images/rhydycar_west_placehold.png" />
					</xsl:otherwise>
				</xsl:choose>
			</div>

			<div class="title">
				<h4><a href="{$root}/{$lang}/news/{$onPage}/{@id}/{title[@lang=$lang]/@handle}">
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
			<a href="{$root}/{$lang}/news/{$onPage}/{@id}/{title[@lang='en']/@handle}" aria-label="Keep reading: {title[@lang=$lang]}">
				<span class="linktxt"><xsl:value-of select="//data/translation-fields/entry[@id='659']/field-name[@lang=$lang]" /></span> <i class="fas fa-angle-right"></i>
			</a>
		</div>
	</div>
</xsl:template>

<!-- SINGLE BLOG ENTRY -->
<xsl:template match="//data/news/entry" mode="single">
	<xsl:variable name="hasHeadImgClass"><xsl:if test="header-img">has-background</xsl:if></xsl:variable>
	<xsl:variable name="accentColour">
		<xsl:choose>
			<xsl:when test="accent/item"><xsl:value-of select="accent/item/@handle" /></xsl:when>
			<xsl:otherwise>grey</xsl:otherwise>
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

		<div class="header-content {$hasHeadImgClass} has-flex {$accentColour}-accent">
			<div class="container">
				<div class="row">
					<div class="col-xs-12">
						<h1>
							<xsl:value-of select="title[@lang=$lang]" />
						</h1>
					</div>
				</div>
				<div class="row flex-sm">
					<div class="col-xs-12 col-sm-6 date">
						<xsl:call-template name="format-date">
							<xsl:with-param name="date" select="date"/>
							<xsl:with-param name="format">d.n.Y</xsl:with-param>
						</xsl:call-template>
					</div>
					<div class="col-xs-12 col-sm-6 author">
						<xsl:choose>
							<xsl:when test="guest-author">
								<xsl:value-of select="//data/translation-fields/entry[@id='667']/field-name[@lang=$lang]" />
								<xsl:text> </xsl:text>
								<xsl:value-of select="guest-author" />
							</xsl:when>
							<xsl:when test="author">
								<xsl:value-of select="//data/translation-fields/entry[@id='667']/field-name[@lang=$lang]" />
								<xsl:text> </xsl:text>
								<xsl:value-of select="author/item" />
							</xsl:when>
						</xsl:choose>
					</div>
				</div>
			</div>
		</div>

	</header>

	<main class="blog-post">
		<xsl:apply-templates select="content/item" mode="page-content" />

		<div class="blog-footer {$accentColour}-block">
			<div class="container">
				<div class="row">
					<div class="col-xs-12 col-sm-6 blog-back">

						<xsl:variable name="returnToPage">
							<xsl:choose>
								<xsl:when test="$pagination &gt; 1"><xsl:value-of select="$pagination"/></xsl:when>
								<xsl:otherwise>1</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

						<a href="{$root}/{$lang}/news?page={$returnToPage}"><i class="fas fa-angle-left"></i><xsl:value-of select="//data/translation-fields/entry[@id='690']/field-name[@lang=$lang]" /></a>

					</div>
					<div class="col-xs-12 col-sm-6">
						<div class="blog-share">
							<span>Share this: </span>
							<a href="http://www.facebook.com/share.php?u={$root}/{$lang}/{$current-page}/0/{@id}" target="_blank" aria-label="share this post on facebook">
								<!--<img src="{$workspace}/assets/images/facebook-icon.png" />-->
								<i title="Share on Facebook" class="fab fa-facebook-square fa-fw"></i>
							</a>
							<a href="http://twitter.com/intent/tweet?text={title[@lang=$lang]}%20-%20{$root}/{$lang}/{$current-page}/0/{@id}" target="_blank" aria-label="share this post on twitter">
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

