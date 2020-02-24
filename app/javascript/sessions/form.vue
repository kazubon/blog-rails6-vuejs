<script>
import axios from 'axios';

export default {
  data() {
    return {
      user: { email: null, password: null },
      alert: null
    }
  },
  methods: {
    submit(evt) {
      evt.preventDefault();
      axios({
        method: 'post',
        url: '/session.json',
        data: { user: this.user }
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
    }
  }
}
</script>
