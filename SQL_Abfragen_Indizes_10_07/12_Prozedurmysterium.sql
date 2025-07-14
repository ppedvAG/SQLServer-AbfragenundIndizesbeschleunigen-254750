-- Variante

--> Country varchar(20)
CREATE PROCEDURE sp_Blabla1
@CustomerID char(5), @CompanyName varchar(40),
@Country varchar(20), @City varchar(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC sp_Blabla1 '54321', 'ppedv Ag', 'GermanyGermanyGermany123', 'Berlin'
GO
SELECT * FROM Customers


-- Varianten
--> Country varchar(10)
CREATE PROCEDURE sp_BLABLA2
@CustomerID char(5), @CompanyName varchar(40),
@Country varchar(10), @City varchar(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC sp_BLABLA2 '54321', 'ppedv Ag', 'GermanyGermanyGermany123', 'Berlin'
SELECT * FROM Customers
