import axios, { AxiosError } from 'axios';
import { HTTP_UNAUTHORIZED } from '$lib/shared/utils/constants';
import { goto } from '$app/navigation';
import type { gotoFunc } from '../../../routes/(admin)/admin/Admin';
import { nop } from '$lib/shared/utils/utils';

const adminClient = axios.create({
  // svelte vite moment
  // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access
  baseURL: import.meta.env.VITE_ADMIN_BASE_URL
});

adminClient.interceptors.request.use(config => {
  if (window.localStorage.getItem('admin_token')) {
    if (!config.headers) {
      throw new Error('headers object is undefined');
    }
    config.headers.Authorization = `Bearer ${
      window.localStorage.getItem('admin_token') as string
    }`;
  }
  return config;
});

adminClient.interceptors.response.use(undefined, (error: AxiosError) => {
  if (error.response?.status === HTTP_UNAUTHORIZED) {
    (goto as gotoFunc)('/admin');
  }
});

export default adminClient;
