$(function() {
  $("div#my_opinion form").submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  });

  if($("ul#opinions").length > 0) {
    setTimeout(updateComments, 10000);
  }
});

function updateComments() {
  var after = $("li.opinion:first-child").attr("data-time");
  $.getScript("/operator/" + $("ul").attr("data-action") + ".js?after=" + after);
  setTimeout(updateComments, 10000);
}
