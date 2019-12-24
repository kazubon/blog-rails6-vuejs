<template>
  <div>
    <template v-if="error">
      <div v-if="error.response">{{error.response.status}} {{error.response.statusText}}</div>
    </template>
    <template v-else>
      <div class="row" v-if="userName">
        <div class="col-md">
          <h1>{{userName}} さんの記事</h1>
        </div>
        <div class="col-md text-right" v-if="myself">
          <router-link :to="{ name: 'new_entry' }">新規作成</router-link>
        </div>
      </div>
      <search-form :query="query"></search-form>
      <list :query="query"></list>
    </template>
  </div>
</template>

<script>
import Form from './search_form';
import List from './list';
import Store from './store';

export default {
  components: { 'search-form': Form, 'list': List },
  props: ['userId'],
  data() {
    return {
      query: {},
      state: Store.state,
      error: null
    };
  },
  computed: {
    userName() { return this.state.userName; },
    myself() { return this.state.myself; }
  },
  watch: {
    $route(to, from) {
      this.getEntries();
    }
  },
  created() {
    this.getEntries();
  },
  methods: {
    getEntries() {
      this.query = { ...this.$route.query };
      if(this.userId) { this.query.user_id = this.userId; };
      Store.clearEntries();
      Store.getEntries(this.$router, this.query).catch(error => {
        this.error = error;
      });
    }
  }
}
</script>