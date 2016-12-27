// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  $('.cart-listing-wrapper').hide();
  $('li.cart-link').hover(toggleCartView);
});

function toggleCartView() {
  var badgeCount = $('.badge > .count')[0].innerText
  if(badgeCount != '0') {
    loadCartItems();
    $('.cart-listing-wrapper').toggleClass('visible');
  }
}

function loadCartItems() {
  var cartContainer = $('.cart-listing-wrapper');
  if(cartContainer[0].innerText.length > 0) {
    return
  }
  else {
    var link = $('li.cart-link > a'),
        link_parts = link[0].href.split('/'),
        cart_id = link_parts[link_parts.length -1];

    $.ajax({
      url: "load_cart/" + cart_id,
      data: cart_id,
      success: function(data) {
        for(var i = 0; i < data.length; i++) {
          buildCartListItem(data, cartContainer, i);
        }
      }
    });
  }
} // End loadCartItems

function buildCartListItem(data, cartContainer, i) {
  var item = "<div class='flex-item cart-item-view'>"
  item += "<div class='cart-item-title'>"
  item += data[i].name
  item += "<div class='badge for-cart pull-right'>"
  item += data[i].quantity
  item += "</div>"
  item += "</div>"
  item += "</div>"
  cartContainer.prepend(item)
}

