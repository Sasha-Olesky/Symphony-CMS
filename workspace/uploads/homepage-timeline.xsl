<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="data" name="home-timeline">


<!-- TIMELINE WRAPPER -->
			<div id="mytimeline" class="timeline-wrapper">
				
					
				<!-- TIMELINE -->
				<div class="timeline">

						<!-- VIEWPORT - IMAGES -->
						<!-- NOTE: BETTER SPLIT IMAGES FOR SITE SPEED, BUT YOU CAN USE JUST ONE FULL IMAGE FOR ALL -->
						<!-- YOU CAN WRAP IMAGES INSIDE HREFS, FOR OPENING LIGHTBOX, LIKE THE SAMPLE BELOW -->
						<div class="viewport">
							<div class="images">
								<div class="points">
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/01.png" alt="" />
										<div class="inner">
											<span class="year">test</span>
										</div>
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/02.png" alt="" />
										<div class="inner">
											<span class="year">test</span>
										</div>
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/03.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/04.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/05.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/06.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/07.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/08.png" alt="" />
									</div>
									<div class="point initPoint">
										<img class="background" src="{$workspace}/assets/images/timeline/09.png" alt="" />
										<div class="inner">
											<h1 class="timeline-title onScreen">
												<xsl:copy-of select="//data/timeline-title/entry/title[@lang=$lang]/p"/>
											</h1>
										</div>
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/10.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/11.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/12.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/13.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/14.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/15.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/16.png" alt="" />
									</div>
									<div class="point">
										<img class="background" src="{$workspace}/assets/images/timeline/17.png" alt="" />
									</div>
									<div class="point final"></div>
									<div class="point final"></div>
								</div>
							</div>
						</div>

						<!-- SCROLLBAR (VIEW PLUGIN OPTIONS FOR STYLING) -->
						<div class="scrollbar">
							<div class="track">
							
								<!-- MARKS -->
								<!-- NOTE: MANUALLY POSITION (PERCENT %) EACH MARK WITH data-xpos ATTRIB -->
								<div class="marks">
									<!-- prehistory -->
									<div data-xpos="2%" data-label="{//data/translation-fields/entry[@id='649']/field-name[@lang=$lang]}"></div>
									<!-- industrial revolution -->
									<div data-xpos="15%" data-label="{//data/translation-fields/entry[@id='651']/field-name[@lang=$lang]}"></div>
									<!-- present day -->
									<div data-xpos="45%" data-label="{//data/translation-fields/entry[@id='652']/field-name[@lang=$lang]}"></div>
									<div data-xpos="72%" data-label="{//data/translation-fields/entry[@id='814']/field-name[@lang=$lang]}" class="init"></div>
								</div>
								<!-- DRAGGER -->
								<div class="dragger"><img src="{$workspace}/assets/images/images/scrollbar_dragger.png" alt="" /></div>
							</div>
						</div>

						<!-- MILESTONES -->
						<div class="milestones">						
							<div class="content">
								
								<xsl:apply-templates select="//data/milestones/entry" />

							</div>	<!-- END CONTENT -->
						</div> <!-- END MILESTONES -->
				
				</div> <!-- END TIMELINE -->
			
			
			</div> <!-- END TIMELINE WRAPPER -->

			<div class="scroll-down"><a href="#home"><img src="{$workspace}/assets/images/down.png" /></a></div>

		<!-- SCRIPTS -->
		<!--<script type="text/javascript" src="js/jquery/jquery-2.2.2.min.js"></script>-->
		<!--
		<script type="text/javascript" src="{$workspace}/assets/js/timeline-vendors.js"></script>
		<script type="text/javascript" src="{$workspace}/assets/js/jquery.timeline.js"></script>
	-->

		<!-- LOAD PLUGIN ON DOCUMENT READY -->
		<!--
		<script type="text/javascript" src="{$workspace}/assets/js/load-timeline.js"></script>
		-->
</xsl:template>

<!-- TEMPLATING FOR TIMELINE MILESTONES --> 
<xsl:template match="//data/milestones/entry">

	<div class="column">
		<xsl:if test="is-init = 'Yes'">
			<xsl:attribute name="class">column initMilestone</xsl:attribute>
		</xsl:if>
		<div class="c300">
			<xsl:if test="title">
				<span class="date">
					<xsl:value-of select="title[@lang=$lang]" />
				</span>
			</xsl:if>
			<xsl:if test="copy">
				<span class="txt">
					<xsl:value-of select="copy[@lang=$lang]" />
				</span>
			</xsl:if>

			<!-- HAS LIGHTBOX -->
			<xsl:apply-templates select="additional/item" />


		</div>
	</div>

</xsl:template>

<!-- TEMPLATING FOR LIGHTBOXES & CTAs -->
<xsl:template match="additional/item">

	<!-- CTA -->
	<xsl:if test="@section = 'milestone-cta'">
		<a class="btn" href="{cta-link[@lang=$lang]}"><xsl:value-of select="cta-text[@lang=$lang]" /><xsl:text>&#160;&#160;&#160;</xsl:text><i class="fas fa-angle-right"></i></a>
	</xsl:if>

	<!-- READ MORE -->
	<xsl:if test="@section = 'milestone-read-more'">
		<button class="btn lightbox-trigger">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:value-of select="link[@lang=$lang]" /><xsl:text>&#160;&#160;&#160;+</xsl:text>
		</button>

		<xsl:variable name="queryHashBackground"><xsl:value-of select="substring(background-colour, 1, 1)" /></xsl:variable>

		<xsl:variable name="backgroundColour">
			<xsl:choose>
				<xsl:when test="$queryHashBackground = '#'"><xsl:value-of select="background-colour" /></xsl:when>
				<xsl:otherwise><xsl:value-of select="concat('#', background-colour)" /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="queryHashFont"><xsl:value-of select="substring(font-colour, 1, 1)" /></xsl:variable>

		<xsl:variable name="fontColour">
			<xsl:choose>
				<xsl:when test="$queryHashFont = '#'"><xsl:value-of select="font-colour" /></xsl:when>
				<xsl:otherwise><xsl:value-of select="concat('#', font-colour)" /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>


		<div id="{@id}-lightbox" class="lightbox-container">
			<div class="lightbox">
				<xsl:if test="background-colour">
					<xsl:attribute name="style">background-color: <xsl:value-of select="$backgroundColour" /></xsl:attribute>
				</xsl:if>

				<xsl:if test="background-image">
					<div class="lightbox-background" style="background-image: url({$workspace}{background-image/@path}/{background-image/filename})"></div>
				</xsl:if>

				<div class="lightbox-inner">
					<xsl:if test="font-colour">
						<xsl:attribute name="style">color: <xsl:value-of select="$fontColour" /></xsl:attribute>
					</xsl:if>

					<xsl:copy-of select="copy[@lang=$lang]/*" />

					<xsl:if test="cta-link">
						<div class="cta-container">
							<a href="{cta-link[@lang=$lang]}" class="cta btn" title="{cta[@lang=$lang]}">
								<span class="buttontxt"><xsl:value-of select="cta[@lang=$lang]" /></span><i class="fas fa-angle-right"></i>
							</a>
						</div>
					</xsl:if>

				</div>
				<div class="lightbox-close"><img src="{$workspace}/assets/images/images/close.png" /></div>
			</div>
		</div>

	</xsl:if>
	<!-- /READ MORE -->

	<!-- VIDEO -->
	<xsl:if test="@section = 'milestone-video'">
		<span class="thumb">
			<a href="{video[@lang=$lang]/url}" data-rel="prettyPhoto" class="video_bt" title="{title[@lang=$lang]}">
				
				<xsl:choose>
					<xsl:when test="crop">
						<img src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/113/67{video-thumb/@path}/{video-thumb/filename}" />
					</xsl:when>
					<xsl:otherwise>
						<img src="{$root}/image/2/113/67/5{video-thumb/@path}/{video-thumb/filename}" />
					</xsl:otherwise>
				</xsl:choose>

			</a>
		</span>
		<span class="thumb_description">
			<xsl:value-of select="title[@lang=$lang]" />
		</span>
	</xsl:if>
	<!-- /VIDEO -->

	<!-- IMAGE GALLERY -->
	<xsl:if test="@section = 'milestone-image-gallery'">

		<a data-rel="prettyPhoto[{@id}_gallery]" class="btn">
			<xsl:for-each select="images/item">
				<xsl:if test="first">
					<xsl:attribute name="title"><xsl:value-of select="title[@lang=$lang]" /></xsl:attribute>
					<xsl:attribute name="href">
						<xsl:choose>
							<xsl:when test="crop">
								<xsl:value-of select="$root" />/image/5/<xsl:value-of select="crop/@width" />/<xsl:value-of select="crop/@height" />/<xsl:value-of select="crop/@x1" />/<xsl:value-of select="crop/@y1" />/<xsl:value-of select="crop/@width" />/<xsl:value-of select="crop/@height" /><xsl:value-of select="image/@path" />/<xsl:value-of select="image/filename" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$root" /><xsl:value-of select="image/@path" />/<xsl:value-of select="image/filename" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</xsl:if>
			</xsl:for-each>

			<xsl:value-of select="link[@lang=$lang]" /><xsl:text>&#160;&#160;&#160;+</xsl:text>
		</a>


		<div class="hidden">
			<xsl:for-each select="images/item">
				<xsl:choose>
					<xsl:when test="first"></xsl:when>
					<xsl:otherwise>
						<a data-rel="prettyPhoto[{../../@id}_gallery]" title="{title[@lang=$lang]}">
							<xsl:attribute name="href">
								<xsl:choose>
									<xsl:when test="crop">
										<xsl:value-of select="$root" />/image/5/<xsl:value-of select="crop/@width" />/<xsl:value-of select="crop/@height" />/<xsl:value-of select="crop/@x1" />/<xsl:value-of select="crop/@y1" />/<xsl:value-of select="crop/@width" />/<xsl:value-of select="crop/@height" /><xsl:value-of select="image/@path" />/<xsl:value-of select="image/filename" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$root" /><xsl:value-of select="image/@path" />/<xsl:value-of select="image/filename" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</div>
	</xsl:if>
	<!-- /IMAGE GALLERY -->

</xsl:template>


</xsl:stylesheet>