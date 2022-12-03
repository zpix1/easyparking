import backendClient from '$lib/shared/config/axiosUserBackendConfig';

export type ParkingIdPayload = {
  parkingId: number;
};

export type UserParking = {
  cars_found: number;
  address: string;
  id: string;
  processed_image_url: string;
  updated_at: string;
  is_favorite: boolean;
};

export type GetParkingsResponse = {
  entries: Array<UserParking>;
};

export async function getParkings(): Promise<GetParkingsResponse> {
  return backendClient
    .get<GetParkingsResponse>(`parkings`)
    .then(response => {
      return response.data;
    })
    .catch(error => {
      console.trace(error);
      throw new Error('STRANGE ERROR');
    });
}

export async function getParkingById(id: number): Promise<UserParking> {
  return backendClient
    .get<UserParking>(`parkings/parking/${id}`)
    .then(response => {
      return response.data;
    })
    .catch(error => {
      console.trace(error);
      throw new Error('STRANGE ERROR');
    });
}

export async function getFavourite(): Promise<GetParkingsResponse> {
  return backendClient
    .get<GetParkingsResponse>(`parkings/favorite`)
    .then(response => {
      return response.data;
    })
    .catch(error => {
      console.trace(error);
      throw new Error('STRANGE ERROR');
    });
}

export async function addFavourite(id: string) {
  return backendClient
    .post<ParkingIdPayload>(`parkings/favorite`, {
      parkingId: id
    })
    .catch(error => {
      console.trace(error);
      throw new Error('STRANGE ERROR');
    });
}

export async function deleteFavourite(id: string) {
  return backendClient
    .delete<ParkingIdPayload>(`parkings/favorite`, {
      data: { parkingId: id }
    })
    .catch(error => {
      console.trace(error);
      throw new Error('STRANGE ERROR');
    });
}
