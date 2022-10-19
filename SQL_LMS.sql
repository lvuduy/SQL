CREATE TABLE IF NOT EXISTS Manufacturers (
  Code INTEGER,
  Name TEXT NOT NULL,
  PRIMARY KEY (Code)
);

CREATE TABLE IF NOT EXISTS Products (
  Code INTEGER,
  Name TEXT NOT NULL,
  Price INTEGER NOT NULL,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code)
);

INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);

-- SELECT * FROM Products 
-- ORDER BY Price ASC
-- WHERE Name = "Monitor"
-- WHERE Price LIKE "2%"
-- WHERE Price >70
-- WHERE Name IN ("Memory","Printer")
-- WHERE Price LIKE "2%" AND Name = "Monitor"
-- WHERE (Manufacturer > 2 AND Price > 50) OR (Name = "Floppy disk")
-- LIMIT 10 						(limit the results to just the first 10)
-- SELECT DISTINCT Name FROM Products

-- SELECT Name FROM Products			Select the names of all the products in the store
-- SELECT Name,Price FROM Products		Select the names and the prices of all the products in the store
-- SELECT Name FROM Products			
-- WHERE Price <= 200					Select the name of the products with a price less than or equal to $200
-- SELECT * FROM Products
-- WHERE Price >= 60 AND Price <= 120	Select all the products with a price between $60 and $120.
-- SELECT Name,Price*100 As "Price in Cents" FROM Products	 Select the name and price in cents (i.e., the price must be multiplied by 100)
-- SELECT AVG(Price) FROM Products			Compute the average price of all the products
-- SELECT AVG(Price) FROM Products
-- WHERE Manufacturer = 2					Compute the average price of all products with manufacturer code equal to 2
-- SELECT COUNT(Name) FROM Products
-- WHERE Price >= 180						Compute the number of products with a price larger than or equal to $180
-- SELECT * FROM Products
-- WHERE Price >= 180 
-- ORDER BY Price DESC						Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
-- ORDER BY Name 
-- SELECT * FROM Products						Select all the data from the products, including all the data for each product's manufacturer
-- LEFT JOIN Manufacturers
-- ON Products.Code = Manufacturers.Code
-- SELECT Products.Name, Products.Price, Manufacturers.Name FROM Products
-- JOIN Manufacturers
-- ON Products.Manufacturer = Manufacturers.Code;

-- SELECT AVG(Price) AS AVG_Price, Manufacturer
-- FROM Products													Select the average price of each manufacturer's products, showing only the manufacturer's code.
-- GROUP BY Manufacturer;

SELECT AVG(Products.Price) AS average_price, Manufacturers.name 
FROM Products 
JOIN Manufacturers  
ON Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name;
-- Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT AVG(Price) AS AVG_price, Manufacturers.Name
FROM Products
JOIN Manufacturers  
ON Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturer;

-- Select the names of manufacturer whose products have an average price larger than or equal to $150
SELECT AVG(Price) AS average_price, Manufacturers.Name
FROM Products
JOIN Manufacturers
ON Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name
HAVING average_price >= 150;

SELECT AVG(Price) AS average_price, Manufacturers.Name
FROM Products, Manufacturers
WHERE Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name
HAVING AVG(Price) >= 150;

-- Select the name and price of the cheapest product
SELECT Name, Price 
FROM Products
ORDER BY Price LIMIT 1;

SELECT Name, Price
FROM Products
WHERE Price = (
SELECT MIN(Price)
FROM Products
);

-- Select the name of each manufacturer along with the name and price of its most expensive product
SELECT max_price.name, max_price, p.name
FROM (
SELECT m.code, m.name, MAX(p.price) max_price
FROM manufacturers m
JOIN products p ON m.code=p.manufacturer
GROUP BY m.code, m.name
ORDER BY m.name) max_price
JOIN products p ON max_price.code=p.manufacturer
WHERE max_price.max_price=p.price;

SELECT *
FROM manufacturers m
JOIN products p ON m.code=p.manufacturer
WHERE price IN (SELECT MAX(p.price) max_price
FROM manufacturers m
JOIN products p ON m.code=p.manufacturer
GROUP BY m.code, m.name
ORDER BY m.name);

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO Products
VALUES (11, "Loudspeakers", 70, 2);

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE Products
SET Name = "Laser Printer"
WHERE Code = 8;

-- 1.19 Apply a 10% discount to all products.
UPDATE Products
SET Price = Price*0.9;

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE Products
SET Price = Price*0.9
WHERE Price >= 120;












