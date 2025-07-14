/*
Was ist ein Columnstore Index?
- Ein Columnstore Index speichert Daten spaltenweise statt zeilenweise

=> Ideal f�r Analysen gro�er Datenmengen (Data Warehouse, Business Intelligence)


	Clustered Columnstore Index
	- Speichert die gesamte Tabelle spaltenweise
	- H�ufig f�r Fakten-Tabellen im Data Warehouse verwendet
	- Kein zus�tzlicher Rowstore vorhanden

	Nonclustered Columnstore Index
	- Erg�nzt eine Rowstore-Tabelle mit spaltemweise Zugriff


Beispiel f�r Rowstore (Zeilenbasiert)
[1, Anna, 24, Hamburg]
[2, Ben, 32, M�nchen]
[3, Carla, 29, Berlin]

Gut f�r?
- Einzelne Datens�tze bearbeiten
- Klassische Befehle wie INSERT, UPDATE, DELETE

Beispiel f�r Columnstore(Spaltenbasiert)
[1, 2, 3]        ? ID
[Anna, Ben, Carla] ? Name
[24, 32, 29]     ? Alter
[Hamburg, M�nchen, Berlin] ? Stadt

Gut f�r?
- Daten analyse z.B Durschnittsalter
- Gro�e Tabellen abfragen

Beispiel:

Rowstore:
z.B ein Buch mit Seiten, jede Seite ist eine Zeile => Rowstore

z.B vier Listen, eine Pro Spalte =>  Columnstore

| Kriterium                        | Rowstore             | Columnstore                   |
| -------------------------------- | -------------------- | ----------------------------- |
| Speicherung                      | Zeilenweise          | Spaltenweise                  |
| Ideal f�r                        | Transaktionen (OLTP) | Analysen, Auswertungen (OLAP) |
| Performance bei                  | Einzelzeilen-Zugriff | Gruppierte Datenabfragen      |
| Speicherverbrauch                | H�her                | Geringer (durch Kompression)  |
| Schreib-/Update-Performance      | Besser               | Schlechter                    |
| Lesegeschwindigkeit bei Abfragen | Normal               | Sehr schnell (bei Analysen)   |

*/