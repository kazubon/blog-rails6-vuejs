export default {
  notice: null,
  alert: null,
  set(options) {
    if(options.notice) { this.notice = options.notice; }
    if(options.alert)  { this.alert = options.alert; }
  },
  show() {
    if(this.notice === '') {
      $('#flash .alert-primary').remove();
    }
    else if(this.notice) {
      var elem = $('<div class="alert alert-primary"></div>').text(this.notice);
      $('#flash').append(elem);
      this.notice = '';
    }
    if(this.alert === '') {
      $('#flash .alert-danger').remove();
    }
    else if(this.alert) {
      var elem = $('<div class="alert alert-danger"></div>').text(this.alert);
      $('#flash').append(elem);
      this.alert = '';
    }
  },
  clear() {
    $('#flash').empty();
  }
}
