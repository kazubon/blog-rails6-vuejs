<template>
  <div>
    <h1 v-if="entry.id">記事の編集</h1>
    <h1 v-else>記事の作成</h1>

    <form @submit="submit">
      <div v-if="alert" class="alert alert-danger">{{alert}}</div>
      <div class="form-group">
        <label for="entry-title">タイトル</label>
        <input type="text" v-model="entry.title" id="entry-title"
          class="form-control" required maxlength="255" pattern=".*[^\s]+.*">
      </div>
      <div class="form-group">
        <label for="entry-body">本文</label>
        <textarea v-model="entry.body" id="entry-body" cols="80" rows="15"
          class="form-control" required maxlength="40000">
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
          pattern="\d{4}(-|\/)\d{2}(-|\/)\d{2} +\d{2}:\d{2}">
      </div>
      <div class="form-group mb-4">
        <input type="checkbox" v-model="entry.draft" id="entry-draft" value="1">
        <label for="entry-draft">下書き</label>
      </div>
      <div class="row">
        <div class="col">
          <button type="submit" class="btn btn-outline-primary">{{entry.id ? '更新' : '作成'}}</button>
        </div>
        <div class="col text-right" v-if="entry.id">
          <button type="button" class="btn btn-outline-danger" @click="destroy">削除</button>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import Axios from 'axios';
import Store from './store';
import Flash from '../flash';

export default {
  props: ['entryId'],
  data() {
    return {
      state: Store.state,
      alert: null
    };
  },
  computed: {
    entry() {
      return this.state.entry;
    }
  },
  created() {
    Store.clearEntry();
    Store.getEntry(this.$router, this.entryId).then(() => {
      this.initTags();
    });
  },
  methods: {
    initTags() {
      let len = this.entry.tags.length;
      if(len < 5) {
        for(let i = 0; i < 5 - len; i++) {
          this.entry.tags.push({ name: '' });
        }
      }
    },
    validate() {
      if(!(this.entry.body && this.entry.body.match(/[^\s]+/))) {
        this.alert = '本文を入力してください。';
        window.scrollTo(0, 0);
        return false;
      }
      return true;
    },
    submitPath() {
      let location = this.entry.id ?
        { name: 'entry', params: { entryId: this.entry.id}} :
        { name: 'entries' };
      return this.$router.resolve(location).href;
    },
    submit(evt) {
      evt.preventDefault();
      if(!this.validate()) {
        return;
      }
      Axios({
        method: this.entry.id ? 'patch' : 'post',
        url: this.submitPath(),
        headers: {
          'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content')
        },
        data: { entry: this.entry }
      }).then((res) => {
        Flash.set({ notice: res.data.notice });
        this.$router.push({ path: res.data.location });
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
    destroy() {
      if(!confirm('本当に削除しますか?')) {
        return;
      }
      Axios({
        method: 'delete',
        url: this.submitPath(),
        headers: {
          'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content')
        }
      }).then((res) => {
        Flash.set({ notice: res.data.notice });
        this.$router.push({ path: res.data.location });
      }).catch((error) => {
        this.alert = `${error.response.status} ${error.response.statusText}`;
        window.scrollTo(0, 0);
      });
    }
  }
}
</script>
