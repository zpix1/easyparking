import { Router } from 'express';
import { signup, signin } from '../controllers/auth.controller.js';
import {
  addParkingToFavorite,
  getFavoriteParkings,
  removeFavoriteParking,
  getParkingById,
} from '../controllers/parkings.controller.js';
import { verifyToken } from '../utils/verifyToken.js';

const router = Router();

router.get('/favorite', verifyToken, getFavoriteParkings);
router.post('/favorite', verifyToken, addParkingToFavorite);
router.delete('/favorite', verifyToken, removeFavoriteParking);
router.get("/parking/:parkingId", verifyToken, getParkingById);

export default router;
