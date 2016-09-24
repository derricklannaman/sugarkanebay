// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('ready page:load', function() {
  $('.immersive-morph-button').click(immersiveMorphing);
  $('button.button.button--trigger').click(reverseImmersiveMorphing);
  // $('.featured-content').hide();
});

  function immersiveMorphing() {
    var button = $(this);
    var landingLayout = button.closest('.landing-layout');
    landingLayout.toggleClass('landing-layout--open');
  }

  function reverseImmersiveMorphing() {
    var button = $(this);
    var openedLayout = button.closest('.landing-layout.landing-layout--open');
    openedLayout.removeClass('landing-layout--open');
  }
