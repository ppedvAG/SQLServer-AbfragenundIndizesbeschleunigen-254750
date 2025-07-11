dbcc freeproccache
USE Northwind

-- Erstelle mir 2 Abfragen, wo die CustomerID von der Orders Tabelle gleich "HANAR"
SELECT * FROM Orders WHERE CustomerID = 'HANAR'
SELECT * FROM orders WHERE customerid = 'HANAR'
SELECT * FROM Orders WHERE customerID = 'HANAR'

-- Erstelle mir 1 Abfrage wo die OrderID 10, 300, 50000
-- P.S 3 Abfragen hier
SELECT * FROM Orders WHERE OrderID = 10
SELECT * FROM Orders WHERE OrderID = 300
SELECT * FROM Orders WHERE OrderID = 50000

SELECT usecounts, cacheobjtype,[TEXT] FROM
sys.dm_exec_cached_plans p CROSS APPLY
sys.dm_exec_sql_text(plan_handle)
WHERE cacheobjtype = 'Compiled Plan'
AND [Text] not like '%dm_exec_cached_plans%'

SELECT * FROM Customers WHERE City = 'Berlin'
SELECT * FROM Customers WHERE City = 'Paris'

-- Pläne werden als Hashwert gespeichert... blöd, wenn man mal groß und klein schreibt

DECLARE @city nvarchar(15)
SET @city = 'Berlin'
SELECT * FROM Customers WHERE City = @city

SET @city = 'Hamburg'
SELECT * FROM Customers WHERE City = @city


DECLARE @city1 nvarchar(15) = 'Paris'
SELECT * FROM Customers WHERE City = @city1
GO

CREATE PROCEDURE spKunden
@city nvarchar(15)
AS
SELECT * FROM Customers
WHERE City = @city
GO

EXEC spKunden Hamburg