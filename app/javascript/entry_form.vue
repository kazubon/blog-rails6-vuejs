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
        <label for="entry-title">タイトル</label>
        <input type="text" v-model="entry.title" id="entry-title"
          class="form-control" required maxlength="255">
      </div>
      <div class="form-group">
        <label for="entry-body">本文</label>
        <textarea v-model="entry.body" id="entry-body"
          class="form-control" cols="80" rows="15" required>
        </textarea>
      </div>
      <div class="form-group">
        <label for="entry-tag0">タグ</label>
        <div>
          <input v-for="(tag, index) in entry.tags" :key="index" v-model="tag.name"
            class="form-control width-auto d-inline-block mr-2" style="width: 17%"
            maxlength="255" >
        </div>
      </div>
      <div class="form-group">
        <label for="entry-published_at">日時</label>
        <input type="text" v-model="entry.published_at" id="entry-published_at"
          class="form-control"
          pattern="^\d{4}(-|\/)\d{2}(-|\/)\d{2} +\d{2}:\d{2}$">
      </div>
      <div class="form-group mb-4">
        <input type="checkbox" v-model="entry.draft" id="entry-draft" value="1">
        <label for="entry-draft">下書き</label>
      </div>
      <button type="submit" class="btn btn-outline-primary">{{newRecord ? '作成' : '更新'}}</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import moment from 'moment';

export default {
  props: ['path'], 
  data: function () {
    return {
      entry: {
        title: null, body: null, draft: false,
        published_at: moment().format('YYYY-MM-DD HH:mm'),
        tags: []
      },
      newRecord: true,
      submitPath: null,
      alert: null,
      errorMessages: []
    };
  },
  created () {
    axios.get(this.path + '.json').then((res) => {
      this.entry = res.data.entry;
      this.newRecord = res.data.newRecord;
      this.submitPath = res.data.submitPath;
      this.initTags();
    });
  },
  methods: {
    submit(evt) {
      evt.preventDefault();
      axios({
        method: this.newRecord ? 'post' : 'patch',
        url: this.submitPath + '.json',
        headers: { 'Content-type' : 'application/json; charset=utf-8' },
        data: {
          entry: this.entry,
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
      let len = this.entry.tags.length;
      if(len < 5) {
        for(let i = 0; i < 5 - len; i++) {
          this.entry.tags.push({ name: '' });
        }
      }
    }
  }
}
</script>
