/*  
	-------------------------------------------------------------
	Cascade Style Sheet - jQuery Responsive Timeline slider
	Description: jQuery Plugin for building web timelines
	Author: pezflash - http://www.codecanyon.net/user/pezflash
	Version: 3.0
	-------------------------------------------------------------
*/ 


(function($){


	/*
	*********************************************************************************************************************
	* TIMELINE CONSTRUCT
	*/

	// PRELOAD IMAGES FUNCTION
	$.fn.preload = function (fn) {
		var len = this.length, i = 0;
		return this.each(function () {
			var tmp = new Image, self = this;
			if (fn) tmp.onload = function () {
				fn.call(self, 100 * ++i / len, i === len);
			};
			tmp.src = this.src;
		});
	};

	// MAIN FUNCTION
	$.fn.timelineSlider = function(options) {

		// OPTIONS SETTINGS
		var options = $.extend({

			// SIZING OPTIONS
			timelineWidth: 960,					// TIMELINE GLOBAL WIDTH, value in pixels OR 'auto' (WITH QUOTES) FOR FULLWIDTH
			timelineHeight: 500,				// TIMELINE GLOBAL HEIGHT, value in pixels
			upperAreaHeight: 265,				// UPPER AREA (IMAGES) HEIGHT, value in pixels
			lowerAreaHeight: 215,				// LOWER AREA (MILESTONES) HEIGHT, value in pixels
			draggerHeight: 21,					// DRAGGER (SCROLLBAR) HEIGHT, value in pixels

			// AUDIO OPTIONS
			audioPlayer: true,					// AUDIO PLAYER ACTIVE OR NOT, true OR false
			audioAutoPlay: true,				// MUSIC AUTOPLAY ON INIT, true OR false
			audioLoop: true,					// MUSIC RESTARTS AT THE END, true OR false
			audioFilePath: 'mp3/music.mp3',		// MUSIC FILE PATH

			// STYLING OPTIONS
			responsive: true,					// RESPONSIVE BEHAVIOUR, true OR false
			marksOnMobile: true,				// KEEP MARKS ON MOBILE (<768px), true OR false
			version: 'dark',					// LIGHT OR DARK THEME, 'light' OR 'dark'
			designStyle: 'default',				// DEFAULT OR FLAT DESIGN, 'default' OR 'flat'
			accentColor: '#299ec4',				// MAIN COLOR FOR TITLES AND EFFECTS, #hexadecimal
			timelineBorderWidth: 4,				// BORDER FOR GLOBAL CONTAINER, in pixels
			timelineBorderColor: '#ffffff',		// BORDER COLOR, #hexadecimal
			shadow: true						// DISPLAY SHADOW BELOW THE TIMELINE, true OR false

		}, options);


		// CONSTRUCT EACH DOM ELEMENT CALLED
		return this.each(function() {

			//SETUP VARS
			var	myWindow = $(window),
				windowWidth = myWindow.width(),
				wrapper = $(this),
				imagePath = 'http://rhydycarwest.com/workspace/assets/images',
				tl = wrapper.find('.timeline'),
				viewport = tl.find('.viewport'),
				images = tl.find('.viewport .images'),
				milestones = tl.find('.milestones'),
				content = tl.find('.milestones .content'),
				bar = tl.find('.scrollbar'),
				track = tl.find('.scrollbar .track'),
				dragger = tl.find('.scrollbar .track .dragger'),
				marks = tl.find('.marks'),
				vidBt = tl.find('.video_bt'),
				imgBt = tl.find('.image_bt,.video_bt'),
				readBt = tl.find('.readmore');


			// CREATE PRELOAD DIV
			wrapper.append('<div class="preload"></div>');


			// PRELOAD IMAGES BEFORE GOING AHEAD
			$('img').preload(function(perc, done) {
					

				// DEBUG PRELOADING TEST
				//console.log(this, perc, done);
				

				// ONCE ALL IMAGES LOADED, START
				if(done) {


					// SET WIDTH FOR IMAGES AND MILESTONES
					var contentWidth = 0,
						imagesWidth = 0,
						draggerWidth = 0;

					content.children().each(function() {
						contentWidth = contentWidth + $(this).outerWidth(true);
					});

					images.find('.point').each(function() {
						imagesWidth = imagesWidth + $(this).outerWidth(true);
						//console.log(imagesWidth);
					});

					draggerWidth = parseInt(dragger.css('width'));


					// CONFIG ALL ELEMENTS SIZES AND POSITIONS BASED ON HTML ATTRIBS
					wrapper.css('width', options.timelineWidth);
					wrapper.css('height', options.timelineHeight);
					images.css('width', imagesWidth);
					viewport.css('height', options.upperAreaHeight);
					content.css('width', contentWidth + 100);
					milestones.css('height', options.lowerAreaHeight);
					bar.css('top', options.upperAreaHeight - options.draggerHeight);
					track.css('height', options.draggerHeight + 1);
					dragger.css('height', options.draggerHeight);

					
					// FADE PRELOAD & TIMELINE FADE IN
					$('.preload').fadeOut(500);
					tl.animate({ opacity:1 }, 1000, 'easeOutQuad');


					// FRONTEND STYLING
					// ADD DARK CLASS
					if (options.version == 'dark') wrapper.addClass('dark');

					// MANAGE FLAT STYLING
					if (options.designStyle == 'flat') {
						wrapper.addClass('flat');

						var draggerURL = imagePath.concat('/', 'timeline/dragger.png');

						dragger.find('img').attr('src', draggerURL);
					}

					// ADD SHADOW
					if (options.shadow) wrapper.addClass('shadow');	

					// ADD ACCENT COLOR
					/*
					tl.find('.date').css( 'color', options.accentColor );
					var defaultColor;
					tl.find('.link a').hover(
						function() {
							defaultColor = $(this).css('color');
							$(this).css( 'color', options.accentColor );
						}, function() {
							$(this).css( 'color', defaultColor );
						}
					);
					tl.find('.boxed_link a').css( 'color', options.accentColor );
					*/

					// MANAGE BORDER
					if(options.timelineBorderWidth > 0) {
						//console.log(options.timelineBorderWidth)
						wrapper.css( 'border', options.timelineBorderWidth+'px solid '+options.timelineBorderColor );
						milestones.css( 'border-top', options.timelineBorderWidth+'px solid '+options.timelineBorderColor );
					}

					/*
					// HTML5 AUDIO PLAYER
					if (options.audioPlayer) {

						// CREATE AUDIO DIV
						wrapper.append('<audio class="audio_player" src="'+ options.audioFilePath +'"></audio>');

						// START PLAYER
						$('.audio_player').player({loop: options.audioLoop});

						// AUTOPLAY
						if(options.audioAutoPlay) $('.start-button').trigger('click');
					}
					*/

					
					// PRETTYPHOTO LIGHTBOX GALLERY
					$("a[data-rel^='prettyPhoto']").prettyPhoto({social_tools:false, theme:'timeline-slider'});
					
					
					// TIPSY - TOOLTIP
					readBt.tipsy({ gravity: 'w', fade: true, offset: 5 });
					
					
					// IMAGE & VIDEO ROLLOVER ICON
					imgBt.append('<span></span>').hover(function(){
						$(this).children('span').stop(true, true).fadeIn(400);
					},function(){
						$(this).children('span').stop(true, true).fadeOut(200);
					});
					
					
					// VIDEO THUMB STOPS MUSIC ON CLICK (IF PLAYING)
					/*
					if (simplePlayer !== 0) {

						vidBt.click(function() {
							console.log(simplePlayer.paused);
							if (!simplePlayer.paused) {
								simplePlayer.prettyPaused = 1;
								simplePlayer.pause();
							} else {
								simplePlayer.prettyPaused = 0;
							}
						});
					}
					*/
					
					// SCROLLBAR MILESTONES MARKS
					var marksAmount = marks.find('div').length;
					for ( var i = 0; i < marksAmount; i++ ) {
						current = marks.find('div:nth-child('+(i+1)+')');
						current
							.stop(true, true)
							.delay(500)
							.animate({ 'left':current.attr("data-xpos"), opacity:1 }, 700 + 100*i, 'easeOutQuad')
							.show()
							.tipsy({ gravity: 's', fade: true, offset: 3, fallback: current.attr("data-label") });
					};
					
					
					// START DRAG IMAGES FUNCTION
					startDrag(images);
					var dragStarted = true;
					
					
					// INIT SCROLLBAR
					dynamicScrollWidth = options.timelineWidth;		// INITIALLY, SET DYNAMIC WIDTH AS TIMELINE WIDTH

					tl.tinyscrollbar({
						wheel: 20,
						mouseWheel: 0,
						size: dynamicScrollWidth,
						draggerWidth: draggerWidth
					});

					// CALCULATE INIT POS FOR DRAGGER
					var draggerPos = $('.init').attr('data-xpos');

					// CALCULATE INIT POS FOR VIEWPORT

					var yourView = $(window).width();

					var initPointWidth = $('.initPoint').outerWidth(true);

					//console.log('point', initPointWidth, ' window ', yourView);

					if (initPointWidth > yourView){
						//console.log('point is wider than window');

						if ( $('.onScreen').length > 0 ){
							// has something that should be in the middle of the screen

							var showMeData = $('.onScreen')[0].getBoundingClientRect(); 
							//console.log( showMeData );

							//console.log( 'left over screensize', yourView - showMeData.width );	

							var margin = yourView - showMeData.width,
								margin = margin / 2;

							var goLeftViewport = showMeData.left - margin;

						} else {
							//just make it start at the edge of the window
							var showMeData = $('.initPoint')[0].getBoundingClientRect(); 
							var goLeftViewport = showMeData.left;
						}

					} else {
						//console.log('point smaller than window');

						if ( $('.edgeScreen').length > 0 ) {
							var showMeData = $('.edgeScreen')[0].getBoundingClientRect();
							//console.log(showMeData);
							var goLeftViewport = showMeData.left;
						} else {
							var showMeData = $('.initPoint')[0].getBoundingClientRect(); 

							//console.log(showMeData);
							//console.log( 'left over screensize', yourView - showMeData.width );

							var margin = yourView - showMeData.width,
								margin = margin / 2;

							var goLeftViewport = showMeData.left - margin;
						}
						
					}

					// CALCULATE INITIAL POS FOR TIMELINE

					var initPointData = $('.initMilestone')[0].getBoundingClientRect();

					var milestoneMargin = yourView - initPointData.width,
						milestoneMargin = milestoneMargin / 2;

					var goLeftTimeline = initPointData.left - milestoneMargin;

					// SET INITIAL POSITIONS
					//console.log(goLeftViewport);
					$('.dragger').animate({ 'left': draggerPos }, 700);
					$('.viewport .images').animate({ 'left': '-' + goLeftViewport }, 700);
					$('.milestones .content').animate({ 'left': '-' + goLeftTimeline }, 700);


					// RESPONSIVE - FULLWIDTH - ONRESIZE
					if (options.responsive || options.timelineWidth == 'auto') {

						// MANAGE FULLWIDTH FUNCTION
						function manageFullwidth() {

							// CHECK IF WINDOW WIDTH IS SET TO AUTO (FULLWIDTH)
							// IF SO, MAKE TIMELINE AUTOWIDTH AND UPDATE SCROLLBAR
							if (options.timelineWidth == 'auto') {

								wrapperToFull();						

							} else {

								// CHECK IF RESPONSIVE IS TRUE AND WINDOW LESS THAN TIMELINE WIDTH
								// IF SO, MAKE TIMELINE AUTOWIDTH AND UPDATE SCROLLBAR
								if (options.responsive && windowWidth < options.timelineWidth + 25) {
									
									wrapperToFull();

								} else {

									// IF NOT, RETURN WRAPPER TO DEFAULT WIDTH
									wrapper.css('width', options.timelineWidth);
									dynamicScrollWidth = options.timelineWidth;
									tl.tinyscrollbar_update();
								}
							}

							// MANAGE MARKS
							if (!options.marksOnMobile && windowWidth < 768) {
								marks.hide();
							} else {
								marks.show();
							}
						}

						// TIMELINE AUTOWIDTH AND UPDATE SCROLLBAR FUNCTION
						function wrapperToFull() {
							wrapper.css('width', 'auto');
							dynamicScrollWidth = parseInt(wrapper.css('width'));
							tl.tinyscrollbar_update();
						}

						// ONRESIZE EVENT
						/*
						myWindow.resize(function() {
							windowWidth = myWindow.width();
							manageFullwidth();
						});
						*/

						// https://css-tricks.com/snippets/jquery/done-resizing-event/
						var resizeTimer;
						$(window).on('resize', function(e) {

							clearTimeout(resizeTimer);
							resizeTimer = setTimeout(function() {
								windowWidth = myWindow.width();
								manageFullwidth();
							}, 100);
						});

						// CALL FULLWIDTH FUNCTION
						manageFullwidth();
					}



				} // END IF


			}); // END PRELOADING			


			// DRAG FUNCTION
			function startDrag(i) {
				var leftLimit = 0;

				i.draggable({
					axis: "x",
						
					start: function(event, ui) {
						if (ui.position != undefined) {
							leftLimit = ui.position.left;
						}
					},
					
					drag: function(event, ui) {
						leftLimit = ui.position.left;
						var rightLimit = i.width() - wrapper.width();							
						if (ui.position.left < 0 && ui.position.left * -1 > rightLimit) leftLimit = rightLimit * -1;
						if (ui.position.left > 0) leftLimit = 0;
						ui.position.left = leftLimit;
				
						content.css('left', leftLimit * ratio);				//MOVE CONTENT
						dragger.css('left', leftLimit * -ratioDragger);		//MOVE DRAGGER
						
						iScroll = -leftLimit;								//VALUE FOR MOUSE WHEEL -tinyscrollbar
						iScroll2 = -(content.position().left);				//VALUE FOR MOUSE WHEEL -tinyscrollbar
					}
				});

				i.addClass('drag_icon');
			};

			// STOP DRAG FUNCTION
			function stopDrag(i) {
				i.draggable('destroy');
				i.css('cursor', 'default');
			};

			
		}); // END EACH CONSTRUCTOR
		

	}; // TIMELINE CONSTRUCT

}(jQuery));