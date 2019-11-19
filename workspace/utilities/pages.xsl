<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
  doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
  omit-xml-declaration="yes"
  encoding="UTF-8"
  indent="yes" />

<xsl:template match="item" mode="page-content">

<!-- PARTNERS LOGOS BLOCK -->
<xsl:if test="@section = 'partner-block'">

	<section class="partner-block">
		<div class="container">
			<div class="row">

				<xsl:for-each select="partners/item">
					<xsl:variable name="display">
						<xsl:choose>
							<xsl:when test="logo">
								<img src="{$workspace}{logo/@path}/{logo/filename}" alt="{name}" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="name" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<div class="col-xs-12 col-sm-6 col-md-3 partner u-center">
						<xsl:choose>
							<xsl:when test="website">
								<a href="{website}" target="_blank" title="{name}">
									<xsl:choose>
										<xsl:when test="logo">
											<img src="{$workspace}{logo/@path}/{logo/filename}" alt="{name}" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="name" />
										</xsl:otherwise>
									</xsl:choose>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="logo">
										<img src="{$workspace}{logo/@path}/{logo/filename}" alt="{name}" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="name" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</div>
				</xsl:for-each>

			</div>
		</div>
	</section>

</xsl:if>

<!-- POLL -->
<xsl:if test="@section='polls'">

	<xsl:variable name="thisPollId" select="poll-id" />
	<xsl:variable name="thisPollData" select="//data/*[name() = $thisPollId]/entry" />

	<section class="single-poll">
		<div class="container fw-to-sm">
			<div class="row">
				<div class="col-xs-12 col-sm-10 col-sm-offset-1">
					<xsl:call-template name="poll">
						<xsl:with-param name="pollId" select="$thisPollId" />
						<xsl:with-param name="pollData" select="$thisPollData" />
					</xsl:call-template>
				</div>
			</div>
		</div>
	</section>

</xsl:if>

<!-- POLL & TEXT/IMAGE COLUMN -->

<xsl:if test="@section='poll-and-other'">
	<section class="poll-and-other">
		<div class="container">
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

				<xsl:variable name="hasColType">
					<xsl:if test="other-column/item/@section = 'just-text'">text-col</xsl:if>
					<xsl:if test="other-column/item/@section = 'img-col'">img-col</xsl:if>
				</xsl:variable>
				<div>
					<xsl:choose>
						<xsl:when test="poll-side/item/@handle='right'">
							<xsl:attribute name="class">col-xs-12 col-sm-6 left col-fix-margin <xsl:value-of select="$hasColType" /></xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">col-xs-12 col-sm-6 right <xsl:value-of select="$hasColType" /></xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:apply-templates select="other-column/item" mode="get-poll-second-col" />
				</div>

			</div>
		</div>
	</section>
</xsl:if>

<!-- LARGE PULL QUOTE -->
<xsl:if test="@section='large-pull-quote'">
	<xsl:variable name="bottomPadding">
		<xsl:choose>
			<xsl:when test="bottom-padding/item = 'none'">no-bottom-padding</xsl:when>
			<xsl:when test="bottom-padding/item = 'extra'">extra-bottom-padding</xsl:when>
			<xsl:when test="bottom-padding/item = 'less'">less-bottom-padding</xsl:when>
			<xsl:otherwise><!--either no choice or normal --></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<section class="large-pull-quote">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-md-10 col-md-offset-1">
					<xsl:copy-of select="copy[@mode='formatted'][@lang=$lang]/*" />
				</div>
			</div>
		</div>
	</section>

</xsl:if>

<!-- TEXT BLOCK -->
<xsl:if test="@section='just-text'">
	<xsl:variable name="bottomPadding">
		<xsl:choose>
			<xsl:when test="bottom-padding/item = 'none'">no-bottom-padding</xsl:when>
			<xsl:when test="bottom-padding/item = 'extra'">extra-bottom-padding</xsl:when>
			<xsl:when test="bottom-padding/item = 'less'">less-bottom-padding</xsl:when>
			<xsl:otherwise><!--either no choice or normal --></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<section class="just-text {$bottomPadding}">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-md-10 col-md-offset-1">
					<xsl:if test="subtitle"><h3><xsl:value-of select="subtitle[@lang=$lang]"/></h3></xsl:if>
					<xsl:copy-of select="copy[@mode='formatted'][@lang=$lang]/*"/>
				</div>

				<xsl:if test="cta-link">
					<div class="col-xs-12 item-cta-container u-center">
						<a href="{cta-link[@lang=$lang]}" class="item-cta"><span class="buttontxt"><xsl:value-of select="cta-text[@lang=$lang]"/></span><i class="fas fa-angle-right"></i></a>
					</div>
				</xsl:if>

			</div>
		</div>
	</section>
</xsl:if>

<!-- TEXT AND IMAGE BLOCK -->
<xsl:if test="@section='text-and-img'">

	<xsl:variable name="imgColClasses">
		<xsl:choose>
			<xsl:when test="side/item/@handle='right'">
				<xsl:choose>
					<xsl:when test="wider">col-xs-12 col-sm-6 col-lg-4 img-col u-pull-right right</xsl:when>
					<xsl:otherwise>col-xs-12 col-sm-6 img-col u-pull-right right</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="wider">col-xs-12 col-sm-6 col-lg-4 img-col left</xsl:when>
					<xsl:otherwise>col-xs-12 col-sm-6 img-col left col-fix-margin</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="bottomPadding">
		<xsl:choose>
			<xsl:when test="bottom-padding/item = 'none'">no-bottom-padding</xsl:when>
			<xsl:when test="bottom-padding/item = 'extra'">extra-bottom-padding</xsl:when>
			<xsl:when test="bottom-padding/item = 'less'">less-bottom-padding</xsl:when>
			<xsl:otherwise><!--either no choice or normal --></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<section class="text-and-img {$bottomPadding}">
		<div class="container">
			<xsl:if test="wider = 'Yes'"><xsl:attribute name="class">container wider</xsl:attribute></xsl:if>
			
			<div class="row flex-sm">
				<xsl:if test="side/item/@handle='right'">
					<xsl:attribute name="class">row flex-sm u-flex-right </xsl:attribute>
				</xsl:if>
				
				<!--<div class="col-xs-12 col-sm-6 col-md-5 img-col">
					<xsl:choose>
						<xsl:when test="side/item/@handle='right'">
							<xsl:attribute name="class">col-xs-12 col-sm-6 img-col u-pull-right right</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">col-xs-12 col-sm-6 img-col left col-fix-margin</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
				-->
				<div class="{$imgColClasses}">
					<xsl:choose>
						<xsl:when test="image">
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

									<img class="u-max-full-width" src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/500/{$cropHeight}{image/@path}/{image/filename}" alt="{alt[@lang=$lang]}" />
								</xsl:when>

								<xsl:otherwise>
									<img class="u-max-full-width" src="{$root}/image/2/{image/meta/@width}/{image/meta/@height}/5{image/@path}/{image/filename}" alt="{alt[@lang=$lang]}" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</div>

				<div>
					<xsl:choose>
						<xsl:when test="side/item/@handle='right'">
							<xsl:attribute name="class">col-xs-12 col-sm-6 text-col left col-fix-margin</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">col-xs-12 col-sm-6 text-col right</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					
					<div>
						<xsl:if test="wider">
							<xsl:choose>
								<xsl:when test="side/item/@handle='right'">
									<xsl:attribute name="style">float: right; max-width: 625px;</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="style">float: left; max-width: 625px;</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:copy-of select="copy[@mode='formatted'][@lang=$lang]/*"/>

						<xsl:if test="cta-link">

							<div class="item-cta-container">
								<a href="{cta-link[@lang=$lang]}" class="item-cta"><span class="buttontxt"><xsl:value-of select="cta-text[@lang=$lang]"/></span><i class="fas fa-angle-right"></i></a>
							</div>

						</xsl:if>
					</div>
				</div>
			</div>
		</div>
	</section>
</xsl:if>

<!-- TITLE AND COPY COLUMN BLOCK -->
<xsl:if test="@section='title-and-text-col'">
  <section class="title-and-copy {colour/item/@handle}">
    <div class="container full-width">
      <div class="row flex-md">
        <xsl:if test="side/item/@handle='right'">
          <xsl:attribute name="class">row flex-md u-flex-right</xsl:attribute>
        </xsl:if>
        
        <div>
          <xsl:choose>
            <xsl:when test="side/item/@handle='right'">
              <xsl:attribute name="class">col-xs-12 col-md-4 title-col right</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="class">col-xs-12 col-md-4 title-col left col-fix-margin</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>

          <h2 class="sr"><xsl:value-of select="title"/></h2>
        </div>

        <div>
          <xsl:choose>
            <xsl:when test="side/item/@handle='right'">
              <xsl:attribute name="class">col-xs-12 col-md-6 text-col left col-fix-margin</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="class">col-xs-12 col-md-6 text-col right</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:copy-of select="copy[@mode='formatted']/*"/>
          <xsl:if test="learn-more">
            <a href="{$root}{learn-more}">
              <xsl:choose>
                <xsl:when test="colour/item/@handle = 'blue'">
                  <xsl:attribute name="class">button white</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="class">button blue</xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>

              <xsl:choose>
                <xsl:when test="cta">
                  <xsl:value-of select="cta" />
                </xsl:when>
                <xsl:otherwise>
                  Learn more
                </xsl:otherwise>
              </xsl:choose>
            </a>
          </xsl:if>
        </div>

      </div>
    </div>
  </section>
</xsl:if>

<!-- TWO IMAGE BLOCK -->
<xsl:if test="@section='two-img'">
  <section class="two-img {colour/item/@handle}">
    <div class="container">
      <xsl:if test="full-width='Yes'">
        <xsl:attribute name="class">container full-width</xsl:attribute>
      </xsl:if>
      <div class="row flex-sm">
        <xsl:apply-templates select="images/item" mode="two-col-imgs"/>
      </div>
    </div>
  </section>
</xsl:if>


<!-- LARGE IMAGE -->
<xsl:if test="@section='large-image'">
  <section class="large-img">
    <div class="container fw-to-xl img-col">
      <xsl:if test="full-width='Yes'">
        <xsl:attribute name="class">container full-width img-col</xsl:attribute>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="no-crop='Yes'">
          <!-- don't crop -->
          <img src="{$workspace}{image/@path}/{image/filename}" class="u-max-full-width" alt="{alt[@lang=$lang]}" />
        </xsl:when>
        <xsl:otherwise>
          <!-- work out how to crop -->

          <xsl:choose>
            
            <xsl:when test="full-width='Yes'">
              <!-- full width -->

              <xsl:choose>
                <xsl:when test="crop">
                  <!-- has crop - 1600 wide -->
                  <img class="u-max-full-width" src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/1600/533{image/@path}/{image/filename}" alt="{alt[@lang=$lang]}"/>
                </xsl:when>
                <xsl:otherwise>
                  <!-- use jit to crop - 1600 wide -->
                  <img class="u-max-full-width" src="{$root}/image/2/1600/533/5{image/@path}/{image/filename}" alt="{alt[@lang=$lang]}"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>

            <xsl:otherwise>
              <!-- container width -->

              <xsl:choose>
                <xsl:when test="crop">
                  <!-- has crop 1200 wide -->
                  <img class="u-max-full-width" src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/1200/400{image/@path}/{image/filename}" alt="{alt[@lang=$lang]}"/>
                </xsl:when>
                <xsl:otherwise>
                  <!-- use jit 1200 wide -->
                  <img class="u-max-full-width" src="{$root}/image/2/1200/400/5{image/@path}/{image/filename}" alt="{alt[@lang=$lang]}"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>

          </xsl:choose>

        </xsl:otherwise>
      </xsl:choose>

    </div>
  </section>
</xsl:if>

<xsl:if test="@section='parallax'">
  <section class="parallax {height/item/@handle}" style="background-image:url({$workspace}{image/@path}/{image/filename});">
  </section>
</xsl:if>

<!-- VIDEO -->
<xsl:if test="@section='video'">
  <section class="video">
    <div class="container fw-to-xl">
      <xsl:choose>
        <xsl:when test="video/driver='Vimeo'">
          <div class="plyr_entity" data-type="vimeo" data-video-id="{video/@id}"></div> 
            <!--
            <div class="videoWrapper"> 
               <xsl:value-of select="video/oembed/html" disable-output-escaping="yes"/ 
            </div> -->
        </xsl:when>
        <xsl:when  test="video/driver='YouTube'">
          <div class="plyr_entity" data-type="youtube" data-video-id="{video/url}"></div>   
        </xsl:when>
      </xsl:choose>
      <xsl:if test="title"><p class="videoTitle"><xsl:value-of select="title" /></p></xsl:if>
    </div>
  </section>
</xsl:if>

</xsl:template>


<xsl:template match="images/item" mode="two-col-imgs">
  <div class="col-xs-6 img-col">
    <xsl:choose>
      <xsl:when test="crop">

        <img class="u-full-width" src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/879/586{image/@path}/{image/filename}"/>
      </xsl:when>
      <xsl:otherwise>

        <img class="u-full-width" src="{$root}/image/2/879/586/5{image/@path}/{image/filename}"/>

      </xsl:otherwise>
    </xsl:choose>
  </div>
</xsl:template>


<!-- SECOND COLUMN WITH POLL -->
<xsl:template match="item" mode="get-poll-second-col">
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

					<img src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/500/{$cropHeight}{image/@path}/{image/filename}" alt="{alt[@lang=$lang]}" />
				</xsl:when>
				<xsl:otherwise>
					<img class="u-max-full-width" src="{$root}/image/2/{image/meta/@width}//5{image/@path}/{image/filename}" alt="{alt[@lang=$lang]}" />
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


</xsl:stylesheet>