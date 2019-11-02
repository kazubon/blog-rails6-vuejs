<template>
  <div>
    <form @submit="submit">
      <div v-if="alert" class="alert alert-danger">
        {{alert}}
        <ul class="mb-0">
          <li v-for="(error, index) in errorMessages" :key="index">{{error}}</li>
        </ul>
      </div>
      <div class="form-group">
        <label for="article-title">タイトル</label>
        <input type="text" v-model="article.title" id="article-title"
          class="form-control" required maxlength="255">
      </div>
      <div class="form-group">
        <label for="article-body">本文</label>
        <textarea v-model="article.body" id="article-body"
          class="form-control" cols="80" rows="15" required>
        </textarea>
      </div>
      <div class="form-group">
        <label for="article-published_at">日時</label>
        <input type="text" v-model="article.published_at" id="article-published_at"
          class="form-control"
          pattern="^\d{4}(-|\/)\d{2}(-|\/)\d{2} +\d{2}:\d{2}$">
      </div>
      <div class="form-group mb-4">
        <input type="checkbox" v-model="article.draft" id="article-draft" value="1">
        <label for="article-draft">下書き</label>
      </div>
      <button type="submit" class="btn btn-outline-primary">{{article.id ? '更新' : '作成'}}</button>
    </form>
  </div>
</template>

<script>
const axios = require('axios');

export default {
  data: function () {
    return {
      article: {},
      httpMethod: 'post',
      path: '/articles',
      alert: null,
      errorMessages: []
    };
  },
  created () {
    axios.get(location.href, {
      headers: { 'Accept' : 'application/json' }
    }).then((res) => {
      this.article = res.data.article
      this.httpMethod = res.data.http_method
      this.path = res.data.path
    });
  },
  methods: {
    submit(evt) {
      evt.preventDefault();
      axios({
        method: this.httpMethod,
        url: this.path,
        headers: { 'Content-type' : 'application/json; charset=utf-8' },
        data: {
          article: this.article,
          authenticity_token: $('meta[name="csrf-token"]').attr('content')
        }
      }).then((res) => {
        location.href = res.data.location;
      }).catch((error) => {
        if(error.response.status == 422) {
          this.alert = error.response.data.alert;
          this.errorMessages = error.response.data.errors;
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
