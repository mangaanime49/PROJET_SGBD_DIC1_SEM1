const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const db = require('./config/db');
require('dotenv').config();

const app = express();

app.use(cors());
app.use(bodyParser.json());

const authRoutes = require('./routes/authentificationRoute');
app.use('/api/auth', authRoutes);

const PORT = process.env.PORT;
app.listen(PORT, () => {
    console.log(`Serveur démarré sur le port ${PORT}`);
});