require("@rails/ujs").start();
require("turbolinks").start();
// require("@rails/activestorage").start();

import Vue from 'vue';
import TurbolinksAdapter from 'vue-turbolinks'
import EntryList from '../entry_list.vue';
import EntryForm from '../entry_form.vue';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  let apps = [
    { elem: '#entry-list', object: EntryList },
    { elem: '#entry-form', object: EntryForm }
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
