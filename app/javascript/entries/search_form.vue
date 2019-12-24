<template>
  <div>
    <form action="/entries" method="get" class="form-inline mb-4" @submit="submit">
      <input type="text" name="title" class="form-control mr-3 mb-2"
        v-model="title" placeholder="タイトル">
      <input type="text" name="tag" class="form-control mr-3 mb-2"
        v-model="tag" placeholder="タグ">
      <input type="hidden" name="sort" v-model="query.sort">
      <input type="hidden" name="user_id" v-model="query.user_id">
      <button type="submit" class="btn btn-outline-primary mb-2">検索</button>
    </form>
  </div>
</template>

<script>
export default {
  props: ['query'],
  data() {
    return {
      title: this.query.title,
      tag: this.query.tag
    };
  },
  methods: {
    submit(evt) {
      evt.preventDefault();
      let query = { ...this.query, title: this.title, tag: this.tag };
      this.$router.push({ name: 'entries', query });
    }
  }
}
</script>
