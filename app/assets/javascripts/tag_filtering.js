$(document).ready(function(){

  function showBySearchTerm(listLinks, searchMatch){
    listLinks.each(function (index, element){
      if($(element).text().match(searchMatch)) {
        $(element).show();
      } else {
        $(element).hide();
      }
    });
  }

  $('.category-btn').click(function(){
    var filteringBy = $(this).attr('id')
    var $listingLinks = $('.all-posts .POSTS')
    var searchingMatch = new RegExp(filteringBy, "i")
    showBySearchTerm($listingLinks, searchingMatch);
  });

  $("#show-all").click(function(){
    $('.all-posts .POSTS').show()
    debugger;
  });
});
