-- Benötigte Tabelle M002_Umsatz
-- Partitionieren nach Datum: 2021-2022-2023
-- Partitionsfunktion benötigt & Partitionsschema benötigt

SELECT * FROM M002_Umsatz -- => M003_Umsatz

BEGIN TRAN
DECLARE @i int = 0
WHILE @i < 100000
BEGIN
		INSERT INTO M002_Umsatz VALUES
		(DATEADD(DAY, FLOOR(RAND()* 1095), '01.01.2021'), RAND() * 1000)
		SET @i += 1
END 
commit