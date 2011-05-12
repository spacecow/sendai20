$(function() {
  $("div#my_opinion form").submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  });

  if($("div#opinions").length > 0) {
    setTimeout(updateComments, 1000);
  }
});

function updateComments() {
  //var after = $("li.opinion:first-child").attr("data-time");
  $.getScript("/operator/" + $("div#opinions").attr("data-action") + ".js");
  setTimeout(updateComments, 10000);
}
