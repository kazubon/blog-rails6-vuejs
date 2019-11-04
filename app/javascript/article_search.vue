<template>
  <div>
    <form :action="searchPath" method="get" class="form-inline mb-5">
      <input type="text" name="a[title]" class="form-control mr-3 mb-2"
        v-model="params.title" placeholder="タイトル">
      <input type="text" name="a[tag_name]" class="form-control mr-3 mb-2"
        v-model="params.tag_name" placeholder="タグ">
      <button type="submit" class="btn btn-outline-primary mb-2">検索</button>
    </form>
    <div class="articles">
      <div v-for="article in articles" :key="article.id" class="article">
        <div><a :href="article.path">{{article.title}}</a></div>
        <div class="text-right text-secondary">
          <a :href="article.user_path">{{article.user_name}}</a> |
          <span v-for="tag in article.tags" :key="tag.id" class="mr-2">{{tag.name}}</span> |
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
      let params = qs.parse(location.search.slice(1)) || {};
      return params.a || {};
    },
    searchPath() {
      let path = location.pathname;
      return (path == '/' ? '/articles' : path.replace(/(\.html$)/, ''));
    }
  },
  created () {
    axios.get(this.pathWithParams()).then((res) => {
      this.articles = res.data.articles;
    });
  },
  methods: {
    pathWithParams() {
      let params = {
        a: this.params
      };
      return (this.searchPath + '.json?' + qs.stringify(params, { arrayFormat: 'brackets'}));
    }
  }
}
</script>
