-- MAXDOP
-- Maximum Degree of Parallelism
-- Steuerung der Anzahl Prozessorkerne pro Abfrage
-- Parallelisierung passiert von alleine

-- Cost Threshold of Parallelism: Gibt die Kosten an die eine Abfrage haben muss, um parallelisiert zu werden
-- Maximum Degree of Parallelism: Gibt die Maximale Anzahl an Prozessorkerne an, die eine Abfrage verwenden darf

SET STATISTICS TIME, IO ON

SELECT Freight, FirstName, LastName
FROM M005_Kompression
WHERE Freight > (SELECT AVG(Freight) FROM M005_Kompression)
-- CPU-Zeit = 1092ms, verstrichene Zeit = 1286

-- Diese Abfrage wird parallelisiert durch die Zwei schwarzen Pfile in dem Gelben Kreis
-- Execution Plan

SELECT Freight, FirstName, LastName
FROM M005_Kompression
WHERE Freight > (SELECT AVG(Freight) FROM M005_Kompression)
OPTION(MAXDOP 1)
-- CPU-Zeit = 765 ms, verstrichene Zeit = 1896 ms.

SELECT Freight, FirstName, LastName
FROM M005_Kompression
WHERE Freight > (SELECT AVG(Freight) FROM M005_Kompression)
OPTION(MAXDOP 2)
-- CPU-Zeit = 984 ms, verstrichene Zeit = 1360 ms.


SELECT Freight, FirstName, LastName
FROM M005_Kompression
WHERE Freight > (SELECT AVG(Freight) FROM M005_Kompression)
OPTION(MAXDOP 4)
-- CPU-Zeit = 1046 ms, verstrichene Zeit = 1053 ms.

SELECT Freight, FirstName, LastName
FROM M005_Kompression
WHERE Freight > (SELECT AVG(Freight) FROM M005_Kompression)
OPTION(MAXDOP 8)
-- CPU-Zeit = 1063 ms, verstrichene Zeit = 1483 ms.