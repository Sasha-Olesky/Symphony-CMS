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

// Vars.
	var $window = $(window),
		$document = $(document),
		$body = $('body'),
		$html = $('html'),
		$bodyHtml = $('body,html'),
		$wrapOuter = $('#timelineOuter'),
		$wrapInner = $('#timelineInner'),
		$isVertical = null;

// Function to work out if page is vertical

	function IsVertical(){
		if (skel.breakpoint('small').active)
			{ return true }
		else
			{ return false }
	};

// Function to work out size of inner wrapper based on children

	function WrapperSize(){

		// If small screen, make wrapper 100% and bail
		if (skel.breakpoint('small').active){
			$wrapInner.css('width: 100%');
		} 

		// Otherwise, calclulate...
		else {
			var w = 0;

			// Add up section widths
			$wrapInner.children('section').each(function() {
				w += $(this).width();
				console.log('this w', w);
			});

			// Apply full width to wrapper
			$wrapInner.css('width', w + 'px');

		};

	};

// Recalculate wrapper width once images have loaded
	$wrapInner.imagesLoaded( function(){
		console.log('images have loaded');
		WrapperSize();
	});


// Add loading flag until everything is loaded
	$(function(){ $body.addClass('is-loading') 

// Page has loaded
	window.onload = function() {
		window.setTimeout(function(){
			$body.removeClass('is-loading');

			// Set wrapper size
			WrapperSize();

			// Set initial variable for viewport width
			isVertical = IsVertical();
			
		}, 100);
	};

// Reset wrapper if page resizes
	$window.on('resize', function() {

		// Check if small viewport activated
		var nowIsVertical = IsVertical();
		console.log(
			'now ', nowIsVertical,
			' was ', isVertical,
			' changed ', nowIsVertical != isVertical
		);

		// If there has been a change
		if (nowIsVertical != isVertical){

			// Reset variable
			isVertical = nowIsVertical;

			// Reset wrapper
			WrapperSize();

		}

	});
});