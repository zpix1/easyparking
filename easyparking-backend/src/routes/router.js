import { Router } from 'express';
import { signup, signin } from '../controllers/auth.controller.js';
import { verifyToken } from '../utils/verifyToken.js';
import parkingRouter from './parkings.js';

const router = Router();

router.post('/register', signup);

router.post('/login', signin);

router.use('/parkings', parkingRouter);

export default router;
