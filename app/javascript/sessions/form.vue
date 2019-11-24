<template>
  <div>
    <form @submit="submit">
      <div v-if="alert" class="alert alert-danger">{{alert}}</div>
      <div class="form-group">
        <label for="email">メールアドレス</label>
        <input type="email" id="email" class="form-control" v-model="email" required>
      </div>
      <div class="form-group mb-5">
        <label for="password">パスワード</label>
        <input type="password" id="password" class="form-control" v-model="password" required>
      </div>
      <button type="submit" class="btn btn-outline-primary">ログイン</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  props: {
    submitPath: { type: String, required: true }
  },
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
        url: this.submitPath + '.json',
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
    }
  }
}
</script>