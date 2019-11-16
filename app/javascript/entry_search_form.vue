<template>
  <div>
    <form :action="path" method="get" class="form-inline mb-4">
      <input type="text" name="title" class="form-control mr-3 mb-2"
        v-model="params.title" placeholder="タイトル">
      <input type="text" name="tag" class="form-control mr-3 mb-2"
        v-model="params.tag" placeholder="タグ">
      <button type="submit" class="btn btn-outline-primary mb-2">検索</button>
    </form>
  </div>
</template>

<script>
import qs from 'qs';

export default {
  props: {
    path: { type: String, required: true }
  },
  data: function () {
    return {
      params: {}
    };
  },
  created () {
    this.params = qs.parse(location.search.slice(1));
  }
}
</script>
