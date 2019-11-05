require("@rails/ujs").start();
require("turbolinks").start();
// require("@rails/activestorage").start();

import Vue from 'vue';
import TurbolinksAdapter from 'vue-turbolinks'
import ArticleSearch from '../article_search.vue';
import ArticleForm from '../article_form.vue';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  let apps = [
    { elem: '#article-search', object: ArticleSearch },
    { elem: '#article-form', object: ArticleForm }
  ];

  apps.forEach((app) => {
    if($(app.elem).length) {
      let railsData = $(app.elem).data();
      new Vue({ ...app.object, propsData: { railsData } }).$mount(app.elem);
    }
  });
});
