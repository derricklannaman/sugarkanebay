// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  $('.cart-listing-wrapper').hide();
  $('li.cart-link').hover(toggleCartView);
});

function toggleCartView() {
  loadCartItems();
  $('.cart-listing-wrapper').toggleClass('visible');
}

function loadCartItems() {
  var cartContainer = $('.cart-listing-wrapper');
  if(cartContainer[0].innerText.length > 0) {
    return
  }
  else {
    var link = $('li.cart-link > a');
    var link_parts = link[0].href.split('/')
    var cart_id = link_parts[link_parts.length -1]
    $.ajax({
      url: "load_cart/" + cart_id,
      data: cart_id,
      success: function(data) {
        for(var i = 0; i < data.length; i++) {
          var item = "<div class='cart-item-view'>"+data[i].name+"</div>"
          cartContainer.prepend(item)
        }
      }
    });
  }
} // End loadCartItems


