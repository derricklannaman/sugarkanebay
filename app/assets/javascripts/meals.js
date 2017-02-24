$(document).on('turbolinks:load', function() {
  $('.order-bar-learn-more').on('click', showMealStory);
  $('.close-x').click(closeX);
});

function showMealStory() {
  var mealInfo = $(".learn-about-meal");
  if (mealInfo.hasClass('meal-info-open')) {
    $(".learn-about-meal").removeClass('meal-info-open');
    $(".learn-about-meal").animate({left: '110%'}, 250);
  }
  else {
    $(".learn-about-meal").attr('style','')
   $(".learn-about-meal").addClass('meal-info-open').animate({left: '52%'}, 250);
  }

}

function closeX() {
  $(".learn-about-meal").attr('style','').removeClass('meal-info-open');
}
