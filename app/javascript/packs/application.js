require("@rails/ujs").start()
require("turbolinks").start()
// require("@rails/activestorage").start()

import Vue from 'vue'
import ArticleForm from '../article_form.vue'

document.addEventListener('turbolinks:load', () => {
  let parts = [
    { elem_id: 'article-form', object: ArticleForm }
  ]

  parts.forEach((part) => {
    let elem = document.getElementById(part.elem_id)
    if(elem) {
      let vue = new Vue(part.object)
      vue.$mount('#' + part.elem_id)
    }
  })
})
