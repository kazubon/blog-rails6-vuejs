export default {
  notice: null,
  alert: null,
  set(options) {
    if(options.notice) { this.notice = options.notice; }
    if(options.alert)  { this.alert = options.alert; }
  },
  show() {
    if(this.notice) {
      var elem = $('<div class="alert alert-primary"></div>').text(this.notice);
      $('#flash').append(elem);
      this.notice = null;
    }
    else {
      $('#flash .alert-primary').remove();
    }
    if(this.alert) {
      var elem = $('<div class="alert alert-danger"></div>').text(this.alert);
      $('#flash').append(elem);
      this.alert = null;
    }
    else {
      $('#flash .alert-danger').remove();
    }
  },
  clear() {
    $('#flash').empty();
  }
}
