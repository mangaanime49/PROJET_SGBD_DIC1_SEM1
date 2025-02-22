const mysql = require("mysql2");
require('dotenv').config();

const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME
});

db.connect((err) => {
    if(err){
        console.log("Erreur lors de la connexion a la base de donnees: ", err);
    } else{
        console.log("Connexion a la base de donnees etablie");
    }
});

module.exports = db;