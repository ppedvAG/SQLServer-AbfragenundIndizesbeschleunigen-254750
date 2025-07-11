/*
	Dateigruppen:
	Datenbank aufteilen in mehrere Dateien, und verschiedene Datentr‰ger in weiterer Folge
	[PRIMARY]: Hauptgruppe, existiert immer, enth‰lt alle Files standardm‰ﬂig

	Das Hauptfile hat die Endung .mdf
	Weitere Files haben die Endung .ndf
	Log Files hat die Endung .ldf
*/

USE Demo5

/*
	Rechtsklick auf die Db -> Eigenschaften
	Dateigruppe
		- Hinzuf¸gen, Namen vergeben
	Dateien
		- Hinzuf¸gen, Name vergebene, Grˆﬂe anpassen usw..
*/

CREATE TABLE M002_FG2
(
	id int identity(1, 1),
	test char(4100)
)

INSERT INTO M002_FG2
VALUES('XYZ')
GO 20000

-- Wie verschiebe ich eine Tabelle auf eine andere Dateigruppe
-- Neu erstellen, Daten verschieen, Alte Tabelle lˆschen
CREATE TABLE M002_FG2_2
(
	id int identity(1, 1),
	test char(4100)
) on ZweiteGruppe

INSERT INTO M002_FG2_2
SELECT * FROM M002_FG2

-- Identity ausschalten per Designer
-- Tools -> Options -> Designer -> Prevent saving changes that requires Table re-creation -> Ausschalten

-- Salami Taktik
-- Groﬂe tabellen in kleinere Tabellen aufteilen

-- Partitionierte Sicht

CREATE TABLE M002_Umsatz
(
	datum date,
	umsatz float
)

BEGIN TRAN
DECLARE @i int = 0
WHILE @i < 100000
BEGIN
		INSERT INTO M002_Umsatz VALUES
		(DATEADD(DAY, FLOOR(RAND()* 1095), '01.01.2021'), RAND() * 1000)
		SET @i += 1
END 
commit

SELECT * FROM M002_Umsatz
ORDER BY DATUM desc

SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2021 -- Alle 100000 Zeilen m¸ssen durchsucht werden

------------------------------------
CREATE TABLE M002_Umsatz2021
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2021
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2021
------------------------------------

CREATE TABLE M002_Umsatz2022
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2022
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2022
------------------------------------

CREATE TABLE M002_Umsatz2023
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2023
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2023
------------------------------------

CREATE VIEW UmsatzGesamt
AS
SELECT * FROM M002_Umsatz2021
UNION ALL
SELECT * FROM M002_Umsatz2022
UNION ALL
SELECT * FROM M002_Umsatz2023

SET STATISTICS TIME, IO ON

SELECT * FROM UmsatzGesamt
WHERE YEAR(datum) = 2023
-- 3x logische Lesevorg‰nge 83 Seiten
-- CPU Zeit = 31ms, verstrichene Zeit = 156ms

SELECT * FROM M002_Umsatz
WHERE YEAR(datum) = 2023
-- logische Lesevorg‰nge 260 Seiten
-- CPU Zeit = 63ms, verstrichene Zeit = 181ms
