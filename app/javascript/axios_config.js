import Axios from 'axios';

Axios.interceptors.request.use((config) => {
  if(['post', 'put', 'patch', 'delete'].includes(config.method)) {
    config.headers['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content');
  }
  return config;
}, (error) => {
  return Promise.reject(error);
});
