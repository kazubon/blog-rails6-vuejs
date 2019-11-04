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
        <label for="article-tag0">タグ</label>
        <div>
          <input v-for="(tag, index) in article.tags" :key="index" v-model="tag.name"
            class="form-control width-auto d-inline-block mr-2" style="width: 17%"
            maxlength="255" >
        </div>
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
import axios from 'axios';
import moment from 'moment';

export default {
  data: function () {
    return {
      article: {
        title: null, body: null, draft: false,
        published_at: moment().format('YYYY-MM-DD HH:mm'),
        tags: []
      },
      articleId: null,
      alert: null,
      errorMessages: []
    };
  },
  created () {
    this.articleId = this.$options.options.articleId;
    if(this.articleId) {
      axios.get(`/articles/${this.articleId}.json`).then((res) => {
        this.article = res.data.article;
        this.initTags();
      });
    }
    else {
      this.initTags();
    }
  },
  methods: {
    submit(evt) {
      evt.preventDefault();
      axios({
        method: (this.articleId ? 'patch' : 'post'),
        url: (this.articleId ? `/articles/${this.articleId}.json` : '/articles.json'),
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
    },
    initTags() {
      let len = this.article.tags.length;
      if(len < 5) {
        for(let i = 0; i < 5 - len; i++) {
          this.article.tags.push({ name: '' });
        }
      }
    }
  }
}
</script>
