import axios from 'axios';

const instance = axios.create({
    baseURL: `http://localhost:${import.meta.env.VITE_BACKEND_PORT}`
});

instance.interceptors.request.use((config) => {
    if(window.localStorage.getItem('token')){
        config.headers!.Authorization = 'Bearer ' + window.localStorage.getItem('token');
    }
    return config;
});

export default instance;