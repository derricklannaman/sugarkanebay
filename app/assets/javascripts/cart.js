// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  $('.cart-listing-wrapper').hide();
  $('li.cart-link').hover(toggleCartView);
});

function toggleCartView() {
  $('.cart-listing-wrapper').toggleClass('visible');
}



