$(function() {
  $("div#my_opinion form").submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  });
});
