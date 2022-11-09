import axios from 'axios';

const instance = axios.create({
  // svelte vite moment
  // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access
  baseURL: import.meta.env.VITE_BASE_URL
});

instance.interceptors.request.use(config => {
  if (window.localStorage.getItem('token')) {
    if(!config.headers) {
      throw new Error("headers object is undefined");
    }
    config.headers.Authorization = `Bearer ${
      window.localStorage.getItem('token') as string
    }`;
  }
  return config;
});

export default instance;
