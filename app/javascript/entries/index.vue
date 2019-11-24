<template>
  <div>
    <search-form :path="path" :query="query"></search-form>
    <list :path="path" :query="query"></list>
  </div>
</template>

<script>
import Form from './search_form';
import List from './list';
import qs from 'qs';

export default {
  props: {
    path: { type: String, required: true }
  },
  components: { 'search-form': Form, 'list': List },
  created() {
    let params = qs.parse(location.search.slice(1));
    this.query = params.q || {};
  }
}
</script>