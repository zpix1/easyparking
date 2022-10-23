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
  },
  created: {
    type: Date,
    default: Date.now,
  },
});

export default model('User', userSchema);
