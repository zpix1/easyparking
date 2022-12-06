import backendClient from '$lib/shared/config/axiosUserBackendConfig';

export type ParkingIdPayload = {
  parkingId: number;
};

export type UserParking = {
  numEmptySpaces: number;
  parkingAdress: string;
  parkingId: string;
  parkingImage: string;
  updateTime: string;
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

export async function addFavourite(id: number) {
  return backendClient
    .post(`parkings/favourite`, {
      parkingId: id
    })
    .catch(error => {
      console.trace(error);
      throw new Error('STRANGE ERROR');
    });
}

export async function deleteFavourite(id: number) {
  return backendClient
    .post(`parkings/favourite`, {
      parkingId: id
    })
    .catch(error => {
      console.trace(error);
      throw new Error('STRANGE ERROR');
    });
}
