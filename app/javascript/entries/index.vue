<template>
  <div>
    <search-form :userId="userId" :query="query"></search-form>
    <list :userId="userId" :query="query"></list>
  </div>
</template>

<script>
import Form from './search_form';
import List from './list';

export default {
  props: ['userId', 'query'],
  components: { 'search-form': Form, 'list': List }
}
</script>