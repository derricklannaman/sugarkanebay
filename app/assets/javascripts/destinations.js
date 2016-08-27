// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('ready page:load', function() {
  $('.landing-header__tagline').click(immersiveMorphing);
  $('button.button.button--trigger').click(reverseImmersiveMorphing);
  // $('.featured-content').hide();
});

  function immersiveMorphing() {
    var landingLayout = $('.landing-layout');
    landingLayout.toggleClass('landing-layout--open');
    // $('.featured-content').hide();
  }

  function reverseImmersiveMorphing() {
    var openedLayout = $('.landing-layout.landing-layout--open');
    openedLayout.removeClass('landing-layout--open');
    // $('.featured-content').show();
  }
