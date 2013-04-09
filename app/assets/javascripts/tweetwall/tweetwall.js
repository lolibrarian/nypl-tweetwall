$(function(){
  var container = $('.content-items');

  container.imagesLoaded(function(){
    container.masonry({
      itemSelector : '.content-item',
      columnWidth : 40
    });
  });
});

