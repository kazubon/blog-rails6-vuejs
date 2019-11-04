<template>
  <div>
    <form :action="path" method="get" class="mb-5">
      <div class="form-group text-right">
        <button type="submit" class="btn btn-outline-primary">検索</button>
      </div>
    </form>
    <div class="articles">
      <div v-for="article in articles" :key="article.id" class="article">
        <div><a :href="article.path">{{article.title}}</a></div>
        <div class="text-right text-secondary">
          <a :href="article.user_path">{{article.user_name}}</a> |
          {{article.published_at}}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import qs from 'qs';

export default {
  data: function () {
    return {
      articles: []
    };
  },
  computed: {
    params() {
      return qs.parse(location.search.slice(1));
    },
    path() {
      let pathname = location.pathname;
      return (pathname == '/' ? '/articles.json' :
        location.pathname.replace(/(\.html|$)/, '.json'));
    }
  },
  created () {
    axios.get(this.pathWithParams()).then((res) => {
      this.articles = res.data.articles;
    });
  },
  methods: {
    pathWithParams() {
      return (this.path + '?' + qs.stringify(this.params, { arrayFormat: 'brackets'}));
    }
  }
}
</script>
