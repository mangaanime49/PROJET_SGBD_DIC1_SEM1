const db = require('../config/db');
const bcrypt = require('bcryptjs');

const Utilisateur = {
    create: (nom, prenom, email, mot_de_passe, role, callback) => {
        const hashedPassword = bcrypt.hashSync(mot_de_passe, 10);
        const query = 'INSERT INTO Utilisateur (nom, prenom, email, mot_de_passe, role) VALUES (?, ?, ?, ?, ?)';
        db.query(query, [nom, prenom, email, hashedPassword, role], (err, result) => {
            if (err) return callback(err, null);
            return callback(null, result);
        });
    },

    findByEmail: (email, callback) => {
        const query = 'SELECT * FROM Utilisateur WHERE email = ?';
        db.query(query, [email], (err, result) => {
            if (err) return callback(err, null);
            return callback(null, result[0]);
        });
    }
};

module.exports = Utilisateur;