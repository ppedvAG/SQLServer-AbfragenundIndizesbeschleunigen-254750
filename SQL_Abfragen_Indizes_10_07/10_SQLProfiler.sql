-- Profiler
-- Live-Verfolgung was auf der DB passiert
-- Arthur: Wireshark für SQL

-- Extras => SQL Server Profiler

SELECT * FROM Customers

-- Einstellungen auf der ersten Seite setzen
-- Events auswählen auf dem Zweiten Reiter
----StmtStarted
----StmtCompleted....

---- Nach der Trace -> Tuning Advisor öffnen

-- Extras => Datenbankoptimierungsratgeber
-- Trace File hochladen oder Abfragespeicher auswählen
-- Tuning Optionen => Indizes und/oder Partitionen auswählen
-- Oben => Start Analyse
-- Aktionen => Empfehlungen übernehmen