require("@rails/ujs").start();
require("turbolinks").start();
// require("@rails/activestorage").start();

import Vue from 'vue';
import ArticleSearch from '../article_search.vue';
import ArticleForm from '../article_form.vue';

document.addEventListener('turbolinks:load', () => {
  let parts = [
    { elem: '#article-search', object: ArticleSearch },
    { elem: '#article-form', object: ArticleForm }
  ];

  parts.forEach((part) => {
    if($(part.elem).length) {
      new Vue(part.object).$mount(part.elem);
    }
  });
});
