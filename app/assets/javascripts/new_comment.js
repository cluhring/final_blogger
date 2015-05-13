jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function(){
  $("#new_comment").submit(function() {
    $.post($(this).attr("action"), $(this).serialize(), null, "script");
    return false;
  });
});


// jQuery.ajaxSetup({
//   'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
// })
//
// jQuery.fn.submitWithAjax = function() {
//   this.submit(function() {
//     $.post(this.action, $(this).serialize(), null, "script");
//     return false;
//   })
//   return this;
// };
//
// $(document).ready(function() {
//   $("#new_comment").submitWithAjax();
// })
