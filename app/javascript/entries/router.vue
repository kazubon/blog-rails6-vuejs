<template>
  <div>
    <div v-if="error && error.response">
      {{error.response.status}} {{error.response.statusText}}
    </div>
    <router-view v-else></router-view>
  </div>
</template>

<script>
import VueRouter from 'vue-router';
import Index from './index';
import Show from './show';
import Form from './form';
import Store from './store';
import Flash from '../flash';

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Index },
    { path: '/entries', component: Index, name: 'entries', props: true },
    { path: '/users/:userId/entries', component: Index, name: 'user_entries', props: true },
    { path: '/entries/new', component: Form, name: 'new_entry' },
    { path: '/entries/:entryId/edit', component: Form, name: 'edit_entry', props: true },
    { path: '/entries/:entryId', component: Show, name: 'entry', props: true },
    { path: '/entries/:entryId/star', name: 'star' }
  ]
});

router.afterEach((to, from) => {
  Store.state.error = null;
  Flash.show();
});

export default {
  router: router,
  data() {
    return {
      state: Store.state
    };
  },
  computed: {
    error() { return this.state.error; }
  }
};
</script>