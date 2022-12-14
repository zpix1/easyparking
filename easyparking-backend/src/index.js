import express, { json, urlencoded } from 'express';
import { connect } from 'mongoose';
import dotenv from 'dotenv';
import router from './routes/router.js';
import cors from 'cors';

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

app.use(cors());
app.use(json());
app.use(
  urlencoded({
    extended: true,
  }),
);

app.listen(process.env.PORT || 8080, () => {
  console.log('Server is live on port 8080');
});

app.use(router);
