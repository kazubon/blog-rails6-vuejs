<template>
  <div>
    <form :action="path" method="get" class="form-inline mb-4">
      <input type="text" name="q[title]" class="form-control mr-3 mb-2"
        v-model="query.title" placeholder="タイトル">
      <input type="text" name="q[tag]" class="form-control mr-3 mb-2"
        v-model="query.tag" placeholder="タグ">
      <input type="hidden" name="q[sort]" v-model="query.sort">
      <button type="submit" class="btn btn-outline-primary mb-2">検索</button>
    </form>
  </div>
</template>

<script>
export default {
  props: {
    path: { type: String, required: true },
    query: { type: Object }
  }
}
</script>
