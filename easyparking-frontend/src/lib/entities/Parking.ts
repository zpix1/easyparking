import { writable } from 'svelte/store';
import adminClient from '$lib/shared/config/axiosAdminBackendConfig';

export const parkingCreationError = writable('');
parkingCreationError.set(``);

export type ParkingResponse = {
  address: string;
  camera_endpoint: string;
  id: string;
  inserted_at: string;
  latitude: number;
  longitude: number;
  title: string;
  updated_at: string;
};

export type AddParkingPayload = {
  address: string;
  camera_endpoint: string;
  latitude: number;
  longitude: number;
  title: string;
};

export async function getParkings(): Promise<Array<ParkingResponse>> {
  return adminClient
    .get<Array<ParkingResponse>>(`v1/admin/parking`)
    .then(response => response.data);
}

export async function deleteParking(id: string) {
  return adminClient.delete<Array<ParkingResponse>>(`v1/admin/parking/${id}`);
}

export async function addParking(payload: AddParkingPayload): Promise<ParkingResponse> {
  return adminClient
    .post<ParkingResponse>(`v1/admin/parking`, payload)
    .then(response => response.data);
}

export async function editParking(
  id: string,
  payload: AddParkingPayload
): Promise<ParkingResponse> {
  return adminClient
    .put<ParkingResponse>(`v1/admin/parking/${id}`, payload)
    .then(response => response.data);
}
