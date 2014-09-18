$(document).ready(function() {
  $('[data-toggle=offcanvas]').click(function() {
    $('.row-offcanvas').toggleClass('active');
  });
});

$(function(){

  $('#masonry-container').masonry({
    itemSelector: '.box',
    columnWidth: 100,
    gutterWidth: 40
  });

});