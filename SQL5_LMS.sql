CREATE TABLE Pieces (
 Code INTEGER NOT NULL,
 Name TEXT NOT NULL,
 PRIMARY KEY (Code)
 );
CREATE TABLE Providers (
 Code VARCHAR(40) NOT NULL,  
 Name TEXT NOT NULL,
PRIMARY KEY (Code) 
 );
CREATE TABLE Provides (
 Piece INTEGER, 
 Provider VARCHAR(40), 
 Price INTEGER NOT NULL,
 PRIMARY KEY(Piece, Provider) 
 );
 

INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');

INSERT INTO Pieces(Code, Name) VALUES(1,'Sprocket');
INSERT INTO Pieces(Code, Name) VALUES(2,'Screw');
INSERT INTO Pieces(Code, Name) VALUES(3,'Nut');
INSERT INTO Pieces(Code, Name) VALUES(4,'Bolt');

INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);

-- 5.1 Select the name of all the pieces. 
SELECT Name FROM Pieces;

-- 5.2  Select all the providers' data. 
SELECT * FROM Providers;

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
SELECT p.Code, ROUND(AVG(pr.Price), 2) AS avg_price FROM Pieces p
JOIN Provides pr
ON p.Code = pr.Piece
GROUP BY p.Code;

-- 5.4  Obtain the names of all providers who supply piece 1.
SELECT pr.Name, p.Piece FROM Providers pr
JOIN Provides p 
ON pr.Code = p.Provider
WHERE Piece = 1;

-- 5.5 Select the name of pieces provided by provider with code "HAL".
SELECT p.Name, pr.Provider FROM Pieces p 
JOIN Provides pr 
ON p.Code = pr.Piece
WHERE pr.Provider = "HAL";

-- 5.6 For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price (note that there could be two providers who supply the same piece at the most expensive price).
SELECT * FROM (
SELECT p.Name AS pieceName, pr.Name, pro.Price, 
RANK (pro.Price) OVER (PARTITION BY pro.Piece ) AS most_expen -- ????
FROM Pieces p
JOIN Provides pro 
ON p.Code = pro.Piece
JOIN Providers pr
ON pr.Code = pro.Provider) AS price_rank
WHERE most_expen = 1;

SELECT p.Name AS pieceName, pr.Name, pro.Price, 
MAX (pro.Price) OVER (PARTITION BY pro.Piece ) AS most_expen -- ????
FROM Pieces p
JOIN Provides pro 
ON p.Code = pro.Piece
JOIN Providers pr
ON pr.Code = pro.Provider

-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO Provides VALUES (1, "TNBC", 7);

-- 5.8 Increase all prices by one cent.
UPDATE Provides
SET Price = Price + 1;

-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
WITH del_rbt AS
(SELECT pro.Piece, pro.Provider, p.Code, p.Name FROM Provides pro 
JOIN Providers pr
ON pro.Provider = pr.Code
JOIN Pieces p
ON p.Code = pro.Piece
WHERE pro.Provider = "RBT" AND p.Code = 4
)
DELETE pro FROM Provides pro
JOIN del_rbt d 
ON pro.Piece = d.Piece;





