$(function(){
  $("h3 a[data-toggle=tab]").click(function() {
    $(this).parent().parent().addClass("active").siblings(".active").removeClass("active");
    let tabContents = $(this).attr("href");
    $(tabContents).addClass("active").siblings(".active").removeClass("active");
    return false;
  });
});