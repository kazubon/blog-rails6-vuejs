//= require jquery3
//= require popper
//= require bootstrap
//= require_self

function showFlash(options) {
  if(options.notice) {
    var elem = $('<div class="alert alert-primary"></div>').text(options.notice);
    $('#flash').append(elem);
  }
  if(options.alert) {
    var elem = $('<div class="alert alert-danger"></div>').text(options.alert);
    $('#flash').append(elem);
  }
}
function clearFlash(options) {
  $('#flash').empty();
}
