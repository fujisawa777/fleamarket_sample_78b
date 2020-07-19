$(function(){
  let url = window.location.pathname;
  $('li a[href="'+url+'"]').addClass('active');
  $('li a[href="'+url+'"] .icon-arrow-right').addClass('active');
});