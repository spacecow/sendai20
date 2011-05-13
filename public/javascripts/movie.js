$(function() {
  $("div#opinions").prepend("<div class='welcome' style='margin-bottom: 400px'><h1>Welcome!</h1>bla...bla...bla...</div>")

  if($("div#opinions").length > 0) {
    setTimeout(deleteWelcome, 4999);
    setTimeout(updateComments, 5000);
  }
});

function deleteWelcome(){
  $("div#opinions").css("top", 450)
  $("div.welcome").remove();
}
function updateComments() {
  //var after = $("li.opinion:first-child").attr("data-time");
  if($("div#opinions").children("div.movie").length == 1){
    $.getScript("/operator/" + $("div#opinions").attr("data-action") + ".js");
  }
  setTimeout(updateComments, 1000);
}
