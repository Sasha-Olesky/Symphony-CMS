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

	<xsl:choose>
		<xsl:when test="//data/params/id = ''">
			<header class="page-header">
				<!--
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

						</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				-->

				<div class="container header-content">
					<div class="row">
						<div class="col-xs-12">
							<h1>
								<xsl:value-of select="//data/translation-fields/entry[@id=646]/field-name[@lang=$lang]" />
							</h1>
						</div>
					</div>
				</div>

			</header>

			<main class="blog-list">
				<div class="container fw-to-sm">
					<div class="row">
						<xsl:apply-templates select="//data/blog/entry" mode="list" />
					</div>
				</div>
			</main>

		</xsl:when>
		<xsl:otherwise>
			
			<xsl:apply-templates select="//data/blog/entry" mode="single" />

		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<!-- BLOG LIST -->
<xsl:template match="//data/blog/entry" mode="list">

	<xsl:variable name="accentColour">
		<xsl:choose>
			<xsl:when test="accent/item"><xsl:value-of select="accent/item/@handle" /></xsl:when>
			<xsl:otherwise>grey</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<div class="col-xs-12 col-sm-6 col-lg-4 blog-entry">
		<div class="{$accentColour}-block blog-block">

			<div class="featured-image">
				<xsl:choose>
					<xsl:when test="featured-image">

						<xsl:choose>
							<xsl:when test="crop">
								<img src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/500/333{featured-image/@path}/{featured-image/filename}" />
							</xsl:when>
							<xsl:otherwise>
								<img src="{$root}/image/2/500/333/5{featured-image/@path}/{featured-image/filename}" />
							</xsl:otherwise>
						</xsl:choose>

					</xsl:when>
					<xsl:otherwise>
						<img src="{$workspace}/assets/images/placeholder_rhydycar_logo.png" />
					</xsl:otherwise>
				</xsl:choose>
			</div>

			<div class="title">
				<h4><a href="{$current-url}/{@id}/{title[@lang=$lang]/@handle}">
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
			<a href="{$root}/{$lang}/blog/{@id}/{title[@lang='en']/@handle}" aria-label="Keep reading: {title[@lang=$lang]}">
				<xsl:value-of select="//data/translation-fields/entry[@id='659']/field-name[@lang=$lang]" />
			</a>
		</div>
	</div>
</xsl:template>

<!-- SINGLE BLOG ENTRY -->
<xsl:template match="//data/blog/entry" mode="single">
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

				</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>

		<div class="container header-content">
			<div class="row">
				<div class="col-xs-12">
					<h1>
						<xsl:value-of select="title[@lang=$lang]" />
					</h1>
				</div>
			</div>
			<div class="row">
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

	</header>

	<main class="blog-post">
		<xsl:apply-templates select="content/item" mode="page-content" />

		<section class="blog-footer {$accentColour}-block">
			<div class="container">
				<div class="row">
					<div class="col-xs-12 col-sm-6 blog-back">
						<a href="{$root}/{$lang}/blog">Back to Blog</a>
					</div>
					<div class="col-xs-12 col-sm-6 blog-share">
						<span>Share this: </span>
						<a href="http://www.facebook.com/share.php?u={$root}/{$lang}/{$current-page}/{@id}" target="_blank">FB</a>
					<a href="http://twitter.com/intent/tweet?text={title[@lang=$lang]}%20-%20{$root}/{$lang}/{$current-page}/{@id}" target="_blank">TW</a>
					</div>
				</div>
			</div>
		</section>
	</main>

</xsl:template>



<!--

<xsl:template match="//data/blog/entry" mode="single">
	<div class="container fw">
		<div class="blog-header">
			<div class="head-img">
				<img src="{$workspace}/assets/images/blog-header-{colour/item/@handle}.png" class="u-max-full-width" />
			</div>
			<div class="head-txt">
				<h1><xsl:value-of select="title"/></h1>
				<div class="author">
					<xsl:choose>
						<xsl:when test="guest-author">
							By <xsl:value-of select="guest-author"/>
						</xsl:when>
						<xsl:otherwise>
							By <xsl:value-of select="author/item" />
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div class="date">
					<xsl:call-template name="format-date">
                        <xsl:with-param name="date" select="date"/>
                        <xsl:with-param name="format">d/n/y</xsl:with-param>
                	</xsl:call-template>
				</div>
			</div>
		</div>
	</div>

	<div class="container fw contains-blog">
		<xsl:choose>
			<xsl:when test="featured-image">
				<xsl:choose>
					<xsl:when test="featured-bg='Yes'"><div class="blog-featured-image with-image" style="background-image:url({$workspace}{featured-image/@path}/{featured-image/filename})"></div></xsl:when>
					<xsl:otherwise>
						<div class="blog-featured-image"></div>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<div class="blog-featured-image"></div>
			</xsl:otherwise>
		</xsl:choose>

		<div class="blog-post">
			<xsl:if test="featured-image">
				<xsl:if test="featured-bg='Yes'">
					<xsl:attribute name="class">blog-post with-image</xsl:attribute>
				</xsl:if>
			</xsl:if>
			<div class="post-body">
				<xsl:if test="featured-image">
					<xsl:if test="feature-full='Yes'">
						<div class="feature-full"><img src="{$workspace}{featured-image/@path}/{featured-image/filename}" class="u-max-full-width"/></div>
					</xsl:if>
				</xsl:if>
				<xsl:copy-of select="blog-post/*" />

				<xsl:if test="additional-images">
					<div class="blog-images">
						<xsl:apply-templates select="//data/blog/entry/additional-images/item" />
					</div>
				</xsl:if>

			</div>
			<div class="post-footer row">
				<div class="share col-xs-12 col-md-6 u-pull-right">
					<span>Share This:</span>

					<a href="http://www.facebook.com/share.php?u={$root}/{$current-page}/{@id}" target="_blank"><img src="{$workspace}/assets/images/fb30.png" /></a>
					<a href="http://twitter.com/intent/tweet?text={title}%20-%20{$root}/{$current-page}/{@id}" target="_blank"><img src="{$workspace}/assets/images/twitter30.png" /></a>
				</div>
				<div class="back col-xs-12 col-md-6">
					<a href="{$root}/{$current-page}">&#171; Back to Blog</a>
				</div>
			</div>
		</div>
	</div>
	

	<section class="gen">
		<div class="container">
			
		</div>
	</section>
	
</xsl:template>

<xsl:template match="//data/blog/entry/additional-images/item">

	<xsl:choose>
		<xsl:when test="crop">
			<img src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/180/180{image/@path}/{image/filename}" />
		</xsl:when>
		<xsl:otherwise>
			<img src="{$root}/image/2/180/180/5{image/@path}/{image/filename}"/>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

-->

</xsl:stylesheet>
