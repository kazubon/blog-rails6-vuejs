<template>
  <div class="text-right">
    <big class="d-inline-block p-1 border rounded">
      <a href="#" v-if="submitPath" class="mr-1 ml-1 text-decoration-none"
         @click="submit" title="いいね">👍</a>
      <span v-if="starCount > 0" class="text-warning mr-1 ml-1">⭐️ {{starCount}}</span>
    </big>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  props: {
    count: { type: Number, default: 0 },
    submitPath: { type: String }
  },
  data() {
    return {
      starCount: 0
    };
  },
  created() {
    this.starCount = this.count;
  },
  methods: {
    submit(evt) {
      evt.preventDefault();
      axios({
        method: 'patch',
        url: this.submitPath + '.json',
        headers: {
          'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content')
        }
      }).then((res) => {
        this.starCount = res.data.count;
      });
    }
  }
}
</script>
