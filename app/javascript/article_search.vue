<template>
  <div>
    <form action="/articles" method="get" class="form-inline mb-4">
      <input type="text" name="q[title]" class="form-control mr-3 mb-2"
        v-model="params.title" placeholder="タイトル">
      <input type="text" name="q[tag]" class="form-control mr-3 mb-2"
        v-model="params.tag" placeholder="タグ">
      <button type="submit" class="btn btn-outline-primary mb-2">検索</button>
      <input type="hidden" name="q[user_id]" v-model="params.user_id" />
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
  props: ['railsData'],
  data: function () {
    return {
      params: {
        title: null, tag: null, user_id: null
      },
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
    let userId = this.railsData.userId;
    let tag = this.railsData.tag;
    let params = qs.parse(location.search.slice(1));
    this.params = params.q || { user_id: userId, tag: tag };
    this.getArticles();
  },
  methods: {
    getArticles() {
      let params = { q: this.params };
      if(this.offset > 0) {
        params.offset = this.offset;
      };
      let path = '/articles.json?' + qs.stringify(params, { arrayFormat: 'brackets'});
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
