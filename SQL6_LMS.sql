CREATE TABLE Scientists (
  SSN int,
  Name Char(30) not null,
  Primary Key (SSN)
);

CREATE TABLE Projects (
  Code Char(4),
  Name Char(50) not null,
  Hours int,
  Primary Key (Code)
);
	
CREATE TABLE AssignedTo (
  Scientist int not null,
  Project char(4) not null,
  Primary Key (Scientist, Project)
);

INSERT INTO Scientists(SSN,Name) 
VALUES(123234877,'Michael Rogers'),
(152934485,'Anand Manikutty'),
(222364883, 'Carol Smith'),
(326587417,'Joe Stevens'),
(332154719,'Mary-Anne Foster'),	
(332569843,'George ODonnell'),
(546523478,'John Doe'),
(631231482,'David Smith'),
(654873219,'Zacary Efron'),
(745685214,'Eric Goldsmith'),
(845657245,'Elizabeth Doe'),
(845657246,'Kumar Swamy');

INSERT INTO Projects ( Code,Name,Hours)
VALUES ('AeH1','Winds: Studying Bernoullis Principle', 156),
('AeH2','Aerodynamics and Bridge Design',189),
('AeH3','Aerodynamics and Gas Mileage', 256),
('AeH4','Aerodynamics and Ice Hockey', 789),
('AeH5','Aerodynamics of a Football', 98),
('AeH6','Aerodynamics of Air Hockey',89),
('Ast1','A Matter of Time',112),
('Ast2','A Puzzling Parallax', 299),
('Ast3','Build Your Own Telescope', 6546),
('Bte1','Juicy: Extracting Apple Juice with Pectinase', 321),
('Bte2','A Magnetic Primer Designer', 9684),
('Bte3','Bacterial Transformation Efficiency', 321),
('Che1','A Silver-Cleaning Battery', 545),
('Che2','A Soluble Separation Solution', 778);

INSERT INTO AssignedTo ( Scientist, Project)
VALUES (123234877,'AeH1'),
(152934485,'AeH3'),
(222364883,'Ast3'),	   
(326587417,'Ast3'),
(332154719,'Bte1'),
(546523478,'Che1'),
(631231482,'Ast3'),
(654873219,'Che1'),
(745685214,'AeH3'),
(845657245,'Ast1'),
(845657246,'Ast2'),
(332569843,'AeH4');

-- 6.1 List all the scientists' names, their projects' names, 
-- and the hours worked by that scientist on each project, 
-- in alphabetical order of project name, then scientist name.

SELECT s.Name AS ScientistName, p.Name AS ProjectName, p.Hours FROM Scientists s 
JOIN AssignedTo a
ON s.SSN = a.Scientist
JOIN Projects p 
ON a.Project = p.Code
ORDER BY p.Name, s.Name;
    
-- 6.2 Select the project names which are not assigned yet
WITH not_assign AS(
SELECT * FROM Projects p
LEFT JOIN AssignedTo a
ON a.Project = p.Code)
SELECT not_assign.Name FROM not_assign
WHERE not_assign.Project IS NULL;




