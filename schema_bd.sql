-- Création de la base de données
CREATE DATABASE IF NOT EXISTS GestionExamens;

USE GestionExamens;

-- Table des Utilisateurs (gère à la fois les enseignants et les étudiants)
CREATE TABLE Utilisateur (
                             id INT PRIMARY KEY AUTO_INCREMENT,
                             nom VARCHAR(100) NOT NULL,
                             email VARCHAR(100) UNIQUE NOT NULL,
                             mot_de_passe VARCHAR(255) NOT NULL,
                             role ENUM('enseignant', 'etudiant') NOT NULL,
                             date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des Enseignants (hérite de Utilisateur)
CREATE TABLE Enseignant (
                            id INT PRIMARY KEY,
                            FOREIGN KEY (id) REFERENCES Utilisateur(id) ON DELETE CASCADE
);

-- Table des Étudiants (hérite de Utilisateur)
CREATE TABLE Etudiant (
                          id INT PRIMARY KEY,
                          FOREIGN KEY (id) REFERENCES Utilisateur(id) ON DELETE CASCADE
);

-- Table des Examens (liée aux enseignants)
CREATE TABLE Examen (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        titre VARCHAR(255) NOT NULL,
                        description TEXT,
                        date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        id_enseignant INT NOT NULL,
                        FOREIGN KEY (id_enseignant) REFERENCES Enseignant(id) ON DELETE CASCADE
);

-- Table des Copies d'examens soumises par les étudiants
CREATE TABLE Copie (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       fichier_pdf VARCHAR(255) NOT NULL, -- Stockage du chemin du fichier PDF
                       date_soumission TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       id_etudiant INT NOT NULL,
                       id_examen INT NOT NULL,
                       FOREIGN KEY (id_etudiant) REFERENCES Etudiant(id) ON DELETE CASCADE,
                       FOREIGN KEY (id_examen) REFERENCES Examen(id) ON DELETE CASCADE
);

-- Table des Corrections automatiques par IA
CREATE TABLE Correction (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            id_copie INT NOT NULL,
                            note FLOAT CHECK (note BETWEEN 0 AND 20),
                            commentaires TEXT,
                            statut ENUM('proposé', 'validé', 'modifié') DEFAULT 'proposé',
                            id_enseignant_validateur INT,
                            date_correction TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            FOREIGN KEY (id_copie) REFERENCES Copie(id) ON DELETE CASCADE,
                            FOREIGN KEY (id_enseignant_validateur) REFERENCES Enseignant(id) ON DELETE SET NULL
);

-- Table des Détections de Plagiat
CREATE TABLE Plagiat (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         id_copie1 INT NOT NULL,
                         id_copie2 INT NOT NULL,
                         pourcentage_similarite FLOAT CHECK (pourcentage_similarite BETWEEN 0 AND 100),
                         date_detection TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (id_copie1) REFERENCES Copie(id) ON DELETE CASCADE,
                         FOREIGN KEY (id_copie2) REFERENCES Copie(id) ON DELETE CASCADE
);

-- Table du Chatbot pour stocker l'historique des questions/réponses
CREATE TABLE Chatbot_Historique (
                                    id INT PRIMARY KEY AUTO_INCREMENT,
                                    id_utilisateur INT NOT NULL,
                                    question TEXT NOT NULL,
                                    reponse TEXT NOT NULL,
                                    date_interaction TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id) ON DELETE CASCADE
);

-- Table des Statistiques
CREATE TABLE Statistiques (
                              id INT PRIMARY KEY AUTO_INCREMENT,
                              id_examen INT NOT NULL,
                              moyenne FLOAT,
                              ecart_type FLOAT,
                              taux_reussite FLOAT CHECK (taux_reussite BETWEEN 0 AND 100),
                              date_calcul TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              FOREIGN KEY (id_examen) REFERENCES Examen(id) ON DELETE CASCADE
);