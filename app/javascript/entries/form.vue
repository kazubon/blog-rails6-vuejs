<template>
  <div>
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
            :id="`entry-tag${index}`"
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
          <button type="submit" class="btn btn-outline-primary">{{entryId ? '更新' : '作成'}}</button>
        </div>
        <div class="col text-right" v-if="entryId">
          <button type="button" class="btn btn-outline-danger" @click="destroy">削除</button>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import Axios from 'axios';
import Flash from '../flash';

export default {
  props: ['entryId'],
  data() {
    return {
      entry: {},
      alert: null
    };
  },
  created() {
    let path = this.entryId ? `/entries/${this.entryId}/edit` : '/entries/new';
    Axios.get(path + '.json').then((res) => {
      this.entry = res.data.entry;
      this.entry.tags = this.fillTags(this.entry.tags);
    });
  },
  methods: {
    fillTags(srcTags) {
      let tags = [];
      for(let i = 0; i < 5; i++) {
        tags.push(srcTags[i] || { name: '' })
      }
      return tags;
    },
    validate() {
      if(!(this.entry.body && this.entry.body.match(/[^\s]+/))) {
        this.alert = '本文を入力してください。';
        window.scrollTo(0, 0);
        return false;
      }
      return true;
    },
    submit(evt) {
      evt.preventDefault();
      if(!this.validate()) {
        return;
      }
      let path = this.entryId ? `/entries/${this.entryId}` : '/entries';
      Axios({
        method: this.entryId ? 'patch' : 'post',
        url: path + '.json',
        data: { entry: this.entry }
      }).then((res) => {
        Flash.set({ notice: res.data.notice });
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
    destroy() {
      if(!confirm('本当に削除しますか?')) {
        return;
      }
      let path = this.entryId ? `/entries/${this.entryId}` : '/entries';
      Axios({
        method: 'delete',
        url: path + '.json'
      }).then((res) => {
        Flash.set({ notice: res.data.notice });
        Turbolinks.visit(res.data.location);
      }).catch((error) => {
        this.alert = `${error.response.status} ${error.response.statusText}`;
        window.scrollTo(0, 0);
      });
    }
  }
}
</script>
