require("@rails/ujs").start();
require("turbolinks").start();

import Vue from 'vue';
import TurbolinksAdapter from 'vue-turbolinks'

import EntryIndex from '../entries/index';
import EntryForm from '../entries/form';
import EntryStar from '../entries/star';
import SessionForm from '../sessions/form';
import Flash from '../flash'

Vue.use(TurbolinksAdapter);

Promise;

document.addEventListener('turbolinks:load', () => {
  Flash.show();

  let apps = [
    { elem: '#entry-index', object: EntryIndex },
    { elem: '#entry-form', object: EntryForm },
    { elem: '#entry-star', object: EntryStar },
    { elem: '#session-form', object: SessionForm }
  ];

  let props = window.vueProps || {};
  apps.forEach((app) => {
    if($(app.elem).length) {
      if(app.object.render) { // テンプレートあり
        new Vue({ el: app.elem, render: h => h(app.object, { props }) });
      }
      else { // HTMLをテンプレートに
        new Vue(app.object).$mount(app.elem);
      }
    }
  });
});
