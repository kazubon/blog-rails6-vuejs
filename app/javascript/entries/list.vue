<template>
  <div>
    <div class="text-right mb-3">
      {{entriesCount}}件 | 
      <a :href="sortPath('date')" v-if="query.sort == 'stars'">日付順</a>
      <template v-else>日付順</template>
      | <a :href="sortPath('stars')" v-if="query.sort != 'stars'">いいね順</a>
      <template v-else>いいね順</template>
    </div>
    <div class="entries mb-4">
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
          {{entry.published_at}} |
          <span class="text-warning" v-if="entry.stars_count > 0">★{{entry.stars_count}}</span>
        </div>
      </div>
    </div>
    <div v-if="showMore">
      <button type="button" @click="moreClicked" class="btn btn-outline-secondary w-100">もっと見る</button>
    </div>
  </div>
</template>

<script>
import Axios from 'axios';
import qs from 'qs';

export default {
  props: ['query'],
  data: function () {
    return {
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
    this.getEntries();
  },
  methods: {
    getEntries() {
      let params = { ...this.query, offset: this.offset };
      let path = '/entries.json?' + qs.stringify(params);
      Axios.get(path).then((res) => {
        this.entries = this.entries.concat(res.data.entries);
        this.entriesCount = res.data.entries_count;
      });
    },
    moreClicked() {
      this.offset += 20;
      this.getEntries();
    },
    sortPath(key) {
      let params = { ...this.query, sort: key };
      return '/entries?' + qs.stringify(params);
    }
  }
}
</script>
