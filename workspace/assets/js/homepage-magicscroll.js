// Skel.
	skel.breakpoints({
		xlarge: '(max-width: 1680px)',
		large: '(max-width: 1280px)',
		medium: '(max-width: 980px)',
		small: '(max-width: 736px)', // equiv of grid @md
		xsmall: '(max-width: 480px)',
		xxsmall: '(max-width: 360px)',
		short: '(min-aspect-ratio: 16/7)',
		xshort: '(min-aspect-ratio: 16/6)'
	});

// Variables
	var $window = $(window),
		$document = $(document),
		$wrapper = $('#wrapper');

// Set up function to set vertical variable
	function IsVertical(){
		if (skel.breakpoint('small').active)
			{ return true; }
		else
			{ return false; } 
	}

// Set up function to set up magic scroll
	function scrollAnimate( isVertical ){

		console.log(isVertical);

		var controller = new ScrollMagic.Controller({ vertical: isVertical });

		var blockTween = new TweenMax.to('#smBlock', 1.5, {
			backgroundColor: 'red'
		});

		var greenScene = new ScrollMagic.Scene({
			triggerElement: '#smGreen'
		})
			.setTween(blockTween)
			.addIndicators()
			.addTo(controller);

	}

// Ready event
	$(function(){

		console.log(skel.breakpoint('small').active);

	// Initial set up 
		var isVertical = IsVertical();
		console.log('initial', isVertical);
	
		//scrollAnimate(isVertical);

	// Reset if window resize

		$window.on('resize', function(){
			var nowIsVertical = IsVertical();

			console.log(
				'was ', isVertical, 
				', now ', nowIsVertical,
				', same ', isVertical === nowIsVertical);
			

			if (isVertical != nowIsVertical){
				console.log('change!');

				isVertical = nowIsVertical;
			}

		});
					
	});