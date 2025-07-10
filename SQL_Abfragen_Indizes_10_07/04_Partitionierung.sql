/*

	Partitionierung:
	Aufteilung in "mehrere" Tabellen
	Einzelne Tabellen bleiben bestehen, aber intern durch Daten partitioniert

	Anforderungen:
	-- Partitionsfunktion: Stellt die Bereiche dar (0-100,101-200,201-Ende)
	-- Partitionsschema: Weist die einzelne Partition auf die Dateigruppen zu
*/

-- 0 - 100 - 200 - Ende
CREATE PARTITION FUNCTION pf_Zahl(int) AS
RANGE LEFT FOR VALUES (100, 200)

CREATE PARTITION SCHEME sch_ID as
Partition pf_Zahl TO (P1, P2, P3)

-- Dateigruppe per Code
ALTER DATABASE Demo5 ADD FILEGROUP P1
ALTER DATABASE Demo5 ADD FILEGROUP P2
ALTER DATABASE Demo5 ADD FILEGROUP P3

-- Dateien per Code
ALTER DATABASE Demo5
ADD FILE
(
	NAME = N'P1_Demo5',
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLKURS\MSSQL\DATA\P1_Demo5.ndf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB
)
TO FILEGROUP P1
--------------------------------------------
ALTER DATABASE Demo5
ADD FILE
(
	NAME = N'P2_Demo5',
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLKURS\MSSQL\DATA\P2_Demo5.ndf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB
)
TO FILEGROUP P2
--------------------------------------------
ALTER DATABASE Demo5
ADD FILE
(
	NAME = N'P3_Demo5',
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLKURS\MSSQL\DATA\P3_Demo5.ndf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB
)
TO FILEGROUP P3
---------------------
-- Hier muss die Tabelle auf das Schema gelegt werden
CREATE TABLE M003_Test
(
	id int identity(1, 1),
	zahl float
) ON sch_ID(id)

BEGIN TRAN
DECLARE @i INT = 0;
WHILE @i < 1000
BEGIN
	INSERT INTO M003_Test VALUES(RAND() * 1000)
	SET @i += 1
END
COMMIT

-- Nichts besonderes zu sehen
SELECT * FROM M003_Test

-- Hier durchsucht er nur die Partitionsebene (100DS)
SELECT * FROM M003_Test
WHERE id < 50

-- Übersichtüber Partition verschaffen
SELECT OBJECT_NAME(OBJECT_ID), * FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')

SELECT $partition.pf_Zahl(50)
SELECT $partition.pf_Zahl(150)
SELECT $partition.pf_Zahl(250)

-- Pro Datensatz die Partition + Filegroup anhängen
SELECT * FROM M003_Test t
JOIN
(
	SELECT name, ips.partition_number
	FROM sys.filegroups fg --Name

	JOIN sys.allocation_units au
	ON fg.data_space_id = au.data_space_id

	JOIN sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED') ips
	ON ips.hobt_id = au.container_id

	WHERE OBJECT_NAME(ips.object_id) = 'M003_Test'
) x
ON $partition.pf_Zahl(t.id) = x.partition_number
