import { Router } from 'express';
import { signup, signin } from '../controllers/auth.controller.js';
import { verifyToken } from '../utils/verifyToken.js';

const router = Router();

router.post('/register', signup);

router.post('/login', signin);

router.get('/hiddencontent', verifyToken, function (req, res) {
  res.status(200).send({
    user: req.user,
  });
});

export default router;
