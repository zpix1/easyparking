import { ADMIN_BACKEND_URL } from '../config.js';
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

    const pagedFavoriteParkings = favoriteParkings.slice(offset, offset + count);

    axios
      .get(ADMIN_BACKEND_URL + '/api/v1/parkings-by-ids', { params: { 'ids[]': pagedFavoriteParkings } })
      .then((resp) => {
        const parkings = resp.data.map((parking) => ({
          id: parking.id,
          address: parking.address,
          image_url: parking.image_url,
          processed_image_url: parking.processed_image_url,
          latitude: parking.latitude,
          longitude: parking.longitude,
          title: parking.title,
        }));

        res.status(200).json({
          entries: parkings,
          total_entries: parkings.length,
          offset,
          count,
        });
        return;
      })
      .catch((err) => {
        res.status(500).send({
          message: err,
        });
        return;
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
  axios
    .get(ADMIN_BACKEND_URL + '/api/v1/parkings-by-ids', { params: { 'ids[]': req.params.parkingId } })
    .then((resp) => {
      resp.data.map((parking) => {
        return res.status(200).json({
          id: parking.id,
          address: parking.address,
          image_url: parking.image_url,
          processed_image_url: parking.processed_image_url,
          latitude: parking.latitude,
          longitude: parking.longitude,
          title: parking.title,
        });
      });
      return;
    })
    .catch((err) => {
      res.status(500).send({
        message: err,
      });
      return;
    });
}

function PageSizeConversion(offset, limit) {
  var window, leftShift;
  for (window = limit; window <= offset + limit; window++) {
    for (leftShift = 0; leftShift <= window - limit; leftShift++) {
      if ((offset - leftShift) % window == 0) {
        this.pageSize = window;
        this.page = (offset - leftShift) / this.pageSize;

        this.headWaste = leftShift;
        this.tailWaste = (this.page + 1) * this.pageSize - (offset + limit);
        return;
      }
    }
  }
}

export function getParkings(req, res) {
  const user_latitude = parseFloat(req.body.latitude) || 33.5854;
  const user_longitude = parseFloat(req.body.longitude) || -15.3333;
  const offset = parseInt(req.body.offset) || 0;
  const count = parseInt(req.body.count) || 10;
  const conversion = new PageSizeConversion(offset, count);
  const page = conversion.page + 1;
  const page_size = conversion.pageSize;
  const params = {
    user_latitude: user_latitude,
    user_longitude: user_longitude,
    page: page,
    page_size: page_size,
  };
  axios
    .get(ADMIN_BACKEND_URL + '/api/v1/parking', { params })
    .then((resp) => {
      const entries_sliced = resp.data.entries.slice(conversion.headWaste, page_size - conversion.tailWaste);
      return res.status(200).json({
        entries: entries_sliced,
        offset,
        count,
        total_entries: resp.data.total_entries,
      });
    })
    .catch((err) => {
      res.status(500).send({
        message: err,
      });
      return;
    });
}
