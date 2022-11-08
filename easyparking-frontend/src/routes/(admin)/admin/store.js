// @ts-nocheck
import { writable } from "svelte/store";
import { goto } from "$app/navigation";

export const admin = writable({});

export function adminAuth() {
  admin.set({ name: "Dmitry", megaSecretKey: "CHORTBLINCHORT" });
  goto("/admin/console");
}
