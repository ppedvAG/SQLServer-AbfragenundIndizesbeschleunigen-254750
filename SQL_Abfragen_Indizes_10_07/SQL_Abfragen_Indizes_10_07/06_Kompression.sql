-- Kompression

-- Daten verkleinern
--> Weniger Daten werden geladen, beim dekomprimieren wird CPU-Leistung verwendet

-- Row Compression: 50%
-- Page Compression: 75%


USE Northwind;
SELECT  Orders.OrderDate, Orders.RequiredDate, Orders.ShippedDate, Orders.Freight, Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.Address, Customers.City, 
        Customers.Region, Customers.PostalCode, Customers.Country, Customers.Phone, Orders.OrderID, Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.Title, [Order Details].UnitPrice, 
        [Order Details].Quantity, [Order Details].Discount, Products.ProductID, Products.ProductName, Products.UnitsInStock
INTO Demo5.dbo.M005_Kompression
FROM    [Order Details] INNER JOIN
        Products ON Products.ProductID = [Order Details].ProductID INNER JOIN
        Orders ON [Order Details].OrderID = Orders.OrderID INNER JOIN
        Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
        Customers ON Orders.CustomerID = Customers.CustomerID

USE Demo5

INSERT INTO M005_Kompression
SELECT * FROM M005_Kompression
GO 8

SELECT COUNT(*) FROM M005_Kompression

SET STATISTICS TIME, IO ON

-- Ohne Kompression
-- logische Lesevorgänge: 28288
-- CPU-Zeit = 1406ms, verstrichene Zeit = 8310ms
SELECT * FROM M005_Kompression

-- Row Compression
USE [Demo5]
ALTER TABLE [dbo].[M005_Kompression] REBUILD PARTITION = ALL
WITH
(DATA_COMPRESSION = ROW)

-- logische Lesevorgänge: 15842
-- CPU-Zeit = 2469ms, verstrichene Zeit = 7361ms
SELECT * FROM M005_Kompression

-- Page Compression
USE [Demo5]
ALTER TABLE [dbo].[M005_Kompression] REBUILD PARTITION = ALL
WITH
(DATA_COMPRESSION = PAGE)

-- logische Lesevorgänge: 7573
-- CPU-Zeit = 3329ms, verstrichene Zeit = 9332ms
SELECT * FROM M005_Kompression

-- Partitionen können auch komprimiert werden
SELECT OBJECT_NAME(OBJECT_ID), * FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')
WHERE compressed_page_count != 0

-- Alle Kompressionen ausgeben
SELECT t.name as TableName, p.partition_number as PartitionNumber, p.data_compression_desc AS Compression
FROM sys.partitions as p
JOIN sys.tables as t ON t.object_id = p.object_id