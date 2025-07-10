/*
	Seite: 8kB = 8192B
	132B sind Management Daten
	8060B sind tatsächliche Daten
	8 Seiten = 1 Block

	Max. DS = 700
	Datensätze müssen komplett auf die Seite passen + leerer Raum darf existieren
	muss aber minimiert werden
*/

--- dbcc: Database Console Commands
-- showcontig: Zeigt Seiteninformatioen über ein Datenbankobjekt -> Seitendichte messen

dbcc showcontig('Orders')

-- Messungen
SET STATISTICS TIME, IO OFF -- Anzahl der Seiten
		-- Dauer in ms von CPU und Gesamtzeit

SELECT * FROM Orders

CREATE DATABASE Demo5

USE Demo5

CREATE TABLE M001_Test1
(
	ID int identity(1, 1),
	test char(4100)
)

-- Absichtlich ineffiziente Tabelle
INSERT INTO M001_Test1
values('xyz')
GO 20000

dbcc showcontig('M001_Test1') -- Seiten: 20000


CREATE TABLE M001_Test2
(
	ID int identity(1, 1),
	test varchar(4100)
)

INSERT INTO M001_Test2
values('xyz')
GO 20000

dbcc showcontig('M001_Test2') -- Seiten: 52

CREATE TABLE M001_Test3
(
	id int identity(1, 1),
	test nvarchar(max)
)

INSERT INTO M001_Test3
VALUES('XYZ')
GO 20000

dbcc showcontig('M001_Test3')

SET STATISTICS TIME, IO ON

-- alle Datensätze der Tabelle Orders aus dem Jahr 1997 (OrderDate)
USE Northwind

-- Option 1:
-- logische Lesevorgänge: 22
-- CPU-Zeit = 0ms, verstrichene Zeit = 86ms
SELECT * FROM Orders
WHERE OrderDate >= '01.01.1997 00:00:00.000' AND OrderDate <= '31.12.1997 23:59:59.997' 

-- Option 2:
-- logische Lesevorgänge: 22
-- CPU-Zeit = 0ms, verstrichene Zeit = 55ms
SELECT * FROM Orders
WHERE OrderDate BETWEEN '01.01.1997' AND '31.12.1997 23:59:59:997'

-- Option 3:
-- Logische Lesevorgänge: 22
-- CPU-Zeit = 0ms, verstrichene Zeit = 76ms
SELECT * FROM Orders
WHERE YEAR(OrderDate) = 1997

SELECT * FROM Orders

USE Demo5

CREATE TABLE M001_TestDecimal
(
	id int IDENTITY(1, 1),
	zahl decimal(10, 2)
)

-- Schnellere Variante
BEGIN TRAN
DECLARE @i int = 0
while @i < 20000
BEGIN
	INSERT INTO M001_TestDecimal VALUES(2.2)
	SET @i += 1
END
COMMIT;

dbcc showcontig('M001_TestDecimal') -- Seiten: 58