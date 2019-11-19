<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="data" name="get-map">
<div class="container full-width map-container">
	<div id="map"></div>
</div>

<script>
	function initMap() {
		/* centre latlang set via preferences */
		var center = {lat: <xsl:value-of select="//data/prefs/entry/init-lat" />, lng: <xsl:value-of select="//data/prefs/entry/init-lng" />};

		/* dynamically create point variables */
		<xsl:apply-templates select="//data/map-points/entry" mode="latlang" />

		/* zoom level set via preferences */
		var map = new google.maps.Map(
						document.getElementById('map'), {
							zoom: <xsl:value-of select="//data/prefs/entry/init-zoom" />, 
							center: center,
							mapTypeControl: false,
							streetViewControl: false,
							mapTypeId: 'terrain'
							});

		var types = {
			heritage: 'H',
			ecology: 'E',
			leisure: 'L',
			activity: 'A'
		};

		/* dynamically create map markers */
		<xsl:apply-templates select="//data/map-points/entry" mode="marker" />

		/* dynamically create objects for info windows */
		<xsl:apply-templates select="//data/map-points/entry" mode="info" />

		var mapBounds = {
			north: 51.749883,
			south: 51.721658,
			west: -3.437057,
			east: -3.377266
		};

		var boxBounds = {
			north: 51.755839,
			south: 51.721658,
			east: -3.370651, 
			west: -3.441993
		}

		var mapImage = '<xsl:value-of select="$workspace" />/assets/images/mapoutline.png';

		var mapOverlay = new google.maps.GroundOverlay(mapImage, mapBounds);

		var rectangle = new google.maps.Rectangle({
          bounds: boxBounds,
          fillOpacity: 0,
          strokeWeight: 1
        });

        rectangle.setMap(map);

		mapOverlay.setMap(map);

	}
</script>

<script async="async" defer="defer" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCotjxss_h-Xd2KFqmXh22CXp-ChS7MBDA&amp;callback=initMap">
</script>

</xsl:template>

<xsl:template match="entry" mode="latlang">
	var <xsl:value-of select="slug" /> = {lat: <xsl:value-of select="lat" />, lng: <xsl:value-of select="lng" />};
</xsl:template>

<xsl:template match="entry" mode="marker">

	var <xsl:value-of select="slug" />Marker = new google.maps.Marker({
		position: <xsl:value-of select="slug" />, 
		map: map,
		animation: google.maps.Animation.DROP,
		label: types.<xsl:value-of select="type/item/@handle" />
		});
</xsl:template>

<xsl:template match="entry" mode="info">

	var <xsl:value-of select="slug" />Open = false;

	var <xsl:value-of select="slug" />Text = "<xsl:copy-of select="text[@lang=$lang]/*" disable-output-escaping="yes" />";
	var <xsl:value-of select="slug" />Image = 
		<xsl:choose>
			<xsl:when test="image">
				<xsl:choose>
					<xsl:when test="crop">'<img class="u-max-full-width" src="{$root}/image/5/{crop/@width}/{crop/@height}/{crop/@x1}/{crop/@y1}/300/200{image/@path}/{image/filename}" />'</xsl:when>
					<xsl:otherwise>'<img class="u-max-full-width" src="{$root}/image/2/300/200/5{image/@path}/{image/filename}" />'</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>''</xsl:otherwise>
		</xsl:choose>;
	var <xsl:value-of select="slug" />Video = 
		<xsl:choose>
			<xsl:when test="video">
				'<div class="videoContainer"><div class="videoWrapper"><xsl:value-of select="video/oembed/html" disable-output-escaping="yes" /></div></div>'
				<xsl:if test="is360 = 'Yes'">+ '<div class="mobileVideo"><a href="{video/url}" target="_blank"><xsl:value-of select="//data/translation-fields/entry[@id='826']/field-name[@lang=$lang]" /><i class="fas fa-angle-right"></i></a></div>'</xsl:if>
			</xsl:when>
			<xsl:otherwise>''</xsl:otherwise>
		</xsl:choose>;

	var <xsl:value-of select="slug" />InfoWindow = new google.maps.InfoWindow({
		content: '<div class="info-content">' + <xsl:value-of select="slug" />Text + <xsl:value-of select="slug" />Image + <xsl:value-of select="slug" />Video + '</div>'
	});

	<xsl:value-of select="slug" />Marker.addListener('click', function(){ 

		if (<xsl:value-of select="slug" />Open){
			<xsl:value-of select="slug" />InfoWindow.close();
			<xsl:value-of select="slug" />Open = false;
		} else {
			<xsl:value-of select="slug" />InfoWindow.open(map, <xsl:value-of select="slug" />Marker);
			<xsl:value-of select="slug" />Open = true;
		}
		
	});

	google.maps.event.addListener(<xsl:value-of select="slug" />InfoWindow,'closeclick',function(){
		<xsl:value-of select="slug" />Open = false;
	});

</xsl:template>

</xsl:stylesheet>