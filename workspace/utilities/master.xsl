<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="variables.xsl" />
<xsl:include href="date-time.xsl" />
<xsl:include href="navigation.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="pages.xsl" />
<xsl:include href="get-poll.xsl" />
<xsl:include href="error.xsl" />

<xsl:include href="coming-soon.xsl" />

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="/">

<html>

<head>
	<title>
		<xsl:choose>
			<xsl:when test="$current-page = 'home'">
				<xsl:choose>
					<xsl:when test="$page1 = '' or $page1 = 'home'">
						<!-- 'home' -->
						<xsl:value-of select="//data/translation-fields/entry[@id='668']/field-name[@lang=$lang]" /> | Rhydycar West
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="//data/pages/entry">
								<!-- page title -->
								<xsl:value-of select="//data/pages/entry/title[@lang=$lang]" /> | Rhydycar West
							</xsl:when>
							<xsl:otherwise>
								<!-- 'page not found' -->
								<xsl:value-of select="//data/translation-fields/entry[@id='669']/field-name[@lang=$lang]" /> | Rhydycar West
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$current-page = 'news'">
				<xsl:choose>
					<xsl:when test="$id = ''">
						<!-- 'news' -->
						<xsl:value-of select="//data/translation-fields/entry[@id='646']/field-name[@lang=$lang]" /> | Rhydycar West
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="//data/news/entry/title[@lang=$lang]" /> | Rhydycar West
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$current-page = 'projectlaunch'">
				<xsl:value-of select="//data/pages-project-launch/entry/title[@lang=$lang]" /> | Rhydycar West
			</xsl:when>
			<xsl:when test="$current-page = 'suggestions'">
				<xsl:value-of select="//data/pages-suggestions/entry/title[@lang=$lang]" /> | Rhydycar West
			</xsl:when>
			<xsl:otherwise>Rhydycar West</xsl:otherwise>
		</xsl:choose>
	</title>

	<meta charset="UTF-8" />
	<xsl:choose>
		<xsl:when test="//data/pages/entry/meta-description">
			<meta name="description" content="{//data/pages/entry/meta-description}" />
		</xsl:when>
		<xsl:otherwise>
			<meta name="description" content="{//data/prefs/entry/meta-desc}" />
		</xsl:otherwise>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="//data/pages/entry/meta-keywords">
			<meta name="keywords" content="{//data/pages/entry/meta-keywords}" />
		</xsl:when>
		<xsl:otherwise>
			<meta name="keywords" content="{//data/prefs/entry/meta-tags}" />
		</xsl:otherwise>
	</xsl:choose>
	
	<xsl:if test="$current-page != 'news'">
		<meta name="author" content="Rhydycar West" />
	</xsl:if>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
	<meta property="og:url" content="{$current-url}" />

	<xsl:if test="$current-page = 'news' and $id !=''">
		<meta property="og:type" content="article" />
		<meta property="og:title" content="{//data/news/entry/title}" />
		<meta property="og:description" content="{//data/blog/entry/abstract}" />
		<xsl:choose>
			<xsl:when test="//data/news/entry/featured-image">
				<meta property="og:image" content="{$workspace}{//data/news/entry/featured-image/@path}/{//data/news/entry/featured-image/filename}" />
			</xsl:when>
			<xsl:otherwise>
				<meta property="og:image" content="{$workspace}/assets/images/rhydycar_west_black.png" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="//data/news/entry/author/item">
				<meta name="author" content="{//data/news/entry/author/item}" />
			</xsl:when>
			<xsl:when test="//data/news/entry/guest-author">
				<meta name="author" content="{//data/news/entry/guest-author}" />
			</xsl:when>
			<xsl:otherwise>
				<meta name="author" content="Rhydycar West" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>

	<!-- FAVICON -->
	<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png" />
	<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png" />
	<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png" />
	<link rel="manifest" href="/site.webmanifest" />
	<link rel="mask-icon" href="/safari-pinned-tab.svg" color="#da532c" />
	<meta name="apple-mobile-web-app-title" content="Rhydycar West" />
	<meta name="application-name" content="Rhydycar West" />
	<meta name="msapplication-TileColor" content="#da532cs" />
	<meta name="theme-color" content="#ffffff" />

	<!-- NIVEAU GROTEST FROM TYPEKIT -->
	<link rel="stylesheet" href="https://use.typekit.net/lgu2dof.css" />

	<!--
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/js-offcanvas.css" />
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/jquery.timeline.css" />
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/plyr.css" />
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/fa-svg-with-js.css" />
	-->

	<!-- MINIFIED VENDOR CSS -->
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/minified.css" />

	<!-- GENERAL STYLES -->
	<!--<link rel="stylesheet/less" type="text/css" href="{$workspace}/assets/css/styles.less" charset="utf-8" />-->
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/styles.min.css" />

	<!-- JQUERY -->
	<script src="{$workspace}/assets/js/jquery-2.2.4.min.js"></script>
	<!--<script src="{$workspace}/assets/js/less-1.3.3.min.js"></script>-->

	<!--
	*modernizr
	<script src="{$workspace}/assets/js/modernizr-offcanvas.js"></script>
	*respond.js
	<script src="{$workspace}/assets/js/respond.js"></script>
	*fontawesome
	<script src="{$workspace}/assets/js/fontawesome-all.js"></script>
	*for menu 
	<script src="{$workspace}/assets/js/js-offcanvas.pkgd.min.js"></script>
	*for polls
	<script src="{$workspace}/assets/js/jquery.pollWidget.js"></script>
	*mobile footer navigation collapse
	<script src="{$workspace}/assets/js/footernav.js"></script>
	*match height
	<script src="{$workspace}/assets/js/jquery.matchHeight-min.js"></script>
	-->

	<!-- MINIFIED VENDOR & GENERAL JS -->
	<script src="{$workspace}/assets/js/minified.js"></script>


	<!-- HOMEPAGE SPECIFIC JS -->
	<xsl:if test="//data/params/ds-is-homepage">	
		<!--
		<script type="text/javascript" src="{$workspace}/assets/js/timeline-vendors.js"></script>
		<script type="text/javascript" src="{$workspace}/assets/js/jquery.timeline.js"></script>
		<script type="text/javascript" src="{$workspace}/assets/js/load-timeline.js"></script>
		<script src="{$workspace}/assets/js/homepage-blocks.js"></script>
		-->
		<script type="text/javascript" src="{$workspace}/assets/js/homepage.min.js"></script>
	</xsl:if>


	<!-- polyfills -->
	<script src="https://cdn.polyfill.io/v2/polyfill.min.js"></script>
	<!-- recaptacha -->
	<xsl:if test="//data/params/ds-is-form">
		<script src='https://www.google.com/recaptcha/api.js'></script>
	</xsl:if>

	<xsl:comment><![CDATA[[if lte IE 8]>
         
   <![endif]]]></xsl:comment>
</head>

<body>

		<xsl:if test="$gdpr = 'no'">
			<div id="gdpr">
				<div class="container">
					<form id="gdpr-form" action="{$current-url}/" method="post">
						<label><xsl:copy-of select="//data/prefs/entry/gdpr-message/*" /></label>
						<input type="hidden" value="yes" name="storage[gdpr][accept]" />
						<input id="gdpr-accept" type="submit" value="{//data/prefs/entry/accept-btn}" name="storage-action[set]" />
					</form>
				</div>
			</div>
		</xsl:if>

	<!-- header -->
	<header class="universal-header">
		<a href="{$root}" id="home-logo" role="button" aria-label="Go to Homepage">
			<img class="icon" src="{$workspace}/assets/images/rhydycar_icon_white.png" alt="Rhydycar West" />
			<img class="logo" src="{$workspace}/assets/images/rhydycar_west_white.png" alt="Rhydycar West" />
		</a>

			<nav class="header-nav">
				<ul>
					<xsl:apply-templates select="//data/header-navigation/entry[not(parent/item)]" mode="get-desktop-links"  />
					<li>
						<a href="#navigation" data-offcanvas-trigger="navigation" id="menu-button" role="button" aria-label="Open Full Menu">
							<img src="{$workspace}/assets/images/menu.png" />
						</a>
					</li>
				</ul>
			</nav>

	</header>

	<!-- off canvas navigation -->
	<aside id="navigation">
		<nav role="navigation" aria-label="main navigation">
			<button class="js-offcanvas-close" aria-label="Close Menu"><img src="{$workspace}/assets/images/cross.png" /></button>
			<ul class="navigation">
				<xsl:apply-templates select="//data/main-navigation/entry[not(parent/item)]" mode="get-navigation"  />
			</ul>
		</nav>
	</aside>

	<!-- page -->
	<xsl:apply-templates />

	<!-- footer -->
	<xsl:call-template name="footer" />

	<!-- CALL SCRIPTS -->
	<xsl:if test="$gdpr='no'">
		<script>
			$(function(){
				$('.universal-header').css('margin-top', $('#gdpr')[0].getBoundingClientRect().height);
				var resizeTimer;
				$(window).on('resize', function(e) {
					clearTimeout(resizeTimer);
					resizeTimer = setTimeout(function() {
						$('.universal-header').css('margin-top', $('#gdpr')[0].getBoundingClientRect().height);
					}, 250);
				});
			});
		</script>
	</xsl:if>
	<script>
		$('#navigation').offcanvas({ modifiers: 'right' });
	</script>

	<xsl:if test="$current-page = 'news'">
		<script>
			$(function() { $('.blog-block').matchHeight(); });
		</script>
	</xsl:if>
	
	<xsl:if test="//data/pages/entry/content/item/@section='video'">
		<script src="{$workspace}/assets/js/plyr.js"></script>
		<script>plyr.setup();</script>
	</xsl:if>

	<xsl:if test="//data/params/ds-is-form">
		<script>
			//reCaptcha callback function
	 		function recaptcha_callback(){
				var g_recaptcha_key = $("#g-recaptcha-response").val();
				$(".recaptcha_class").val(g_recaptcha_key);		  	
			}
			// form verification niceness
			$('.error').on('click', function(){ $(this).removeClass('error') });
			$('.error').on('focus', 'input', function(){ $(this).parent().removeClass('error') });
			$('.error').on('focus', 'textarea', function(){ $(this).parent().removeClass('error') });
		</script>
	</xsl:if>

</body>

</html>

</xsl:template>

</xsl:stylesheet>
