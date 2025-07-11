-- Query Store
-- Erstellt während des Normalbetriebs Statistiken zu Abfragen
-- Speichern Abfragen, Zeiten, Verbrauch, ...

-- Rechtsklick auf DB -> Eigenschaften -> Query Store -> Operation Mode -> RW

/*
	ALTER DATABASE <database_name>
	SET QUERY_STORE = ON (OPERATION_MODE = READ_WRITE);

	Löschen von QueryStore dateien:
	ALTER DATABASE [Name]
	SET QUERY_STORE CLEAR

	Durch Wartestatistiken erhalten Sie weitere Informationen, 
	die Ihnen bei der Problembehandlung der Leistung in der Datenbank-Engine helfen können. 
	Lange Zeit waren Wartestatistiken 
	nur auf Instanzebene verfügbar, 
	wodurch es schwierig war, sie einer bestimmten Abfrage zuzuordnen.

	Der Querystore hat 3 Speicher
	- einen Planspeicher, der die Informationen zum Ausführungsplan speichert
	- einen Speicher für Laufzeitstatistiken, der die Informationen zum Ausführungsstatistiken speichert
	- einen Speicher für Wartestatistiken, der die Informationen zum Wartestatistiken speichert

	Häufige Szenarios für die Verwendung des Abfragespeichers:

	- Schnelles Auffinden und Beheben von Regressionen der Planleistung durch Erzwingung des 
	  vorherigen Abfrageplans Korrigieren von Abfragen, die in der Vergangenheit 
	  aufgrund von Änderungen am Ausführungsplan die Leistung vermindert haben

	- Bestimmen der Ausführungshäufigkeit einer Abfrage in einem festgelegten 
	  Zeitraum mit Unterstützung eines DBAs bei der Behandlung von Leistungsproblemen mit Ressourcen

	- Identifizieren der häufigsten n Abfragen (nach Ausführungszeit, Speicherverbrauch usw.) in den letzten x Stunden.

	- Überwachen des Verlaufs von Abfrageplänen für eine bestimmte Abfrage

	- Analysieren der Verwendungsmuster einer Ressource (CPU, E/A und Arbeitsspeicher) für eine bestimmte Datenbank

	- Identifizieren Sie Top-N-Abfragen, die auf den Ressourcen warten.

	- Erhalten Sie Einblick in die Wartedetails einer bestimmten Abfrage oder eines bestimmten Plans.
*/
