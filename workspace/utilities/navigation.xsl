<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template match="//data/footer-navigation/entry" mode="get-footer-navigation-one">

	<xsl:variable name="theURL">
		<xsl:choose>
			<xsl:when test="external-link !=''">
				<xsl:value-of select="external-link"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="page/item !=''">
						<xsl:choose>
							<xsl:when test="parent/item !=''">
								<xsl:value-of select="concat($root,'/',$lang,'/',parent/item/@handle,'/',page/item/@handle)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($root,'/',$lang,'/',page/item/@handle)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>#</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		 </xsl:choose>
	</xsl:variable>         

	<xsl:choose>
		<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
		</xsl:when>
		<xsl:otherwise>
			<li>
				<xsl:choose>
					<xsl:when test="$theURL='#'">
						<xsl:choose>
							<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
								<span><xsl:value-of select="title" /></span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="title" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<a href="{$theURL}">
							<xsl:choose>
								<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
									<span><xsl:value-of select="title" /></span>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="title" />
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</li>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<xsl:template match="//data/footer-navigation/entry" mode="get-footer-navigation-two">

	<xsl:variable name="theURL">
		<xsl:choose>
			<xsl:when test="external-link !=''">
				<xsl:value-of select="external-link"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="page/item !=''">
						<xsl:choose>
							<xsl:when test="parent/item !=''">
								<xsl:value-of select="concat($root,'/',$lang,'/',parent/item/@handle,'/',page/item/@handle)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($root,'/',$lang,'/',page/item/@handle)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>#</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		 </xsl:choose>
	</xsl:variable>         

	<xsl:choose>
		<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
			<ul class="footer-collapse">
				<li>
					<xsl:if test="../entry[parent/item/@handle = current()/title/@handle]">
						<xsl:attribute name="class">parent-li</xsl:attribute>
					</xsl:if>

					<xsl:choose>
						<xsl:when test="$theURL='#'">
							<xsl:choose>
								<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
									<span><xsl:value-of select="title" /></span>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="title" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<a href="{$theURL}">
								<xsl:choose>
									<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
										<span><xsl:value-of select="title" /></span>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="title" />
									</xsl:otherwise>
								</xsl:choose>
							</a>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:if test="../entry[parent/item/@handle = current()/title/@handle]">
						<ul class="fa-ul">
							<xsl:apply-templates select="../entry[parent/item/@handle = current()/title/@handle]" mode="footer-nav-children" />
						</ul>
					</xsl:if>
				</li>
			</ul>
		</xsl:when>

	</xsl:choose>

</xsl:template>

<xsl:template match="//data/footer-navigation/entry" mode="footer-nav-children">

	<xsl:variable name="theURL">
		<xsl:choose>
			<xsl:when test="external-link !=''">
				<xsl:value-of select="external-link"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="page/item !=''">
						<xsl:choose>
							<xsl:when test="parent/item !=''">
								<xsl:value-of select="concat($root,'/',$lang,'/',parent/item/@handle,'/',page/item/@handle)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($root,'/',$lang,'/',page/item/@handle)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>#</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		 </xsl:choose>
	</xsl:variable>         

			<li><span class="fa-li"><i class="fas fa-angle-right"></i></span>
				<xsl:choose>
					<xsl:when test="$theURL='#'">
						<xsl:choose>
							<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
								<span><xsl:value-of select="title" /></span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="title" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<a href="{$theURL}">
							<xsl:choose>
								<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
									<span><xsl:value-of select="title" /></span>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="title" />
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</li>

</xsl:template>

<xsl:template match="entry" mode="get-navigation">

	<xsl:variable name="theURL">
		<xsl:choose>
			<xsl:when test="external-link !=''">
				<xsl:value-of select="external-link"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="page/item !=''">
						<xsl:choose>
							<xsl:when test="parent/item !=''">
								<xsl:value-of select="concat($root,'/',$lang,'/',parent/item/@handle,'/',page/item/@handle)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($root,'/',$lang,'/',page/item/@handle)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>#</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		 </xsl:choose>
	</xsl:variable>

	<li>
		<xsl:choose>
			<xsl:when test="$theURL='#'">
				<xsl:choose>
					<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
						<span><xsl:value-of select="title" /></span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="title" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<a href="{$theURL}">
					<xsl:choose>
						<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
							<span><xsl:value-of select="title" /></span>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="title" />
						</xsl:otherwise>
					</xsl:choose>
				</a>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="../entry[parent/item/@handle = current()/title/@handle]">
			<ul>
				<xsl:apply-templates select="../entry[parent/item/@handle = current()/title/@handle]" mode="get-navigation" />
			</ul>
		</xsl:if>
	</li>

</xsl:template>

<xsl:template match="entry" mode="get-desktop-links">

	<xsl:variable name="theURL">
		<xsl:choose>
			<xsl:when test="external-link !=''">
				<xsl:value-of select="external-link"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="page/item !=''">
						<xsl:choose>
							<xsl:when test="parent/item !=''">
								<xsl:value-of select="concat($root,'/',$lang,'/',parent/item/@handle,'/',page/item/@handle)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($root,'/',$lang,'/',page/item/@handle)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>#</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		 </xsl:choose>
	</xsl:variable>

	<li class="desktop-nav">
		<xsl:choose>
			<xsl:when test="$theURL='#'">
				<xsl:choose>
					<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
						<span><xsl:value-of select="title" /></span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="title" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<a href="{$theURL}">
					<xsl:choose>
						<xsl:when test="../entry[parent/item/@handle = current()/title/@handle]">
							<span><xsl:value-of select="title" /></span>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="title" />
						</xsl:otherwise>
					</xsl:choose>
				</a>
			</xsl:otherwise>
		</xsl:choose>

	</li>

</xsl:template>

</xsl:stylesheet>