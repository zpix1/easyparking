import { writable } from 'svelte/store';
import axios from '$lib/shared/config/axiosConfig';
import { goto } from '$app/navigation';
import type { AxiosError } from 'axios';

export interface IAuthBody {
    email: string;
    password: string;
}

export interface IUser {
    id: string;
    email: string;
}

export const isAuthenticated = writable(false);
export const user = writable<null | IUser>(null);
export const userLoading = writable(false);
export const registerError = writable('');
export const loginError = writable('');

export function logOut() {
    user.set(null);
    window.localStorage.removeItem('token');
    goto('/login');
}

export async function logIn(body: IAuthBody) {
    try {
        userLoading.set(true);
        const { data } = await axios.post('/login', body);
        localStorage.setItem('token', data.accessToken);
        user.set(data.user);
        loginError.set('');
        userLoading.set(false);
        goto('/');
    } catch (err: AxiosError | any) {
        console.log(err?.response?.status, err?.response?.data);
        userLoading.set(false);
        loginError.set('invalid login or password');
    }
}

export async function register(body: IAuthBody) {
    try {
        userLoading.set(true);
        const { data } = await axios.post('/register', body);
        localStorage.setItem('token', data.accessToken);
        user.set(data.user);
        registerError.set('');
        userLoading.set(false);
        goto('/');
    } catch (err: AxiosError | any) {
        console.log(err?.response?.status, err?.response?.data);
        userLoading.set(false);
        if (
            err?.response?.data?.message ===
            'User with this email already exists'
        ) {
            registerError.set('This user already exists');
        } else {
            registerError.set('Registration error');
        }
    }
}

export async function getMe() {
    try {
        const { data } = await axios.get('/user');
        user.set({ id: data.user.id, email: data.user.email });
    } catch (err: AxiosError | any) {
        console.log(err?.response?.data);
    }
}
