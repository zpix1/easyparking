import { writable } from 'svelte/store';
import { goto } from '$app/navigation';

type gotoFunc = (path: string) => void;
export const admin = writable({});

export function adminAuth() {
  admin.set({ name: 'Dmitry', megaSecretKey: 'CHORTBLINCHORT' });
  (goto as gotoFunc)('/admin/console');
}
