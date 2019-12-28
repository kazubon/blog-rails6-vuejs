<template>
  <div>
    <div class="row" v-if="userName">
      <div class="col-md">
        <h1>{{userName}} さんの記事</h1>
      </div>
      <div class="col-md text-right" v-if="creatable">
        <router-link :to="{ name: 'new_entry' }">新規作成</router-link>
      </div>
    </div>
    <search-form :query="query"></search-form>
    <list :query="query"></list>
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
      state: Store.state.list
    };
  },
  computed: {
    userName() { return this.state.userName; },
    creatable() { return this.state.creatable; }
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
      Store.getEntries(this.$router, this.query);
    }
  }
}
</script>