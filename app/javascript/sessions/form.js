import axios from 'axios';

export default {
  el: '#session-form',
  data() {
    return {
      email: null,
      password: null,
      alert: null
    }
  },
  methods: {
    submit(evt) {
      evt.preventDefault();
      axios({
        method: 'post',
        url: this.submitPath() + '.json',
        headers: {
          'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content')
        },
        data: { user: { email: this.email, password: this.password } }
      }).then((res) => {
        Turbolinks.visit(res.data.location);
      }).catch((error) => {
        if(error.response.status == 422) {
          this.alert = error.response.data.alert;
        }
        else {
          this.alert = `${error.response.status} ${error.response.statusText}`;
        }
        window.scrollTo(0, 0);
      });
    },
    submitPath() {
      return $(this.$el).find('form').attr('action');
    }
  }
}
