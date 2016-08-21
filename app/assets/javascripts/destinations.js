// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  // $('#history-immersive, #food-immersive').on('click', immersivePreview);

  $('.immersive-image').click(immersivePreview);

});

function immersivePreview() {
  var image = $(this);
  var current_image = image[0].id
  var all_images = $('.immersive-image');

  if(image.hasClass('immersive-preview')) {

    for (var i = 0; i < all_images.length; i++) {
      if(all_images[i].id != current_image) {
        $(all_images[i]).removeClass('immersives-hide');
      }
    }

    image.addClass('close-immersive-preview');
    image.removeClass('immersive-preview');
    // setTimeout(function() {
    //   image.removeClass('close-immersive-preview');
    // }, 500);
  }
    else {
    image.addClass('immersive-preview');
    image.removeClass('close-immersive-preview');

    for (var i = 0; i < all_images.length; i++) {
      if(all_images[i].id != current_image) {
        $(all_images[i]).addClass('immersives-hide');
      }
    }
  }
}