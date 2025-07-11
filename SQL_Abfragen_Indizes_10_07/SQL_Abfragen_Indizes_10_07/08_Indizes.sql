-- Index

/*
	Table Scan: Durchsucht die gesamte Tabelle von oben nach unten (langsam)
	Index Scan: Durchsucht bestimmte Bereiche der Tabelle (besser)
	Index Seek: Geht in einen Index gezielt rein und holt sich die Daten raus (am besten)

	Gruppierten Index / Clustered Index
	- Normaler Index, welcher sich immer selbst sortiert
	- bei Insert/Update/Delete werden die Daten herumgeschoben
	Existiert nur einmal pro Tabelle
	Standardmäßig auf den Primary Key erstellt
	-> Kostet performance

	Wann brauch ich den gruppierten Index:
	- Sehr gut bei Abfragen nach Bereichen und rel. Großen Ergebnismengen, <, >, between, like


	Nicht-gruppierten Index / Non-Clustered Index
	- Standardindex
	- Zwei Komponenten, Schlüsselspalten, inkludierten Spalten
	Anhand der Komponenten entscheidet die DB ob der Index verwendet wird

	Wann brauch ich den Nicht-gruppierten Index:
	- Sehr gut bei Abfragen auf rel. eindeutige Werte bzw geringe Ergebnismenge
	- Kann mehrfach verwendet werden (999-mal)
*/

SELECT * 
INTO M006_Index
FROM M005_Kompression

USE Demo5

SET STATISTICS TIME, IO ON

-- Table scan
SELECT * FROM M006_Index

SELECT * FROM M006_Index
WHERE OrderID >= 11000
-- Cost: 21,8, logische Lesevorgänge = 28325, CPU-Zeit = 343ms, verstrichene Zeit = 831ms

-- Neuer Index: NCIX_OrderID
SELECT * FROM M006_Index
WHERE OrderID >= 11000
-- Index Seek
-- Cost: 2,18, logische Lesevorgänge = 2888, CPU-Zeit = 110ms, verstrichene Zeit = 799ms

-- Indizes Anschauen
SELECT OBJECT_NAME(OBJECT_ID), index_level, page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')
WHERE OBJECT_NAME(object_id) = 'M006_Index'

SELECT CompanyName, ContactName, ProductName, Quantity * UnitPrice
FROM M006_Index
WHERE ProductName = 'Chocolade'
-- Cost: 21,24, logische Lesevorgänge = 28325, CPU-Zeit = 139ms, verstrichene Zeit = 82ms

SELECT CompanyName, ContactName, ProductName, Quantity * UnitPrice
FROM M006_Index
WHERE ProductName = 'Chocolade'
-- Index Seek:
-- Cost: 0,02, logische Lesevorgänge = 26, CPU-Zeit = 16ms, verstrichene Zeit = 77ms


-- Was wenn ich eine Spalte entferne?
-- => Indexseek
SELECT ContactName, ProductName, Quantity * UnitPrice
FROM M006_Index
WHERE ProductName = 'Chocolade'

SELECT ContactName, ProductName, Quantity * UnitPrice, Freight
FROM M006_Index
WHERE ProductName = 'Chocolade'
-- Index Seek + Lookup => Muss das Telefonbuch durchtelefonieren :) :
-- Cost: 4,94, logische Lesevorgänge = 1526, CPU-Zeit = 16ms, verstrichene Zeit = 83ms

-- Indizierte Sicht
-- View mit Index
-- Benötigen Schemabinding
-- WITH SCHEMABINDING: Solange die View existiert, kann die Tabellenstruktur nicht verändern werden
ALTER TABLE M006_Index ADD id int identity
GO

CREATE VIEW Adressen WITH SCHEMABINDING
AS
SELECT id, CompanyName, Address, City, Region, PostalCode, Country
FROM dbo.M006_Index
GO

-- Clustered Index
SELECT * FROM Adressen

-- ???
SELECT id, CompanyName, Address, City, Region, PostalCode, Country
FROM dbo.M006_Index
GO

CREATE VIEW Adressen2 WITH SCHEMABINDING
AS
SELECT id, CompanyName, Address, City, Region, PostalCode, Country, ContactTitle
FROM dbo.M006_Index
WHERE id = 3

SELECT * FROm Adressen2

SELECT id, CompanyName, Address, City, Region, PostalCode, Country
FROM dbo.M006_Index
where id = 3

-- Clustered Index Insert
INSERT INTO M006_Index (FirstName, Lastname, EmployeeID, OrderID ,CustomerID, CompanyName, Address, City, Region, PostalCode, Country)
VALUES ('Philipp', 'Libowicz', 10, 99999,'12345','PPEDV', 'Eine Straße', 'Irgendwo', NULL, NULL, NULL)


DELETE FROM M006_Index
WHERE ID = 75218

SELECT * FROM M006_Index
WHERE ID = 75218