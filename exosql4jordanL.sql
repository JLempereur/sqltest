CREATE DATABASE IF NOT EXISTS testbd4 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE testbd4;

CREATE TABLE `CLIENT` (
  `codec` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `prenom` VARCHAR(42),
  `nom` VARCHAR(42),
  `rue` VARCHAR(42),
  `cpostal` VARCHAR(42),
  `ville` VARCHAR(42)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO CLIENT (prenom, nom, rue, cpostal, ville)
VALUES (
        'Alain',
        'un',
        '1 rue de la paix',
        '02001',
        'Lille-xer'
    ),
    (
        'Robert',
        'deux',
        '2 rue de la joie',
        '02010',
        'Lille-edf'
    ),
    (
        'Marine',
        'trois',
        '3 rue de la peur',
        '02015',
        'Lille-eds'
    ),
    (
        'annie',
        'quatre',
        '4 rue du bonheur',
        '02000',
        'Lille-wse'
    ),
    (
        'christelle',
        'cinq',
        '5 rue de la faiblesse',
        '02001',
        'Lille-poi'
    ),
    (
        'Emmanuelle',
        'six',
        '6 rue des questions',
        '02020',
        'Lille-yhj'
    ),
    (
        'Aurelie',
        'sept',
        '7 rue de la reponses',
        '02111',
        'Lille-frd'
    ),
    (
        'severine',
        'huit',
        '8 rue des doutes',
        '02321',
        'Lille-aze'
    ),
    (
        'guillaume',
        'neuf',
        '9 rue de la certitudes',
        '02951',
        'Lille-wsx'
    ),
    (
        'Francois',
        'dix',
        '10 rue de linterrogation',
        '02123',
        'Lille-fgm'
    ),
    (
        'Claude',
        'onze',
        '11 rue des choix',
        '02852',
        'Lille-apv'
    ),
    (
        'Nathalie',
        'douze',
        '12 rue des positions',
        '02124',
        'Lille-qpb'
    ),
    (
        'Beatrice',
        'treize',
        '13 rue des grimaces',
        '02789',
        'Lille-lep'
    );

CREATE TABLE `EMPRUNT` (
  `codel` INT ,
  `codec` INT,
  `date_demprunt` VARCHAR(42),
  `duree` VARCHAR(42),
  PRIMARY KEY (`codel`, `codec`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO EMPRUNT VALUES
(1, 2, '2020-10-10', '1'),
(1, 4, '2020-10-11', '3'),
(1, 5, '2020-10-12', '3'),
(2, 1, '2020-10-10', '2'),
(3, 2, '2020-10-15', '5'),
(4, 1, '2020-10-17', '1'),
(4, 6, '2020-10-10', '2'),
(5, 2, '2020-10-12', '3'),
(6, 8, '2020-10-18', '2'),
(7, 7, '2020-10-10', '1'),
(7, 9, '2020-10-18', '4');

CREATE TABLE `LIVRE` (
  `codel` INT PRIMARY KEY AUTO_INCREMENT,
  `titre` VARCHAR(42)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO LIVRE
(titre)
VALUES
('les oiseaux'), 
('les chiens'), 
('les lamas'), 
('les grenouilles'), 
('les mouches'), 
('les lions'), 
('les chats'),
('les lapins'), 
('les elephants'), 
('les girafes'), 
('les poissons');

ALTER TABLE `EMPRUNT` ADD FOREIGN KEY (`codec`) REFERENCES `CLIENT` (`codec`);
ALTER TABLE `EMPRUNT` ADD FOREIGN KEY (`codel`) REFERENCES `LIVRE` (`codel`);

-- 1
SELECT titre, date_demprunt FROM EMPRUNT JOIN LIVRE WHERE emprunt.codel = livre.codel ORDER BY titre;

-- 2
SELECT DISTINCT ville FROM CLIENT JOIN EMPRUNT WHERE emprunt.codec = client.codec ORDER BY ville;

-- 3
SELECT client.codec, ville, IFNULL(codel, "Pas d\'emprunt") as numLivreEmpr FROM client LEFT JOIN emprunt ON client.codec = emprunt.codec ORDER BY ville;

-- 4
SELECT client.nom as NomDuClient, livre.titre as TitreDuLivre, date_demprunt as DateDebutEmprunt 
FROM EMPRUNT JOIN client ON emprunt.codec = client.codec JOIN livre ON emprunt.codel = livre.codel ORDER BY NomDuClient;

-- 5
SELECT client.nom as NomDuClient, IFNULL(livre.titre, "Pas d'emprunt") as TitreDuLivre, IFNULL(duree, "Pas d'emprunt") as DureeEmprunt FROM EMPRUNT RIGHT JOIN client on emprunt.codec = client.codec LEFT JOIN livre ON emprunt.codel = livre.codel
ORDER BY NomDuClient;