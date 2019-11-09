<template>
  <div>
    <form :action="path" method="get" class="form-inline mb-4">
      <input type="text" name="q[title]" class="form-control mr-3 mb-2"
        v-model="params.title" placeholder="タイトル">
      <input type="text" name="q[tag]" class="form-control mr-3 mb-2"
        v-model="params.tag" placeholder="タグ">
      <button type="submit" class="btn btn-outline-primary mb-2">検索</button>
    </form>
    <div class="articles mb-4">
      <div class="text-right mb-3">{{articlesCount}}件</div>
      <div v-for="article in articles" :key="article.id" class="article">
        <div><a :href="article.path">{{article.title}}</a></div>
        <div class="text-right text-secondary">
          <a :href="article.user_path">{{article.user_name}}</a> |
          <a v-for="tag in article.tags" :key="tag.id" class="mr-2"
              :href="tag.tag_path">{{tag.name}}</a> |
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
  props: ['path'],
  data: function () {
    return {
      params: {},
      articles: [],
      articlesCount: 0,
      offset: 0
    };
  },
  computed: {
    showMore() {
      return (this.articles.length < this.articlesCount);
    }
  },
  created () {
    let params = qs.parse(location.search.slice(1));
    this.params = params.q || {};
    this.getArticles();
  },
  methods: {
    getArticles() {
      if(!this.path) {
        return;
      }
      let params = { q: this.params };
      if(this.offset > 0) {
        params.offset = this.offset;
      };
      let path = this.path + '.json?' + qs.stringify(params);
      axios.get(path).then((res) => {
        this.articles = this.articles.concat(res.data.articles);
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
