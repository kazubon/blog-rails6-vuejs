<template>
  <div>
    <search-form :query="query"></search-form>
    <list :query="query"></list>
  </div>
</template>

<script>
import Form from './search_form';
import List from './list';

export default {
  props: ['query'],
  components: { 'search-form': Form, 'list': List }
}
</script>