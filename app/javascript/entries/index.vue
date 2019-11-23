<template>
  <div>
    <search-form :path="path" :query="query"></search-form>
    <list :path="path" :query="query"></list>
  </div>
</template>

<script>
import Form from './search_form';
import List from './list';

export default {
  props: {
    path: { type: String, required: true },
    query: { type: Object }
  },
  components: { 'search-form': Form, 'list': List }
}
</script>