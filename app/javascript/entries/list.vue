<template>
  <div>
    <div class="text-right mb-3">
      {{entriesCount}}件 | 
      <router-link :to="sortPath('date')" v-if="query.sort == 'stars'">日付順</router-link>
      <template v-else>日付順</template>
      | <router-link :to="sortPath('stars')" v-if="query.sort != 'stars'">いいね順</router-link>
      <template v-else>いいね順</template>
    </div>
    <div class="entries mb-4">
      <div v-for="entry in entries" :key="entry.id" class="entry">
        <div>
          <router-link :to="{ name: 'entry', params: { entryId: entry.id }}">
            <template v-if="entry.draft">（下書き） </template>
            {{entry.title}}
          </router-link>
        </div>
        <div class="text-right text-secondary">
          <router-link :to="entry.user_path">{{entry.user_name}}</router-link> |
          <router-link v-for="tag in entry.tags" :key="tag.id" class="mr-1 ml-1"
              :to="tag.tag_path">{{tag.name}}</router-link> |
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
import Store from './store';

export default {
  props: ['query'],
  data() {
    return {
      state: Store.state.list,
      offset: 0
    };
  },
  computed: {
    entries() {
      return this.state.entries;
    },
    entriesCount() {
      return this.state.entriesCount;
    },
    showMore() {
      return (this.entries.length < this.entriesCount);
    }
  },
  watch: {
    $route(to, from) {
      this.offset = 0;
    }
  },
  methods: {
    moreClicked() {
      this.offset += 20;
      let query = { ...this.query, offset: this.offset };
      Store.getEntries(this.$router, query);
    },
    sortPath(key) {
      let query = { ...this.query, sort: key };
      return { name: 'entries', query };
    }
  }
}
</script>
