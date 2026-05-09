-- Création de la base de données nommée DDL_CHECKPOIN

CREATE DATABASE DDL_CHECKPOINT
GO --exécute les instructions précédentes avant de continuer
USE DDL_CHECKPOINT -- Sélectionne DDL_CHECKPOINT comme base de données active pour les instructions suivantes
GO

-- Table DEPARTEMENT

CREATE TABLE Departement( 
	Num_S INT PRIMARY KEY NOT NULL,  -- Clé primaire : identifiant unique du département,entier
	Label VARCHAR(255) , --nom du département (texte jusqu'à 255 caractères)
	Nom_du_manager VARCHAR(255) -- Nom du responsable du département (texte jusqu'à 255 caractères)
); 

-- Table Employee
CREATE TABLE Employee(
	Num_E  INT PRIMARY KEY NOT NULL, -- Clé primaire : identifiant unique de l'employé ,entier
    Nom      VARCHAR(255),-- Nom complet de l'employé (texte jusqu'à 255 caractères)
    Position VARCHAR(255),  -- Poste occupé par l'employé (texte jusqu'à 255 caractères)
    Salaire  DECIMAL(10, 2), -- Salaire avec 10 chiffres au total dont 2 après la virgule 
    Num_S    INT NOT NULL, -- Clé étrangère vers Departement : numéro du département auquel appartient l'employé 
    FOREIGN KEY (Num_S) REFERENCES Departement(Num_S)  -- Contrainte FK : Num_S doit exister dans Departement.Num_S (intégrité référentielle)
);

-- Table Projet
CREATE TABLE Projet( 
	Num_P INT PRIMARY KEY NOT NULL, -- Clé primaire : identifiant unique du projet (entier)
	Titre VARCHAR(255) NOT NULL, -- Titre du projet (texte jusqu'à 255 caractères)
	Date_de_début DATE, -- Date de démarrage du projet (format DATE)
	Date_fin  DATE,-- Date de fin prévue ou réelle du projet (format DATE)
	Num_S  INT NOT NULL, -- Clé étrangère vers Departement : département responsable du projet 
	FOREIGN KEY (Num_S) REFERENCES Departement (Num_S) -- Contrainte FK : Num_S doit exister dans Departement.Num_S
);

-- Table Employé_Projet (table d'association)
CREATE TABLE Employé_Projet( 
	Num_E INT NOT NULL, -- Clé étrangère vers Employee : identifiant de l'employé participant 
	Num_P INT NOT NULL,  -- Clé étrangère vers Projet : identifiant du projet concerné 
	FOREIGN KEY (Num_E) REFERENCES Employee(Num_E) ,  -- Contrainte FK : Num_E doit exister dans Employee.Num_E
	FOREIGN KEY (Num_P) REFERENCES Projet(Num_P), -- Contrainte FK : Num_P doit exister dans Projet.Num_P
	PRIMARY KEY (Num_E, Num_P),  -- Clé primaire composite : la combinaison (employé + projet) doit être unique → un employé a un seul rôle par projet
	Rôle VARCHAR(255) NOT NULL  -- Rôle joué par l'employé dans ce projet (un texte jusqu'à 255 caractères)
);



----------------2nd Part----DML CHECKPOINT 

INSERT INTO Departement (Num_S, Label, Nom_du_manager)
	VALUES
	(1, 'IT',        'Alice Johnson'),
	(2, 'HR',        'Bob Smith'),
	(3, 'Marketing', 'Clara Bennett');

INSERT INTO Employee (Num_E,Nom, Position,Salaire,Num_S)
	VALUES
	(101, 'John Doe', 'Développeur',  60000.00,  1),
	(102, 'Jane Smith','Analyste',55000.00,2),
    (103, 'Mike Brown', 'Concepteur',50000.00, 3),
	(104, 'Sarah Johnson','Data Scientist', 70000.00,1),
	(105,  'Emma Wilson','HR Specialist',52000.00,2) ;
	 
INSERT INTO Projet (Num_P, Titre, Date_de_début, Date_fin, Num_S)
	VALUES
	(201, 'Refonte du site web',      '2024-01-15', '2024-06-30', 1),
	(202, 'Onboarding des employés',  '2024-03-01', '2024-09-01', 2),
	(203, 'Market Research',          '2024-02-01', '2024-07-31', 3),
	(204, 'IT Infrastructure Setup',  '2024-04-01', '2024-12-31', 1);

INSERT INTO Employé_Projet (Num_E, Num_P, Rôle) 
	VALUES
	(101, 201, 'Développeur Frontend'),
	(104, 201, 'Développeur Backend'),
	(102, 202, 'Formateur'),
	(105, 202, 'Coordinateur'),
	(103, 203, 'Responsable de la recherche'),
	(101, 204, 'Spécialiste réseau');

GO
	UPDATE Employé_Projet
	SET Rôle='Full Stack Developer'
	WHERE Num_E=101; 


	DELETE FROM Employé_Projet
	WHERE  Num_E = 103;


	DELETE FROM Employee
	WHERE  Num_E = 103;