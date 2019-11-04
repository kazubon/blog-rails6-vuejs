<template>
  <div>
    <form :action="searchPath" method="get" class="form-inline mb-4">
      <input type="text" name="a[title]" class="form-control mr-3 mb-2"
        v-model="params.title" placeholder="タイトル">
      <input type="text" name="a[tag_name]" class="form-control mr-3 mb-2"
        v-model="params.tag_name" placeholder="タグ">
      <button type="submit" class="btn btn-outline-primary mb-2">検索</button>
    </form>
    <div class="articles mb-4">
      <div class="text-right mb-3">{{articlesCount}}件の記事</div>
      <div v-for="article in articles" :key="article.id" class="article">
        <div><a :href="article.path">{{article.title}}</a></div>
        <div class="text-right text-secondary">
          <a :href="article.user_path">{{article.user_name}}</a> |
          <span v-for="tag in article.tags" :key="tag.id" class="mr-2">{{tag.name}}</span> |
          {{article.published_at}}
        </div>
      </div>
    </div>
    <div v-if="showMore">
      <button type="button" @click="moreClicked" class="btn btn-outline-secondary w-100">もっと見る</button>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import qs from 'qs';

export default {
  data: function () {
    return {
      params: {},
      articles: [],
      articlesCount: 0,
      offset: 0
    };
  },
  computed: {
    searchPath() {
      let path = location.pathname;
      return (path == '/' ? '/articles' : path.replace(/(\.html$)/, ''));
    },
    showMore() {
      return (this.articles.length < this.articlesCount);
    }
  },
  created () {
    let params = qs.parse(location.search.slice(1));
    this.params = params.a || {};
    this.getArticles();
  },
  methods: {
    getArticles() {
      let params = { a: this.params };
      if(this.offset > 0) {
        params.a.offset = this.offset
      };
      let path = this.searchPath + '.json?' +
        qs.stringify(params, { arrayFormat: 'brackets'});
      axios.get(path).then((res) => {
        res.data.articles.forEach(a => this.articles.push(a));
        this.articlesCount = res.data.articles_count;
      });
    },
    moreClicked() {
      this.offset += 20;
      this.getArticles();
    }
  }
}
</script>
