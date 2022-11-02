import mongoose, { model } from 'mongoose';

const { Schema } = mongoose;

const userSchema = new Schema({
  email: {
    type: String,
    unique: [true, 'email already exists in database!'],
    lowercase: true,
    trim: true,
    required: [true, 'email not provided'],
    validate: {
      validator(v) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v);
      },
      message: '{VALUE} is not a valid email!',
    },
  },
  password: {
    type: String,
    required: true,
    select: false,
  },
  created: {
    type: Date,
    default: Date.now,
  },
  favoriteParkings: {
    type: [String],
    default: [],
    select: false,
  },
});

export const User = model('User', userSchema);
