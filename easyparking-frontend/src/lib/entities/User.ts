import { writable } from "svelte/store";
import axios from "$lib/shared/config/axiosConfig";
import { goto } from "$app/navigation";
import { AxiosError } from "axios";

export interface AuthBody {
  email: string;
  password: string;
}

export interface User {
  id: string;
  email: string;
}

export const isAuthenticated = writable(false);
export const user = writable<null | User>(null);
export const userLoading = writable(false);
export const registerError = writable("");
export const loginError = writable("");

export function logOut() {
  user.set(null);
  window.localStorage.removeItem("token");
  goto("/login");
}

export async function logIn(body: AuthBody) {
  try {
    userLoading.set(true);
    const { data } = await axios.post("/login", body);
    localStorage.setItem("token", data.accessToken);
    user.set(data.user);
    loginError.set("");
    userLoading.set(false);
    goto("/");
  } catch (err) {
    if (err instanceof AxiosError) {
      console.log(err?.response?.status, err?.response?.data);
    } else {
      console.log(err);
    }
    userLoading.set(false);
    loginError.set("invalid login or password");
  }
}

export async function register(body: AuthBody) {
  try {
    userLoading.set(true);
    const { data } = await axios.post("/register", body);
    localStorage.setItem("token", data.accessToken);
    user.set(data.user);
    registerError.set("");
    userLoading.set(false);
    goto("/");
  } catch (err) {
    if (err instanceof AxiosError) {
      console.log(err?.response?.status, err?.response?.data);
      registerError.set(err?.response?.data?.message ?? "Registration error");
    } else {
      console.log(err);
      registerError.set("Registration error");
    }
    userLoading.set(false);
  }
}

export async function getMe() {
  try {
    const { data } = await axios.get("/user");
    user.set({ id: data.user.id, email: data.user.email });
  } catch (err) {
    console.log(err);
  }
}
