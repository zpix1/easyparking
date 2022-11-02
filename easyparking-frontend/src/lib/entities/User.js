// @ts-nocheck
import { writable} from "svelte/store";
import axios from '$lib/shared/config/axiosConfig';
import { goto } from '$app/navigation';

export const isAuthenticated = writable(false);
export const user = writable({});
export const userLoading = writable(false);
export const registerError = writable('');
export const loginError = writable('');

export function logOut(){
    user.set({});
    window.localStorage.removeItem('token');
    goto('/login');
};

export async function logIn(body) {
    try{
        userLoading.set(true)
        const {data} = await axios.post('/login', body);
        localStorage.setItem('token', data.accessToken);
        user.set(data.user);
        loginError.set("");
        userLoading.set(false);
        goto('/');
    } catch (err){
        console.log(err.response.status, err.response.data);
        userLoading.set(false);
        loginError.set("invalid login or password");
    }
}

export async function register(body) {
    try{
        userLoading.set(true)
        const {data} = await axios.post('/register', body);
        localStorage.setItem('token', data.accessToken);
        user.set(data.user);
        registerError.set("");
        userLoading.set(false);
        goto('/');
    } catch (err){
        console.log(err.response.status, err.response.data);
        userLoading.set(false);
        if(err.response.data.message === 'User with this email already exists'){
            registerError.set("This user already exists");
        } else {
            registerError.set("Registration error");
        }
    }
}

export async function getMe() {
    try{
        const {data} = await axios.get('/user');
        user.set({id: data.user.id, email: data.user.email});
    } catch (err){
        console.log(err.response.data.message);
    }
}