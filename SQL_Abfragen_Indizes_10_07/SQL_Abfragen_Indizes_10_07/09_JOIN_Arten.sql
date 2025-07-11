-- JOIN

/*
	SQL Server versucht aus einer Reihe von Ausführungsplänen,
	die er vorab ermittelt hat, den günstigstens herauszufinden

	Meist stimmt das. Allerdings können wir da "Auffälligkeiten" entdecken

	- unter anderem tauchen Sortieroperatoren auf, obwhol kein ORDER BY 
	zu finden war. Das kann an den JOIN Methoden liegen


	INNER HASH JOIN
	es wird eine hashtabelle zu ermitteln der übereinstimmenden
	JOIn Spalten der Tabelle

	INNER MERGE JOIN
	beide tabellen jeweils einmal gleichzeitig durchsuchen
	das kann aber nur funktionieren wenn sortiert
	(entweder durch CL Index oder sortier operator)


	INNER LOOP JOIN
	kleine Tabellen werden zeilenweise durchlaufen pro Zeile
	wird in der größeren Tabell nach dem Wert gesucht
	- gut, wenn eine Tabelle bzw (WHERE) Ergebnis sehr klein ist und
	die größere sortiert ist

*/

SELECT * FROM Customers c
INNER HASH JOIN Orders o ON c.CustomerID = o.CustomerID
-- Orders: logische Lesevorgänge 22
-- Customers: logische Lesevorgänge: 6
-- CPU-Zeit = 0ms, verstrichene Zeit = 111ms


SELECT * FROM Customers c
INNER MERGE JOIN Orders o ON c.CustomerID = o.CustomerID
-- Orders: logische Lesevorgänge 22
-- Customers: logische Lesevorgänge: 6
-- CPU-Zeit = 0ms, verstrichene Zeit = 118ms

SELECT * FROM Customers c
INNER LOOP JOIN Orders o ON c.CustomerID = o.CustomerID
-- Orders: logische Lesevorgänge: 1941
-- Customers: logische Lesevorgänge: 6
-- CPU-Zeit = 15ms, verstrichene Zeit = 161ms

SET STATISTICS TIME, IO ON