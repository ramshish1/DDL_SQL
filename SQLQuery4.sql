		-------Data Query Language Checkpoint-------

------Employees on more than one project

SELECT E.Nom, COUNT(EP.Num_P) AS Total_Projects
FROM Employee E
JOIN Employé_Projet EP ON E.Num_E = EP.Num_E
GROUP BY E.Nom
HAVING COUNT(EP.Num_P) > 1;

------Projects managed by each department

SELECT D.Label, D.Nom_du_manager, P.Titre
FROM Departement D
JOIN Projet P ON D.Num_S = P.Num_S
ORDER BY D.Label;

-------Employees on 'Website Redesign'

SELECT E.Nom, EP.Rôle
FROM Employee E
JOIN Employé_Projet EP ON E.Num_E = EP.Num_E
JOIN Projet P ON EP.Num_P = P.Num_P
WHERE P.Titre = 'Refonte du site web';

-------Department with most employees

SELECT TOP 1 D.Label, D.Nom_du_manager, COUNT(E.Num_E) AS Total_Employees
FROM Departement D
JOIN Employee E ON D.Num_S = E.Num_S
GROUP BY D.Label, D.Nom_du_manager
ORDER BY Total_Employees DESC;

-------Employees earning > 60,000

SELECT E.Nom, E.Position, D.Label AS Department
FROM Employee E
JOIN Departement D ON E.Num_S = D.Num_S
WHERE E.Salaire > 60000;

--------Number of employees per project

SELECT P.Titre, COUNT(EP.Num_E) AS Total_Employees
FROM Projet P
JOIN Employé_Projet EP ON P.Num_P = EP.Num_P
GROUP BY P.Titre
ORDER BY Total_Employees DESC;

--------Employee roles across projects

SELECT E.Nom, P.Titre, EP.Rôle
FROM Employee E
JOIN Employé_Projet EP ON E.Num_E = EP.Num_E
JOIN Projet P ON EP.Num_P = P.Num_P
ORDER BY E.Nom;

-------Total salary per department

SELECT D.Label, D.Nom_du_manager, SUM(E.Salaire) AS Total_Salary
FROM Departement D
JOIN Employee E ON D.Num_S = E.Num_S
GROUP BY D.Label, D.Nom_du_manager
ORDER BY Total_Salary DESC;