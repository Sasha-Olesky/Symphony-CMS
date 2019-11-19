// future anyone, sorry for the weird mix of jquery and vanilla js
// i mean, i'm not really sorry
// but yeah.

$(document).ready(function(){

	$('.accBlock_body').css('display', 'none');
	$('.not-first-tab').css('display', 'none');

	// ACCORDION
	var acc = document.getElementsByClassName('accBlock_head');
	var i;

	for (i = 0; i < acc.length; i++) {

		acc[i].addEventListener('click', function() {
			this.classList.toggle('active');

			var expand = this.getElementsByClassName('expand')[0];
			var panel = this.nextElementSibling;

			if (panel.style.display === 'block') {
				panel.style.display = 'none';
				
				this.setAttribute('aria-expanded', 'false');
				panel.setAttribute('aria-hidden', 'true');

				expand.innerHTML = '+';

				if (panel.getElementsByClassName('block-tabs').length > 0) {
					
					var buttons = panel.getElementsByClassName('block-tab-link');
					var bi;

					for (bi = 0; bi < buttons.length; bi++) {
						buttons[bi].setAttribute('aria-selected', 'false');
					}
				}

			} else {
				panel.style.display = 'block';
				this.setAttribute('aria-expanded', 'true');
				panel.setAttribute('aria-hidden', 'false');

				expand.innerHTML = '-';


				if (panel.getElementsByClassName('block-tabs').length > 0) {
					var firstButton = panel.getElementsByClassName('block-tab-link')[0];

					firstButton.setAttribute('aria-selected', 'true');
				}
			}

		});
	}
	// OPEN FIRST BLOCK IF BIGGER THAN MOBILE
	if ($(window).width() > 550) { acc[0].click() }

	// TABS
	$('.block-tab-link').on('click', function(){
		var id = $(this).attr('data-tab');
		var thisBlock = $(this).closest('.block-body');

		thisBlock.find('.block-tab-content').css('display', 'none');
		thisBlock.find('.block-tab-link').removeClass('active');
		thisBlock.find('.block-tab-link').attr('aria-selected', 'false');

		$(this).addClass('active');
		$(this).attr('aria-selected', 'true');
		$('#' + id).css('display', 'block');


	})

});

// TEXT MODALS/LIGHTBOXES

$(document).ready(function(){
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
	});
		