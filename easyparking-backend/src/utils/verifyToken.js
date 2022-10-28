import jwt from 'jsonwebtoken';
import { User } from '../models/user.js';

export const verifyToken = (req, res, next) => {
  if (req.headers && req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
    jwt.verify(req.headers.authorization.split(' ')[1], process.env.API_SECRET, function (err, decode) {
      if (err) {
        res.status(401).send({
          message: 'Invalid access token provided',
        });
      } else {
        User.findOne({
          _id: decode.id,
        }).exec((err, user) => {
          if (err) {
            res.status(500).send({
              message: err,
            });
          } else {
            req.user = user;
            next();
          }
        });
      }
    });
  } else {
    res.status(401).send({
      message: 'No access token provided',
    });
  }
};

export default verifyToken;
