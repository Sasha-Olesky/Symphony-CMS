$(document).ready(function() {

				//console.log( $(window).width() );
				var fullHeight = ( $(window).width() < 768 ) ? 480 : 660;
				var upperHeight = ( $(window).width() < 768 ) ? 300 : 480;
				//console.log(fullHeight, upperHeight);

				// START THE TIMELINE
				$("#mytimeline").timelineSlider({

					// SIZING OPTIONS
					timelineWidth: 'auto',				// TIMELINE GLOBAL WIDTH, value in pixels OR 'auto' (WITH QUOTES) FOR FULLWIDTH
					timelineHeight: fullHeight,			// TIMELINE GLOBAL HEIGHT, value in pixels
					upperAreaHeight: upperHeight,				// UPPER AREA (IMAGES) HEIGHT, value in pixels
					lowerAreaHeight: 180,				// LOWER AREA (MILESTONES) HEIGHT, value in pixels
					draggerHeight: 21,					// DRAGGER (SCROLLBAR) HEIGHT, value in pixels

					// AUDIO OPTIONS
					
					audioPlayer: false,					// AUDIO PLAYER ACTIVE OR NOT, true OR false
					/*
					audioAutoPlay: true,				// MUSIC AUTOPLAY ON INIT, true OR false
					audioLoop: true,					// MUSIC RESTARTS AT THE END, true OR false
					audioFilePath: 'mp3/music.mp3',		// MUSIC FILE PATH
					*/

					// STYLING OPTIONS
					responsive: true,					// RESPONSIVE BEHAVIOUR, true OR false
					marksOnMobile: false,				// KEEP MARKS ON MOBILE (768px), true OR false
					version: 'light',					// LIGHT OR DARK THEME, 'light' OR 'dark'
					designStyle: 'flat',				// DEFAULT OR FLAT DESIGN, 'default' OR 'flat'
					accentColor: '#50883D',				// MAIN COLOR FOR TITLES AND EFFECTS, hexadecimal
					timelineBorderWidth: 0,				// BORDER FOR GLOBAL CONTAINER, in pixels
					timelineBorderColor: '#ffffff',		// BORDER COLOR, hexadecimal
					shadow: false,						// DISPLAY SHADOW BELOW THE TIMELINE, true OR false
				});


				/*  
					TIP: THE ABOVE EXAMPLE SETTINGS OVERWRITE ALL THE DEFAULT ONES INSIDE THE PLUGIN.
					IF YOU ARE OK WITH MOST OF THE DEFAULT SETTINGS YOU CAN EVEN START THE TIMELINE WITH SIMPLE CALLS:

					// SIMPLE PLAIN PLUGIN CALL
					$("#mytimeline").timelineSlider();		

					// SAMPLE CHANGING JUST THE WIDTH TO FULLWIDTH
					$("#mytimeline").timelineSlider({ timelineWidth: 'auto' });	
					
					// SAMPLE CHANGING WIDTH TO FULLWIDTH AND DISABLE AUDIO PLAYER
					$("#mytimeline").timelineSlider({ timelineWidth: 'auto', audioPlayer: false });
				*/


				// START PARALLAX ?
				/*
				var controller = new ScrollMagic.Controller({vertical: false, container: '.viewport' });

				var tween = new TimelineMax()
								.add([
									TweenMax.to('.viewport .images', 1, {backgroundPosition: "-40% 0", ease: Linear.easeNone}),
									TweenMax.to('.viewport .timeline-front', 1, {backgroundPosition: "-100% 0", ease: Linear.easeNone})
								]);

				var scene = new ScrollMagic.Scene({triggerElement: '.viewport', duration: 2000, offset: 450})
								.setTween(tween)
								.setPin('.viewport')
								.addTo(controller);
				*/
			});

		// TEXT MODALS/LIGHTBOXES

		$('.lightbox-trigger').off().on('click', function(){

			var triggered = '#' + $(this).attr('id') + '-lightbox';

			$(triggered).css('display', 'block');
			$('body').addClass('modal-open');

		});

		document.onkeydown = function(evt) {
			evt = evt || window.event;
			if (evt.keyCode == 27) {

				if ($('body').hasClass('modal-open')){
					$('.lightbox-container').fadeOut(400);
					$('body').removeClass('modal-open');
				}
			}
		};

		$('.lightbox-container').off().on('click', function(e){
			if ( $(e.target).hasClass('lightbox') || $(e.target).parents('.lightbox').length > 0){ 

				if ( $(e.target).hasClass('lightbox-close') || $(e.target).parents('.lightbox-close').length > 0 ){

					$('.lightbox-container').fadeOut(400);
					$('body').removeClass('modal-open');
				}

			} else {
			    $('.lightbox-container').fadeOut(400);
			    $('body').removeClass('modal-open');
			}
		});

