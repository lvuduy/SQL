CREATE TABLE Warehouses (
   Code INTEGER NOT NULL,
   Location VARCHAR(255) NOT NULL ,
   Capacity INTEGER NOT NULL,
   PRIMARY KEY (Code)
 );
CREATE TABLE Boxes (
    Code CHAR(4) NOT NULL,
    Contents VARCHAR(255) NOT NULL ,
    Value REAL NOT NULL ,
    Warehouse INTEGER NOT NULL,
    PRIMARY KEY (Code)
 );
 
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(1,'Chicago',3);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(2,'Chicago',4);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(3,'New York',7);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(4,'Los Angeles',2);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(5,'San Francisco',8);
 
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4H8P','Rocks',250,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4RT3','Scissors',190,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('7G3H','Rocks',200,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8JN6','Papers',75,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8Y6U','Papers',50,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('9J6F','Papers',175,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('LL08','Rocks',140,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P0H6','Scissors',125,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P2T6','Scissors',150,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('TU55','Papers',90,5);

-- 3.1 Select all warehouses.
SELECT * FROM Warehouses;

-- 3.2 Select all boxes with a value larger than $150.
SELECT * FROM Boxes
WHERE Value > 150;

-- 3.3 Select all distinct contents in all the boxes.
SELECT DISTINCT Contents FROM Boxes;

-- 3.4 Select the average value of all the boxes.
SELECT ROUND (AVG(Value), 2) AS avg_value FROM Boxes;

-- 3.5 Select the warehouse code and the average value of the boxes in each warehouse.
SELECT Warehouse, ROUND (AVG(Value), 2) AS avg_value FROM Boxes
GROUP BY Warehouse;

-- 3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
WITH avg_warehouse_value AS (
SELECT Warehouse, ROUND (AVG(Value), 2) AS avg_value FROM Boxes
GROUP BY Warehouse)

SELECT Warehouse, avg_value FROM avg_warehouse_value
WHERE avg_value >= 150;

-- 3.7 Select the code of each box, along with the name of the city the box is located in.
SELECT Boxes.Code, Warehouses.Location FROM Boxes
JOIN Warehouses
ON Boxes.Warehouse = Warehouses.Code;

-- 3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
SELECT Warehouse, COUNT(*) AS number_of_boxes FROM Boxes
GROUP BY Warehouse;

-- 3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
WITH warehouse_cap AS
(SELECT Warehouse, COUNT(*) AS number_of_boxes FROM Boxes
GROUP BY Warehouse)

SELECT Warehouse, Capacity, number_of_boxes FROM warehouse_cap
JOIN Warehouses
ON warehouse_cap.Warehouse = Warehouses.Code
WHERE warehouse_cap.number_of_boxes > Warehouses.Capacity;
-- OR
SELECT B.Warehouse, W.Capacity, COUNT(B.Code) AS number_of_boxes
FROM Warehouses AS W
JOIN Boxes AS B
ON W.Code=B.Warehouse
GROUP BY W.Code
HAVING W.Capacity < number_of_boxes
ORDER BY W.Code;

-- 3.10 Select the codes of all the boxes located in Chicago.
SELECT Boxes.Code, Warehouses.Location FROM Boxes
JOIN Warehouses
ON Boxes.Warehouse = Warehouses.Code
WHERE Warehouses.Location = "Chicago";

-- 3.11 Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO Warehouses VALUES (6, "New York", 3);

-- 3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO Boxes VALUES ("H5RT", "Papers", 200, 2);

-- 3.13 Reduce the value of all boxes by 15%.
UPDATE Boxes
SET Value = Value * 0.85;

-- 3.14 Remove all boxes with a value lower than $100.
DELETE FROM Boxes
WHERE Value < 100;

-- 3.15 Remove all boxes from saturated warehouses.
/* WITH warehouse_cap AS
(SELECT Warehouse, COUNT(*) AS number_of_boxes FROM Boxes
GROUP BY Warehouse),

overcap AS(
SELECT Warehouse, Capacity, number_of_boxes FROM warehouse_cap
JOIN Warehouses
ON warehouse_cap.Warehouse = Warehouses.Code
WHERE warehouse_cap.number_of_boxes > Warehouses.Capacity)

DELETE FROM overcap; */

WITH overcapacity AS ( 
SELECT w.code -- as warehouse_code, capacity, COUNT(b.code) AS number_boxes 
FROM warehouses w 
JOIN boxes b ON w.code=b.warehouse 
GROUP BY w.code, capacity 
HAVING COUNT(b.code) > capacity) 

DELETE b 
FROM boxes b 
JOIN overcapacity o ON b.warehouse=o.code;




