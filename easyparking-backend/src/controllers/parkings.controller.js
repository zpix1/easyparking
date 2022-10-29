import jwt from 'jsonwebtoken';
import { hashSync, compareSync } from 'bcrypt';
import { User } from '../models/user.js';

export function getFavoriteParkings(req, res) {
  User.findById(req.user._id, {
    favoriteParkings: true,
  }).exec((err, { favoriteParkings }) => {
    if (err) {
      res.status(500).send({
        message: err,
      });
      return;
    }
    const offset = parseInt(req.body.offset) || 0;
    const count = parseInt(req.body.count) || 5;
    // TODO Find a way to do it from mongo
    const pagedFavoriteParkings = favoriteParkings.slice(offset, offset + count);
    return res.status(200).json({
      favoriteParkings: pagedFavoriteParkings,
      offset,
      count,
    });
  });
}

export function addParkingToFavorite(req, res) {
  const parkingId = req.body.parkingId;
  User.findByIdAndUpdate(req.user._id, {
    $addToSet: {
      favoriteParkings: parkingId,
    },
  }).exec((err, user) => {
    if (err) {
      res.status(500).send({
        message: err,
      });
      return;
    }
    return res.status(200).json({
      parkingId,
    });
  });
}

export function removeFavoriteParking(req, res) {
  const parkingId = req.body.parkingId;
  User.findByIdAndUpdate(req.user._id, {
    $pull: {
      favoriteParkings: parkingId,
    },
  }).exec((err, user) => {
    if (err) {
      res.status(500).send({
        message: err,
      });
      return;
    }
    return res.status(200).json({
      parkingId,
    });
  });
}
