/*
	Datentypen in SQL: In 3 Große Gruppen

	1. Charakter/String Datentypen:
	- char(10) = 'Hallo     ' = 10 Byte Speicherplatz => UTF-8
	- varchar(10) = 'Hallo' = 5 Byte Speicherplatz => UTF-8

	- nchar(10) => 1 Zeichen = 2 Byte = 20 Byte => UTF-16
	- nvarchar(10) => 1 Zeichen = 2 Byte => UTF-16

	Legacy: text --> mittlerweile VARCHAR(MAX) = 2 GB
	VARCHAR(8000) & nvarchar(4000) sind maximum


	2. Numerischen Datentypen
	- tinyint = 1 Byte		0-255
	- smallint  = 2 Byte	-32k | 32k
	- int = 4 Byte			-2,14Mrd | +2,14Mrd
	- bigint = 8 Byte		-9,2 Trl | +9,2 Trl

	- bit = 1 oder 0 (True = 1, False = 0) => Es gibt kein Bool

	- float(n) = 53
	- 1 - 24 = 7 Stellen = 4 Byte
	- 25 - 53 = 15 Stellen = 8 Byte

	- decimal(x, y) = x Ziffern insgesamt, davon sind y Nachkommastellen
	- decimal(10, 2) = 10 Ziffern insgesamt, davon sind 2 Nachkommastellen

	- money = ca. 9,2 Trillion
	- smallmoney = ca. 214K


	3. Datum/Zeit Datentypen
	- time = hh:mm:ss.nnnnnnn
	- date = YYYY-MM-DD
	- datetime = date + time in MS = YYYY-MM-DD hh:mm:ss.mmm
	- datetime2 = YYYY-MM-DD hh:mm:ss.nnnnnnn
	- smalldatetime = YYYY-MM-DD hh:mm:ss

	Andere:
	- XML
	- JSON
	- geometry
	- geography

*/