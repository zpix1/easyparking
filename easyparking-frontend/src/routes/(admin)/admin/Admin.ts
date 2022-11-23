import { writable } from 'svelte/store';
import { goto } from '$app/navigation';
import axios from 'axios';
import { AxiosError } from 'axios';

export type gotoFunc = (path: string) => void;
interface AuthBody {
  email: string;
  password: string;
}

interface AuthResponse {
  access_token: string;
  refresh_token: string;
}

export const adminLoading = writable(false);
export const loginError = writable<string>('');

export const isAdmin = () => {
  return window.localStorage.getItem('admin_token');
};

export async function adminAuth(body: AuthBody) {
  try {
    adminLoading.set(true);
    const { data } = await axios.post<AuthResponse>(
      //svelte-vite-moment
      // eslint-disable-next-line @typescript-eslint/restrict-template-expressions
      `${import.meta.env.VITE_ADMIN_BASE_URL}/v1/admin/session`,
      body
    );
    localStorage.setItem('admin_token', data.access_token);
    loginError.set('');
    adminLoading.set(false);
    (goto as gotoFunc)('/admin/console');
  } catch (err) {
    if (err instanceof AxiosError) {
      console.log(err?.response?.status, err?.response?.data);
    } else {
      console.log(err);
    }
    adminLoading.set(false);
    loginError.set('invalid password');
  }
}
