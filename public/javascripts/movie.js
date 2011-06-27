$(function() {
  $("div#opinions").prepend("<div class='welcome' style='margin-bottom: 400px'><h1>Welcome!</h1>bla...bla...bla...</div>")

  if($("div#opinions").length > 0) {
    setTimeout(deleteWelcome, 4999);
    setTimeout(updateComments, 5000);

    var latitude = $("div#map").attr("data-latitude")
    var longitude = $("div#map").attr("data-longitude")
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
  setTimeout(movieSlide, 40000);
}
function movieSlide(){
  if($("div#opinions").children("div.movie").length == 1){
    updateComments();
  } else {
    setTimeout(movieSlide, 1000);
  }
}

function mapUrl(latitude,longitude) {
  var params = {
    size   : "400x130",
    maptype: "roadmap",
    sensor : "false",
    center : latitude +","+ longitude,
    zoom   : 12,
    style  : "feature:all|element:all|saturation:-100",
    markers: "color:0xEE127B|"+latitude+","+longitude
  }
  return "http://maps.google.com/maps/api/staticmap?" + $.param(params);
}
