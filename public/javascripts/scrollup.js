$(function() {
  if($("div#opinions").length > 0) {
    setTimeout(updateComments, 5000);
  }
});

function updateComments() {
  //var after = $("li.opinion:first-child").attr("data-time");
  $.getScript("/operator/" + $("div#opinions").attr("data-action") + ".js");
  setTimeout(updateComments, 5000);
}
