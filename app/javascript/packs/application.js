require("@rails/ujs").start();
require("turbolinks").start();

import 'core-js';
import Vue from 'vue';
import TurbolinksAdapter from 'vue-turbolinks'

import EntryIndex from '../entries/index.vue';
import EntryForm from '../entries/form.vue';
import EntryStar from '../entries/star.vue';

import SessionForm from '../sessions/form.js';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  let apps = [
    { elem: '#entry-index', object: EntryIndex },
    { elem: '#entry-form', object: EntryForm },
    { elem: '#entry-star', object: EntryStar }
  ];

  apps.forEach((app) => {
    if($(app.elem).length) {
      new Vue({
        el: app.elem,
        render: h => h(app.object, { props: vueProps }),
      });
    }
  });

  if($('#session-form').length) {
    new Vue(SessionForm);
  }
});
