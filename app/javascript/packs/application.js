require("@rails/ujs").start();
require("turbolinks").start();
// require("@rails/activestorage").start();

import Vue from 'vue';
import TurbolinksAdapter from 'vue-turbolinks'
import ArticleSearch from '../article_search.vue';
import ArticleForm from '../article_form.vue';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  let parts = [
    { elem: '#article-search', object: ArticleSearch },
    { elem: '#article-form', object: ArticleForm }
  ];

  parts.forEach((part) => {
    if($(part.elem).length) {
      part.object.options = $(part.elem).data();
      new Vue(part.object).$mount(part.elem);
    }
  });
});
