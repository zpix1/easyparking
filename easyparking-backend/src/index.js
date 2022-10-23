const express = require('express');
const mongoose = require('mongoose');

require('dotenv').config();

try {
  mongoose.connect(process.env.DB, {
    useUnifiedTopology: true,
    useNewUrlParser: true,
  });
  console.log('Connected to db');
} catch (error) {
  console.error('unhandledRejection', error.message);
}
process.on('unhandledRejection', (error) => {
  console.error('unhandledRejection', error.message);
});

const app = express();

app.use(express.json());
app.use(
  express.urlencoded({
    extended: true,
  }),
);

app.listen(process.env.PORT || 8080, () => {
  console.log('Server is live on port 8080');
});
