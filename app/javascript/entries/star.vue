<template>
  <div class="text-right">
    <big class="d-inline-block p-1 border rounded">
      <a href="#" v-if="entry.starrable" class="mr-1 ml-1 text-decoration-none"
         @click="submit" title="いいね">👍</a>
      <span v-if="entry.star_count > 0" class="text-warning mr-1 ml-1">⭐️ {{entry.star_count}}</span>
    </big>
  </div>
</template>

<script>
import Axios from 'axios';
import Store from './store';

export default {
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
  methods: {
    submit(evt) {
      evt.preventDefault();

      let location = { name: 'star', params: { entryId: this.entry.id } };
      let path = this.$router.resolve(location).href;
      Axios({
        method: 'patch',
        url: path,
        headers: {
          'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content')
        }
      }).then((res) => {
        Store.state.entry.star_count = res.data.count;
      });
    }
  }
}
</script>
