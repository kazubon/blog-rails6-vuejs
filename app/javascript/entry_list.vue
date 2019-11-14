<template>
  <div>
    <form :action="path" method="get" class="form-inline mb-4">
      <input type="text" name="title" class="form-control mr-3 mb-2"
        v-model="params.title" placeholder="タイトル">
      <input type="text" name="tag" class="form-control mr-3 mb-2"
        v-model="params.tag" placeholder="タグ">
      <button type="submit" class="btn btn-outline-primary mb-2">検索</button>
    </form>
    <div class="entries mb-4">
      <div class="text-right mb-3">{{entriesCount}}件</div>
      <div v-for="entry in entries" :key="entry.id" class="entry">
        <div>
          <a :href="entry.path">
            <template v-if="entry.draft">（下書き） </template>
            {{entry.title}}
          </a>
        </div>
        <div class="text-right text-secondary">
          <a :href="entry.user_path">{{entry.user_name}}</a> |
          <a v-for="tag in entry.tags" :key="tag.id" class="mr-2"
              :href="tag.tag_path">{{tag.name}}</a> |
          {{entry.published_at}}
        </div>
      </div>
    </div>
    <div v-if="showMore">
      <button type="button" @click="moreClicked" class="btn btn-outline-secondary w-100">もっと見る</button>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import qs from 'qs';

export default {
  props: ['path'],
  data: function () {
    return {
      params: {},
      entries: [],
      entriesCount: 0,
      offset: 0
    };
  },
  computed: {
    showMore() {
      return (this.entries.length < this.entriesCount);
    }
  },
  created () {
    this.params = qs.parse(location.search.slice(1));
    this.getEntries();
  },
  methods: {
    getEntries() {
      if(!this.path) {
        return;
      }
      let params = { ...this.params, offset: this.offset };
      let path = this.path + '.json?' + qs.stringify(params);
      axios.get(path).then((res) => {
        this.entries = this.entries.concat(res.data.entries);
        this.entriesCount = res.data.entries_count;
      });
    },
    moreClicked() {
      this.offset += 20;
      this.getEntries();
    }
  }
}
</script>
