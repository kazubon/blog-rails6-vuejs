import "core-js/stable/promise";

require("@rails/ujs").start();
require("turbolinks").start();

import Vue from 'vue';
import VueRouter from 'vue-router';
import TurbolinksAdapter from 'vue-turbolinks';

import Entries from '../entries/router';
import SessionForm from '../sessions/form';
import '../axios_config';

Vue.use(VueRouter);
Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  let apps = [
    { elem: '#entries', object: Entries },
    { elem: '#session-form', object: SessionForm }
  ];

  apps.forEach((app) => {
    if($(app.elem).length) {
      new Vue(app.object).$mount(app.elem);
    }
  });
});
