<template>
  <div>
    <form action="/entries" method="get" class="form-inline mb-4">
      <input type="text" name="q[title]" class="form-control mr-3 mb-2"
        v-model="query.title" placeholder="タイトル">
      <input type="text" name="q[tag]" class="form-control mr-3 mb-2"
        v-model="query.tag" placeholder="タグ">
      <input type="hidden" name="q[sort]" v-model="query.sort">
      <input type="hidden" name="user_id" v-model="userId">
      <button type="submit" class="btn btn-outline-primary mb-2">検索</button>
    </form>
  </div>
</template>

<script>
export default {
  props: ['userId', 'query']
}
</script>
