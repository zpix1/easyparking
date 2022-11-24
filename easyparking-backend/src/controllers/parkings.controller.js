import jwt from 'jsonwebtoken';
import { hashSync, compareSync } from 'bcrypt';
import { User } from '../models/user.js';
import axios from 'axios';

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

export function getParkingById(req, res) {
  axios.get(`http://localhost:4000/api/v1/parkings-by-ids?ids[]=${req.params.parkingId}`)
  .then(resp =>{
    resp.data.map((parking)=>{
      return res.status(200).json({
        id: parking.id,
        address: parking.address,
        image_url: parking.image_url,
        processed_image_url: parking.processed_image_url, 
        latitude: parking.latitude, 
        longitude: parking.longitude, 
        title: parking.title
      });
    })
    return;
  })
  .catch((err)=>{
    res.status(500).send({
      message: err,
    });
    return;
  })
  
}

export function getParkings(req, res){
  const user_latitude = req.body.latitude || 33.5854;
  const user_longitude = req.body.longitude || -15.3333;
  const offset = parseInt(req.body.offset) || 0;
  const count = parseInt(req.body.count) || 10;
  const page = parseInt(offset/count) + 1;
  const page_size = (offset%count) + count;
  axios.get(`http://localhost:4000/api/v1/parking?user_latitude=${user_latitude}&user_longitude=${user_longitude}&page=${page}&page_size=${page_size}`)
  .then(resp => {
    const entries_paginated = resp.data.entries.slice(offset%count);
    return res.status(200).json({
      entries: entries_paginated
    })
  })
  .catch((err)=>{
    res.status(500).send({
      message: err,
    });
    return;
  })
}