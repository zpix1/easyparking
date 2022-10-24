import jwt from 'jsonwebtoken';
import { hashSync, compareSync } from 'bcrypt';
import { User } from '../models/user.js';

export function signup(req, res) {
  const user = new User({
    email: req.body.email,
    password: hashSync(req.body.password, 8),
  });

  user.save((err, user) => {
    if (err) {
      res.status(500).send({
        message: err,
      });
    } else {
      res.status(200).send({
        message: 'User registered successfully',
      });
    }
  });
}

export function signin(req, res) {
  User.findOne({
    email: req.body.email,
  }).exec((err, user) => {
    if (err) {
      res.status(500).send({
        message: err,
      });
      return;
    }
    if (!user) {
      return res.status(404).send({
        message: 'User not found',
      });
    }

    const passwordIsValid = compareSync(req.body.password, user.password);
    if (!passwordIsValid) {
      return res.status(401).send({
        accessToken: null,
        message: 'Invalid password',
      });
    }

    const token = jwt.sign(
      {
        id: user.id,
      },
      process.env.API_SECRET,
      {
        expiresIn: 86400,
      },
    );

    res.status(200).send({
      user: {
        id: user._id,
        email: user.email,
        fullName: user.fullName,
      },
      message: 'Login successful',
      accessToken: token,
    });
  });
}
