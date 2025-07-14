/*
Was ist ein Columnstore Index?
- Ein Columnstore Index speichert Daten spaltenweise statt zeilenweise

=> Ideal für Analysen großer Datenmengen (Data Warehouse, Business Intelligence)


	Clustered Columnstore Index
	- Speichert die gesamte Tabelle spaltenweise
	- Häufig für Fakten-Tabellen im Data Warehouse verwendet
	- Kein zusätzlicher Rowstore vorhanden

	Nonclustered Columnstore Index
	- Ergänzt eine Rowstore-Tabelle mit spaltemweise Zugriff


Beispiel für Rowstore (Zeilenbasiert)
[1, Anna, 24, Hamburg]
[2, Ben, 32, München]
[3, Carla, 29, Berlin]

Gut für?
- Einzelne Datensätze bearbeiten
- Klassische Befehle wie INSERT, UPDATE, DELETE

Beispiel für Columnstore(Spaltenbasiert)
[1, 2, 3]        ? ID
[Anna, Ben, Carla] ? Name
[24, 32, 29]     ? Alter
[Hamburg, München, Berlin] ? Stadt

Gut für?
- Daten analyse z.B Durschnittsalter
- Große Tabellen abfragen

Beispiel:

Rowstore:
z.B ein Buch mit Seiten, jede Seite ist eine Zeile => Rowstore

z.B vier Listen, eine Pro Spalte =>  Columnstore

| Kriterium                        | Rowstore             | Columnstore                   |
| -------------------------------- | -------------------- | ----------------------------- |
| Speicherung                      | Zeilenweise          | Spaltenweise                  |
| Ideal für                        | Transaktionen (OLTP) | Analysen, Auswertungen (OLAP) |
| Performance bei                  | Einzelzeilen-Zugriff | Gruppierte Datenabfragen      |
| Speicherverbrauch                | Höher                | Geringer (durch Kompression)  |
| Schreib-/Update-Performance      | Besser               | Schlechter                    |
| Lesegeschwindigkeit bei Abfragen | Normal               | Sehr schnell (bei Analysen)   |

*/