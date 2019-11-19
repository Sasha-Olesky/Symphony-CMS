(function ( $ ) {
	$.fn.pollWidget = function(settings) {

		var settings = $.extend({

			pollId: '',
			optionsNames: [],
			hasTextInput: false,
			textInputPos: -1

		}, settings);

		return this.each(function(){

			// SET UP
			var $widgetId = $(this)[0].id,
				$widget = $('#' + $widgetId),
				$form = $('#' + settings.pollId + '-form'),
				$results = $('#' + settings.pollId + '-results'),
				$inputs = $widget.find('input[type="radio"]'),
				$showWhenSelected = $('.' + settings.pollId + '-selected'),
				$hasTextInput = (settings.hasTextInput) ? true : false,
				$hasEmailInput = $widget.find('.emailInput') ? true : false;

			if ($hasTextInput){
				var $textInput = $('.' + settings.hasTextInput),
					$textInputPos = parseInt(settings.textInputPos)-1; 
			}

			if ($hasEmailInput){
				var $emailInput = $widget.find('.emailInput'),
					$consentBox = $('#' + settings.pollId +'-consentbox');
			}

			// GO
			$(document).ready(function(){
				// Only show poll if js is working
				$widget.attr('style', 'display: block');

				// Check for previous voting cookie
				var hasVoted = getCookie(settings.pollId);

				if (hasVoted != ''){
					//cookie exists

					// hide poll & show results
					$form.remove();

					var totalEntries = $('#' + settings.pollId + '-total').text(),
						totalEntries = (totalEntries) ? parseInt(totalEntries) : 0;

					// set width of results bars based on result % of total
					$.each(settings.optionsNames, function(i, optionName){
						
						var   optionTotal = $('#' + optionName + '-total').text(),
							  optionTotal = (optionTotal) ? parseInt(optionTotal) : 0, 
							optionPercent = (optionTotal > 0) ? optionTotal / totalEntries * 100 : 0;

							// fix for when there's only one result
							if (optionPercent == Infinity){ optionPercent = 100 };

							$('#' + optionName + '-percent').text(optionPercent.toFixed(0) + '%');
							$('#' + optionName + '-result').animate({ 'width': optionPercent + '%' });

					});

				} else {
					// no cookie
					$results.remove();

					// hide text input
					if ($hasTextInput)
						{ $textInput.attr('style', 'display:none') }

					// set actual form inputs on change of poll option
					$inputs.on('click', function(){

						var selected = parseInt(this.value) -1;

						$.each(settings.optionsNames, function(i, optionName){
							console.log(selected, i);
							if ( selected === i ){
								document.getElementById(optionName + '-val').value = 'yes';

								// show text input if right option is selected
								if ($hasTextInput){
									if ( $textInputPos === i ){
										$textInput.attr('style', 'display:block');
									} else {
										$textInput.attr('style', 'display:none');
									}
								}

							} else {
								document.getElementById(optionName + '-val').value = 'no';
							}

						});

						// show email input & submit button only when an option has been selected
						$showWhenSelected.attr('style', 'display:block');
					});

					if ($hasEmailInput){
						$emailInput.on('change', function(){
							console.log('change email', $(this).val());

							if ( $(this).val().length > 0 ){
								// is something there
								$consentBox.attr('required', true);
							} else {
								// no email
								$consentBox.attr('required', false);
							}
						})
					}

					// set cookie on form submission
					$form.submit(function(e){
						setCookie(settings.pollId, true, 365);
					});
				}

			});
		});
	}
}( jQuery ));

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+ d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}