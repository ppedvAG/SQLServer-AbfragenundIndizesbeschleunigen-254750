-- Profiler
-- Live-Verfolgung was auf der DB passiert
-- Arthur: Wireshark f�r SQL

-- Extras => SQL Server Profiler

SELECT * FROM Customers

-- Einstellungen auf der ersten Seite setzen
-- Events ausw�hlen auf dem Zweiten Reiter
----StmtStarted
----StmtCompleted....

---- Nach der Trace -> Tuning Advisor �ffnen

-- Extras => Datenbankoptimierungsratgeber
-- Trace File hochladen oder Abfragespeicher ausw�hlen
-- Tuning Optionen => Indizes und/oder Partitionen ausw�hlen
-- Oben => Start Analyse
-- Aktionen => Empfehlungen �bernehmen