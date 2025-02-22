const express = require('express');
const authentificationController = require('../controllers/authentificationController');

const router = express.Router();

router.post('/inscription', authentificationController.inscription);

module.exports = router;