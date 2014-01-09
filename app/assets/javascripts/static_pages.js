$(document).ready(function() {
  $('.cropper').hover(
    function(){
      $(this).find('.caption').fadeIn();
    },
    function(){
      $(this).find('.caption').fadeOut();
    }
  );
});
