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

-- Hier die Functions ID von der Partitionsfunktion
SELECT * FROM sys.partition_functions
WHERE name = 'pf_Zahl'

-- Hier die Functions ID einsetzen, um die Schemas zu finden
SELECT * FROM sys.partition_schemes
WHERE function_id = 65536


-----------------------------------
CREATE PARTITION FUNCTION pf_Datum(date) as
RANGE LEFT FOR VALUES ('31.12.2021', '31.12.2022', '31.12.2023')

CREATE PARTITION SCHEME sch_Datum AS
PARTITION pf_Datum TO (P1_Datum, P2_Datum, P3_Datum, P4_Datum)

CREATE TABLE M003_Umsatz
(
	datum date,
	umsatz float
) on sch_Datum(datum)

--INSERT INTO M003_Umsatz
--SELECT * FROM M002_Umsatz
SELECT * FROM M003_Umsatz t
JOIN
(
	SELECT name, ips.partition_number
	FROM sys.filegroups fg --Name

	JOIN sys.allocation_units au
	ON fg.data_space_id = au.data_space_id

	JOIN sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED') ips
	ON ips.hobt_id = au.container_id

	WHERE OBJECT_NAME(ips.object_id) = 'M003_Umsatz'
) x
ON $partition.pf_Datum(t.datum) = x.partition_number

SELECT * FROM M003_Umsatz 
WHERE datum BETWEEN '01.01.2022' AND '31.12.2022'


SELECT * FROM M003_Umsatz
WHERE DATEPART(YEAR, datum) = 2021