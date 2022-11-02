import express, { json, urlencoded } from 'express';
import { connect } from 'mongoose';
import dotenv from 'dotenv';
import cors from 'cors';
import router from './routes/router.js';

dotenv.config();

try {
  connect(process.env.DB, {
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

app.use(json());
app.use(
  urlencoded({
    extended: true,
  }),
);
app.use(cors());

app.listen(process.env.PORT || 8080, () => {
  console.log('Server is live on port 8080');
});

app.use(router);
