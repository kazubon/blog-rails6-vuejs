<template>
  <div>
    <h1>
      <span v-if="entry.draft">(下書き)</span>{{entry.title}}
    </h1>

    <p class="text-right text-secondary" v-if="entry.id">
      <router-link :to="entry.user_path">{{entry.user_name}}</router-link> |
      <router-link v-for="tag in entry.tags" :key="tag.id" :to="tag.path">
        {{tag.name}}
      </router-link> |
      {{entry.published_at}} |
      <router-link :to="{ name: 'edit_entry', params: { entryId: entry.id }}" v-if="entry.myself">編集</router-link>
    </p>

    <p class="mb-5" v-html="entryBody()"></p>

    <star></star>
  </div>
</template>

<script>
import Store from './store';
import Star from './star';

export default {
  components: { star: Star },
  props: ['entryId'],
  data() {
    return {
      state: Store.state
    };
  },
  computed: {
    entry() {
      return this.state.entry;
    }
  },
  created() {
    Store.clearEntry();
    Store.getEntry(this.$router, this.entryId);
  },
  methods: {
    entryBody() {
      return (this.entry.body ? this.entry.body.replace(/\n/g, '<br>') : null);
    }
  }
}
</script>
