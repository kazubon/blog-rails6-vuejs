import Axios from 'axios';

Axios.interceptors.request.use((config) => {
  if(config.method == 'post' || config.method == 'put' ||
     config.method == 'patch' || config.method == 'delete') {
    config.headers['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content');
  }
  return config;
}, (error) => {
  return Promise.reject(error);
});
