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

function Parking(parkingId, parkingAdress, numEmptySpaces, parkingImage, updateTime) {
  this.parkingId = parkingId;
  this.parkingAdress = parkingAdress;
  this.numEmptySpaces = numEmptySpaces;
  this.parkingImage = parkingImage;
  this.updateTime = updateTime;
}

function getParkingInfoFromServer(parkingId){
  const parkingAdress = "Пирогова 1";
  const numEmptySpaces = 0;
  const parkingImage = "Image";
  const updateTime = "18:23:47 08.11.2022"
  return new Parking(parkingId, parkingAdress, numEmptySpaces, parkingImage, updateTime);
}

export function getParkingById(req, res) {
  const parkingId = req.params.parkingId;
  const parking = getParkingInfoFromServer(parkingId);
  return res.status(200).json({
    parkingId: parking.parkingId,
    parkngAdress: parking.parkingAdress,
    numEmptySpaces: parking.numEmptySpaces,
    parkingImage: parking.parkingImage,
    updateTime: parking.updateTime
  });
}

function getParkingsInfoFromServer(){
  const parking1 = new Parking("1","Пирогова 1", 0, "Image1", "18:23:47 08.11.2022");
  const parking2 = new Parking("2","Пирогова 2", 1, "Image2", "22:37:09 08.11.2022");
  return [parking1, parking2];
}

export function getParkings(req, res){
  const parkings = getParkingsInfoFromServer();
  return res.status(200).json({
    parkings
  });
}