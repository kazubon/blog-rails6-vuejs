<template>
  <div class="text-right">
    <big class="d-inline-block p-1 border rounded">
      <a href="#" v-if="starrable" class="mr-1 ml-1 text-decoration-none"
         @click="submit" title="いいね">👍</a>
      <span v-if="count > 0" class="text-warning mr-1 ml-1">⭐️ {{count}}</span>
    </big>
  </div>
</template>

<script>
import Axios from 'axios';

export default {
  props: {
    starCount: { type: Number, default: 0 },
    entryId: { type: Number },
    starrable: { type: Boolean }
  },
  data() {
    return {
      count: 0
    };
  },
  created() {
    this.count = this.starCount;
  },
  methods: {
    submit(evt) {
      evt.preventDefault();
      Axios({
        method: 'patch',
        url: `/entries/${this.entryId}/star.json`
      }).then((res) => {
        this.count = res.data.count;
      });
    }
  }
}
</script>
