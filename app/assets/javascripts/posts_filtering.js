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

  function showAll(listLinks, searchMatch){
    listLinks.each(function (index, element){
      $(element).show();
    });
  }

  $('#filter-title').click(function(){
    var filterBy = $('#post_title').val()
    var $listLinks = $('.all-posts .POSTS')
    var searchMatch = new RegExp(filterBy, "i")
    if($(this).val()==='Filter by Title'){
      showBySearchTerm($listLinks, searchMatch);
      $(this).val('Show All');
    }else{
      showAll($listLinks, searchMatch);
      $(this).val('Filter by Title');
    }
  });

  $('#filter-author').click(function(){
    var filteredBy = $('#author_name').val()
    var $listedLinks = $('.all-posts .POSTS')
    var searchedMatch = new RegExp(filteredBy, "i")
    if($(this).val()==='Filter by Author'){
      showBySearchTerm($listedLinks, searchedMatch);
      $(this).val('Show All');
    }else{
      showAll($listedLinks, searchedMatch);
      $(this).val('Filter by Author');
    }
  });
});
