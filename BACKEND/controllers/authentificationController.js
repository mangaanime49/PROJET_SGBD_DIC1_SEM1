const Utilisateur = require('../models/Utilisateur');
const jwt = require('jsonwebtoken');

const inscription = (req, res) => {
    const { nom, prenom, email, mot_de_passe, role } = req.body;

    Utilisateur.create(nom, prenom, email, mot_de_passe, role, (err, result) => {
        if (err) {
            if (err.code = 'ER_DUP_ENTRY') {
                return res.status(500).json({ message: 'Email deja utilise' });
            } else{
                return res.status(500).json({ message: 'Erreur lors de la création du compte', error: err });
            }
        } 
        return res.status(200).json({ message: 'Compte créé avec succès', userId: result.insertId });
    });
};

module.exports = { inscription };