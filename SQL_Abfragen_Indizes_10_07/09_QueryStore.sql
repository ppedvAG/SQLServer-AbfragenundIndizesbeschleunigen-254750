-- Query Store
-- Erstellt w�hrend des Normalbetriebs Statistiken zu Abfragen
-- Speichern Abfragen, Zeiten, Verbrauch, ...

-- Rechtsklick auf DB -> Eigenschaften -> Query Store -> Operation Mode -> RW

/*
	ALTER DATABASE <database_name>
	SET QUERY_STORE = ON (OPERATION_MODE = READ_WRITE);

	L�schen von QueryStore dateien:
	ALTER DATABASE [Name]
	SET QUERY_STORE CLEAR

	Durch Wartestatistiken erhalten Sie weitere Informationen, 
	die Ihnen bei der Problembehandlung der Leistung in der Datenbank-Engine helfen k�nnen. 
	Lange Zeit waren Wartestatistiken 
	nur auf Instanzebene verf�gbar, 
	wodurch es schwierig war, sie einer bestimmten Abfrage zuzuordnen.

	Der Querystore hat 3 Speicher
	- einen Planspeicher, der die Informationen zum Ausf�hrungsplan speichert
	- einen Speicher f�r Laufzeitstatistiken, der die Informationen zum Ausf�hrungsstatistiken speichert
	- einen Speicher f�r Wartestatistiken, der die Informationen zum Wartestatistiken speichert

	H�ufige Szenarios f�r die Verwendung des Abfragespeichers:

	- Schnelles Auffinden und Beheben von Regressionen der Planleistung durch Erzwingung des 
	  vorherigen Abfrageplans Korrigieren von Abfragen, die in der Vergangenheit 
	  aufgrund von �nderungen am Ausf�hrungsplan die Leistung vermindert haben

	- Bestimmen der Ausf�hrungsh�ufigkeit einer Abfrage in einem festgelegten 
	  Zeitraum mit Unterst�tzung eines DBAs bei der Behandlung von Leistungsproblemen mit Ressourcen

	- Identifizieren der h�ufigsten n Abfragen (nach Ausf�hrungszeit, Speicherverbrauch usw.) in den letzten x Stunden.

	- �berwachen des Verlaufs von Abfragepl�nen f�r eine bestimmte Abfrage

	- Analysieren der Verwendungsmuster einer Ressource (CPU, E/A und Arbeitsspeicher) f�r eine bestimmte Datenbank

	- Identifizieren Sie Top-N-Abfragen, die auf den Ressourcen warten.

	- Erhalten Sie Einblick in die Wartedetails einer bestimmten Abfrage oder eines bestimmten Plans.
*/
