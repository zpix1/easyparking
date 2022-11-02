import { Router } from 'express';
import { signup, signin } from '../controllers/auth.controller.js';
import {
  addParkingToFavorite,
  getFavoriteParkings,
  removeFavoriteParking,
} from '../controllers/parkings.controller.js';
import { verifyToken } from '../utils/verifyToken.js';

const router = Router();

router.get('/favorite', verifyToken, getFavoriteParkings);
router.post('/favorite', verifyToken, addParkingToFavorite);
router.delete('/favorite', verifyToken, removeFavoriteParking);

export default router;
