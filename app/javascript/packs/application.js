require("@rails/ujs").start();
require("turbolinks").start();

import 'core-js';
import Vue from 'vue';
import TurbolinksAdapter from 'vue-turbolinks'
import axios from 'axios';

import SessionForm from '../sessions/form.vue';
import EntryIndex from '../entries/index.vue';
import EntryForm from '../entries/form.vue';
import EntryStar from '../entries/star.vue';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  let apps = [
    { elem: '#session-form', object: SessionForm },
    { elem: '#entry-index', object: EntryIndex },
    { elem: '#entry-form', object: EntryForm },
    { elem: '#entry-star', object: EntryStar }
  ];

  apps.forEach((app) => {
    if($(app.elem).length) {
      new Vue({
        el: app.elem,
        render: h => h(app.object, { props: $(app.elem).data() }),
      });
    }
  });
});
