$(document).on('turbolinks:load', function() {
  manageNavigationColors();
});

function setNavTextWhite() {
  var nav = $('#navigation-logo');
  if ( nav.hasClass('dark-nav-text') ) {
    nav.removeClass('dark-nav-text');
  }
}

function setNavTextDark() {
  $('#navigation-logo').addClass('dark-nav-text');
  $('.navbar-default .navbar-nav > li > a').addClass('dark-nav-text');
}

function manageNavigationColors() {
  if (document.location.pathname == '/') {
    setNavTextWhite();
  }
  else {
    setNavTextDark();
  }
}



