$(document).ready(function(){

	var ww = $(window).width();

	concealNav(ww);

});

$(window).on('resize', function(){

	var ww = $(window).width();

	concealNav(ww);

});

function concealNav(ww) {

	var footerNav = $('.footer-collapse');
	var footerExpand = document.getElementById('footer-expand');
	var expand = document.getElementsByClassName('btnicon')[0];

	if (ww < 600) {

		footerNav.css('display', 'none');
		footerExpand.setAttribute('aria-expanded', 'false');
		expand.innerHTML = '+';

		footerExpand.addEventListener('touchstart', pressEvent);
		footerExpand.addEventListener('click', pressEvent);

	} else {

		var footerCollapse = document.getElementsByClassName('footer-collapse');
		var i;

		for (i = 0; i < footerCollapse.length; i++){
			footerCollapse[i].removeAttribute('style');
		}
		
		footerExpand.removeAttribute('aria-expanded');
	}
}

function pressEvent(evt) {
	var footerNav = $('.footer-collapse');
	var footerExpand = document.getElementById('footer-expand');
	var expand = document.getElementsByClassName('btnicon')[0];

	evt.preventDefault();

	if ( this.getAttribute('aria-expanded') === 'true' ){
		//is open
		footerNav.css('display', 'none');
		footerExpand.setAttribute('aria-expanded', 'false');
		expand.innerHTML = '+';
	} else {
		//is closed
		footerNav.css('display', 'block');
		footerExpand.setAttribute('aria-expanded', 'true');
		expand.innerHTML = '-';
	}
}