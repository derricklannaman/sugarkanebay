$(document).on('turbolinks:load', function() {
  manageNavigationColors();


$('.form').find('input, textarea').on('keyup blur focus', function (e) {

  var $this = $(this),
      label = $this.prev('label');

    if (e.type === 'keyup') {
      if ($this.val() === '') {
          label.removeClass('active highlight');
        } else {
          label.addClass('active highlight');
        }
    } else if (e.type === 'blur') {
      if( $this.val() === '' ) {
        label.removeClass('active highlight');
      } else {
        label.removeClass('highlight');
      }
    } else if (e.type === 'focus') {

      if( $this.val() === '' ) {
        label.removeClass('highlight');
      }
      else if( $this.val() !== '' ) {
        label.addClass('highlight');
      }
    }

});

$('.tab a').on('click', function (e) {

  e.preventDefault();

  $(this).parent().addClass('active');
  $(this).parent().siblings().removeClass('active');

  target = $(this).attr('href');

  $('.tab-content > div').not(target).hide();

  $(target).fadeIn(300);

});


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
  $('.checkout__icon').addClass('fill-dark');
}


function manageNavigationColors() {
  if (document.location.pathname == '/') {
    setNavTextWhite();
  }
  else {
    setNavTextDark();
  }
}



