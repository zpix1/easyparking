import jwt from 'jsonwebtoken';
import { hashSync, compareSync } from 'bcrypt';
import { User } from '../models/user.js';

export function signup(req, res) {
  User.findOne({ email: req.body.email }).then((user) => {
    if (user) {
      return res.status(400).send({
        message: 'User with this email already exists'
      });
    }

    const newUser = new User({
      email: req.body.email,
      password: hashSync(req.body.password, 8),
    });
  
    newUser.save((err, user) => {
      if (err) {
        res.status(500).send({
          message: err,
        });
      } else {
        signin(req, res);
      }
    });
  })

  
}

export function signin(req, res) {
  User.findOne(
    {
      email: req.body.email,
    },
    {
      password: true,
    },
  ).exec((err, user) => {
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
        email: user.email
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
      },
      accessToken: token,
    });
  });
}


export function userInfo(req, res) {
  return res.status(200).send({
    user: {
      id: req.user._id,
      email: req.user.email
    }
  });
}
