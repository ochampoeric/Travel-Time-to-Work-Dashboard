CREATE DATABASE Testin;

USE Testin;

CREATE TABLE Travel_Time (
Object_Id INT,
Geospatial_Id VARCHAR(11),
State_FIPS_Code INT,
County_FIPS_Code INT,
Tract_Code_Extension MEDIUMINT,
Tract_Id FLOAT,
Name_LSAD VARCHAR(20),
Name VARCHAR(80),
Total_Workers INT, 
Travel_Time_0_9 INT,
Travel_Time_10_19 INT,
Travel_Time_20_29 INT,
Travel_Time_30_44 INT,
Travel_Time_45_59 INT,
Travel_Time_60_89 INT,
Travel_Time_90_up INT,
Travel_Time_0_9_Pct FLOAT,
Travel_Time_10_19_Pct FLOAT,
Travel_Time_20_29_Pct FLOAT,
Travel_Time_30_44_Pct FLOAT,
Travel_Time_45_59_Pct FLOAT,
Travel_Time_60_89_Pct FLOAT,
Travel_Time_90_up_Pct FLOAT,
Shape_Length DOUBLE,
Shape_Area DOUBLE
);

CREATE TABLE Transportation (
	Object_Id INT,
	Geospatial_Id VARCHAR(11),
	State_FIPS_Code INT,
	County_FIPS_Code INT,
	Tract_Code_Extension MEDIUMINT,
	Tract_Id FLOAT,
	Name_LSAD VARCHAR(20),
	Name VARCHAR(80),
	Total_Transport INT, 
	Cars_Truck_Van INT,
	Cars_Truck_Van_Alone INT,
	Cars_Truck_Van_Carpool INT,
	Public_Transportation INT,
	Bicycle INT,
	Walking INT,
	Other_Means INT,
    	Work_From_Home INT,
	Cars_Truck_Van_Pct FLOAT,
	Cars_Truck_Van_Alone_Pct FLOAT,
	Cars_Truck_Van_Carpool_Pct FLOAT,
	Public_Transportation_Pct FLOAT,
	Bicycle_Pct FLOAT,
	Walking_Pct FLOAT,
	Other_Means_Pct FLOAT,
    	Work_From_Home_Pct FLOAT,
	Shape_Length DOUBLE,
	Shape_Area DOUBLE
);

# Loading CSV Files Into the Tables:

LOAD DATA LOCAL INFILE 'Users/ocampo/Desktop/Portfolio/Travel_Time_To_Work.csv'
INTO TABLE Travel_Time
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 

LOAD DATA LOCAL INFILE 'Users/ocampo/Desktop/Portfolio/Means_of_Transportation_to_Work.csv'
INTO TABLE Transportation
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 

# Side Quest! Check That Columns (To Be Deleted) Are Equal:

SELECT TT.Name, T.Name
FROM Travel_Time TT
LEFT JOIN Transportation T ON T.name = TT.name
WHERE T.Name IS NULL;

SELECT 
	TT.Object_Id, T.Object_Id,
	TT.Geospatial_Id, T.Geospatial_Id,
	TT.State_FIPS_Code, T.State_FIPS_Code,
	TT.County_FIPS_Code, T.County_FIPS_Code,
	TT.Tract_Code_Extension, T.Tract_Code_Extension,
	TT.Tract_Id, T.Tract_Id,
	TT.Name_LSAD, T.Name_LSAD,
	TT.Name, T.Name,
    TT.Shape_Length, T.Shape_Length,
	TT.Shape_Area, T.Shape_Area
FROM Travel_Time TT
LEFT JOIN Transportation T ON T.name = TT.name
WHERE TT.Object_Id != T.Object_Id OR
	TT.Geospatial_Id != T.Geospatial_Id OR
	TT.State_FIPS_Code != T.State_FIPS_Code OR
	TT.County_FIPS_Code != T.County_FIPS_Code OR
	TT.Tract_Code_Extension != T.Tract_Code_Extension OR
	TT.Tract_Id != T.Tract_Id OR
	TT.Name_LSAD != T.Name_LSAD OR
    	TT.Shape_Length != T.Shape_Length OR
	TT.Shape_Area != T.Shape_Area;

#Deleting Unnecessary Columns:

ALTER TABLE Travel_Time
DROP COLUMN Object_Id,
DROP COLUMN State_FIPS_Code,
DROP COLUMN County_FIPS_Code,
DROP COLUMN Tract_Code_Extension,
DROP COLUMN Tract_Id,
DROP COLUMN Name_LSAD,
DROP COLUMN Shape_Length,
DROP COLUMN Shape_Area;

ALTER TABLE Transportation
DROP COLUMN Object_Id,
DROP COLUMN Geospatial_Id,
DROP COLUMN State_FIPS_Code,
DROP COLUMN County_FIPS_Code,
DROP COLUMN Tract_Code_Extension,
DROP COLUMN Tract_Id,
DROP COLUMN Name_LSAD,
DROP COLUMN Shape_Length,
DROP COLUMN Shape_Area;

# Checking for Duplicates:

SELECT
	COUNT(*)
FROM
    Travel_Time
GROUP BY
Name,
    Total_Workers, 
	Travel_Time_0_9,
	Travel_Time_10_19,
	Travel_Time_20_29,
	Travel_Time_30_44,
	Travel_Time_45_59,
	Travel_Time_60_89,
	Travel_Time_90_up
HAVING COUNT(*) > 1;

SELECT
	COUNT(*)
FROM
    Transportation
GROUP BY
	Name,
Total_Transport , 
	Cars_Truck_Van ,
	Cars_Truck_Van_Alone ,
	Cars_Truck_Van_Carpool ,
	Public_Transportation ,
	Bicycle ,
	Walking ,
	Other_Means ,
    	Work_From_Home
HAVING COUNT(*) > 1;

# Joining Tables:

CREATE TABLE Travel_Info (
	Name VARCHAR(80),
    Geospatial_Id VARCHAR(11),
    Total_Workers INT, 
	Travel_Time_0_9 INT,
	Travel_Time_10_19 INT,
	Travel_Time_20_29 INT,
	Travel_Time_30_44 INT,
	Travel_Time_45_59 INT,
	Travel_Time_60_89 INT,
	Travel_Time_90_up INT,
    Total_Transport INT, 
	Cars_Truck_Van INT,
	Cars_Truck_Van_Alone INT,
	Cars_Truck_Van_Carpool INT,
	Public_Transportation INT,
	Bicycle INT,
	Walking INT,
	Other_Means INT,
	Work_From_Home INT,
    Travel_Time_0_9_Pct FLOAT,
	Travel_Time_10_19_Pct FLOAT,
	Travel_Time_20_29_Pct FLOAT,
	Travel_Time_30_44_Pct FLOAT,
	Travel_Time_45_59_Pct FLOAT,
	Travel_Time_60_89_Pct FLOAT,
	Travel_Time_90_up_Pct FLOAT,
	Cars_Truck_Van_Pct FLOAT,
	Cars_Truck_Van_Alone_Pct FLOAT,
	Cars_Truck_Van_Carpool_Pct FLOAT,
	Public_Transportation_Pct FLOAT,
	Bicycle_Pct FLOAT,
	Walking_Pct FLOAT,
	Other_Means_Pct FLOAT,
	Work_From_Home_Pct FLOAT
);

INSERT INTO Travel_Info (
	Name,
    Geospatial_Id, 
    Total_Workers, 
	Travel_Time_0_9,
	Travel_Time_10_19,
	Travel_Time_20_29,
	Travel_Time_30_44,
	Travel_Time_45_59,
	Travel_Time_60_89,
	Travel_Time_90_up,
    Total_Transport, 
	Cars_Truck_Van,
	Cars_Truck_Van_Alone,
	Cars_Truck_Van_Carpool,
	Public_Transportation,
	Bicycle,
	Walking,
	Other_Means,
	Work_From_Home,
    Travel_Time_0_9_Pct,
	Travel_Time_10_19_Pct,
	Travel_Time_20_29_Pct,
	Travel_Time_30_44_Pct,
	Travel_Time_45_59_Pct,
	Travel_Time_60_89_Pct,
	Travel_Time_90_up_Pct,
    Cars_Truck_Van_Pct,
	Cars_Truck_Van_Alone_Pct,
	Cars_Truck_Van_Carpool_Pct,
	Public_Transportation_Pct,
	Bicycle_Pct,
	Walking_Pct,
	Other_Means_Pct,
	Work_From_Home_Pct
)
SELECT 
	TT.Name,
TT.Geospatial_Id,
    TT.Total_Workers, 
	TT.Travel_Time_0_9,
	TT.Travel_Time_10_19,
	TT.Travel_Time_20_29,
	TT.Travel_Time_30_44,
	TT.Travel_Time_45_59,
	TT.Travel_Time_60_89,
	TT.Travel_Time_90_up,
    T.Total_Transport, 
	T.Cars_Truck_Van,
	T.Cars_Truck_Van_Alone,
	T.Cars_Truck_Van_Carpool,
	T.Public_Transportation,
	T.Bicycle,
	T.Walking,
	T.Other_Means,
	T.Work_From_Home,
    TT.Travel_Time_0_9_Pct,
	TT.Travel_Time_10_19_Pct,
	TT.Travel_Time_20_29_Pct,
	TT.Travel_Time_30_44_Pct,
	TT.Travel_Time_45_59_Pct,
	TT.Travel_Time_60_89_Pct,
	TT.Travel_Time_90_up_Pct,
	T.Cars_Truck_Van_Pct,
	T.Cars_Truck_Van_Alone_Pct,
	T.Cars_Truck_Van_Carpool_Pct,
	T.Public_Transportation_Pct,
	T.Bicycle_Pct,
	T.Walking_Pct,
	T.Other_Means_Pct,
	T.Work_From_Home_Pct
FROM Travel_Time TT
LEFT JOIN Transportation T ON TT.Name = T.Name;

# Separating the location information into State and County:

ALTER TABLE Travel_Info
ADD COLUMN State VARCHAR(40),
ADD COLUMN County VARCHAR(40),
ADD COLUMN Census_Tract VARCHAR(40);

UPDATE Travel_Info
SET
	State = SUBSTRING_INDEX(Name, ', ', -1),
    County = SUBSTRING_INDEX(SUBSTRING_INDEX(Name, ', ', 2), ', ', -1),
	Census_Tract = SUBSTRING_INDEX(Name, ', ', 1);

ALTER TABLE Travel_Info
DROP COLUMN Name;

# Now we can delete Puerto Rico:

DELETE FROM Travel_Info
WHERE State = 'Puerto Rico';

# Creating Table for Percentages:
CREATE TABLE US_Percentages (
	State VARCHAR(40),
	Travel_Time_0_9_Pct FLOAT,
	Travel_Time_10_19_Pct FLOAT,
	Travel_Time_20_29_Pct FLOAT,
	Travel_Time_30_44_Pct FLOAT,
	Travel_Time_45_59_Pct FLOAT,
	Travel_Time_60_89_Pct FLOAT,
	Travel_Time_90_up_Pct FLOAT,
    Cars_Truck_Van_Pct FLOAT,
	Cars_Truck_Van_Alone_Pct FLOAT,
	Cars_Truck_Van_Carpool_Pct FLOAT,
	Public_Transportation_Pct FLOAT,
	Bicycle_Pct FLOAT,
	Walking_Pct FLOAT,
	Other_Means_Pct FLOAT,
	Work_From_Home_Pct FLOAT
);

INSERT INTO US_Percentages (
	State,
	Travel_Time_0_9_Pct,
	Travel_Time_10_19_Pct,
	Travel_Time_20_29_Pct,
	Travel_Time_30_44_Pct,
	Travel_Time_45_59_Pct,
	Travel_Time_60_89_Pct,
	Travel_Time_90_up_Pct,
    Cars_Truck_Van_Pct,
	Cars_Truck_Van_Alone_Pct,
	Cars_Truck_Van_Carpool_Pct,
	Public_Transportation_Pct,
	Bicycle_Pct,
	Walking_Pct,
	Other_Means_Pct,
	Work_From_Home_Pct
)
SELECT 
	'United States' AS State,
	SUM(Travel_Time_0_9)/SUM(Total_Workers),
    SUM(Travel_Time_10_19)/SUM(Total_Workers),
    SUM(Travel_Time_20_29)/SUM(Total_Workers),
    SUM(Travel_Time_30_44)/SUM(Total_Workers),
    SUM(Travel_Time_45_59)/SUM(Total_Workers),
    SUM(Travel_Time_60_89)/SUM(Total_Workers),
    SUM(Travel_Time_90_up)/SUM(Total_Workers),
    SUM(Cars_Truck_Van)/SUM(Total_Transport),
	SUM(Cars_Truck_Van_Alone)/SUM(Total_Transport),
	SUM(Cars_Truck_Van_Carpool)/SUM(Total_Transport),
	SUM(Public_Transportation)/SUM(Total_Transport),
	SUM(Bicycle)/SUM(Total_Transport),
	SUM(Walking)/SUM(Total_Transport),
	SUM(Other_Means)/SUM(Total_Transport),
	SUM(Work_From_Home)/SUM(Total_Transport)
FROM Travel_Info;

CREATE TABLE State_Percentages (
	State VARCHAR(40),
	Travel_Time_0_9_Pct FLOAT,
	Travel_Time_10_19_Pct FLOAT,
	Travel_Time_20_29_Pct FLOAT,
	Travel_Time_30_44_Pct FLOAT,
	Travel_Time_45_59_Pct FLOAT,
	Travel_Time_60_89_Pct FLOAT,
	Travel_Time_90_up_Pct FLOAT,
    Cars_Truck_Van_Pct FLOAT,
	Cars_Truck_Van_Alone_Pct FLOAT,
	Cars_Truck_Van_Carpool_Pct FLOAT,
	Public_Transportation_Pct FLOAT,
	Bicycle_Pct FLOAT,
	Walking_Pct FLOAT,
	Other_Means_Pct FLOAT,
	Work_From_Home_Pct FLOAT
);

INSERT INTO State_Percentages (
	State,
	Travel_Time_0_9_Pct,
	Travel_Time_10_19_Pct,
	Travel_Time_20_29_Pct,
	Travel_Time_30_44_Pct,
	Travel_Time_45_59_Pct,
	Travel_Time_60_89_Pct,
	Travel_Time_90_up_Pct,
    Cars_Truck_Van_Pct,
	Cars_Truck_Van_Alone_Pct,
	Cars_Truck_Van_Carpool_Pct,
	Public_Transportation_Pct,
	Bicycle_Pct,
	Walking_Pct,
	Other_Means_Pct,
	Work_From_Home_Pct
)
SELECT 
	State,
	SUM(Travel_Time_0_9)/SUM(Total_Workers),
    SUM(Travel_Time_10_19)/SUM(Total_Workers),
    SUM(Travel_Time_20_29)/SUM(Total_Workers),
    SUM(Travel_Time_30_44)/SUM(Total_Workers),
    SUM(Travel_Time_45_59)/SUM(Total_Workers),
    SUM(Travel_Time_60_89)/SUM(Total_Workers),
    SUM(Travel_Time_90_up)/SUM(Total_Workers),
    SUM(Cars_Truck_Van)/SUM(Total_Transport),
	SUM(Cars_Truck_Van_Alone)/SUM(Total_Transport),
	SUM(Cars_Truck_Van_Carpool)/SUM(Total_Transport),
	SUM(Public_Transportation)/SUM(Total_Transport),
	SUM(Bicycle)/SUM(Total_Transport),
	SUM(Walking)/SUM(Total_Transport),
	SUM(Other_Means)/SUM(Total_Transport),
	SUM(Work_From_Home)/SUM(Total_Transport)
FROM Travel_Info
GROUP BY State;

CREATE TABLE County_Percentages (
	State VARCHAR(40),
    County VARCHAR(40),
	Travel_Time_0_9_Pct FLOAT,
	Travel_Time_10_19_Pct FLOAT,
	Travel_Time_20_29_Pct FLOAT,
	Travel_Time_30_44_Pct FLOAT,
	Travel_Time_45_59_Pct FLOAT,
	Travel_Time_60_89_Pct FLOAT,
	Travel_Time_90_up_Pct FLOAT,
    Cars_Truck_Van_Pct FLOAT,
	Cars_Truck_Van_Alone_Pct FLOAT,
	Cars_Truck_Van_Carpool_Pct FLOAT,
	Public_Transportation_Pct FLOAT,
	Bicycle_Pct FLOAT,
	Walking_Pct FLOAT,
	Other_Means_Pct FLOAT,
	Work_From_Home_Pct FLOAT
);

INSERT INTO County_Percentages (
	State,
    County,
	Travel_Time_0_9_Pct,
	Travel_Time_10_19_Pct,
	Travel_Time_20_29_Pct,
	Travel_Time_30_44_Pct,
	Travel_Time_45_59_Pct,
	Travel_Time_60_89_Pct,
	Travel_Time_90_up_Pct,
    Cars_Truck_Van_Pct,
	Cars_Truck_Van_Alone_Pct,
	Cars_Truck_Van_Carpool_Pct,
	Public_Transportation_Pct,
	Bicycle_Pct,
	Walking_Pct,
	Other_Means_Pct,
	Work_From_Home_Pct
)
SELECT 
	State,
	County,
	SUM(Travel_Time_0_9)/SUM(Total_Workers),
    SUM(Travel_Time_10_19)/SUM(Total_Workers),
    SUM(Travel_Time_20_29)/SUM(Total_Workers),
    SUM(Travel_Time_30_44)/SUM(Total_Workers),
    SUM(Travel_Time_45_59)/SUM(Total_Workers),
    SUM(Travel_Time_60_89)/SUM(Total_Workers),
    SUM(Travel_Time_90_up)/SUM(Total_Workers),
    SUM(Cars_Truck_Van)/SUM(Total_Transport),
	SUM(Cars_Truck_Van_Alone)/SUM(Total_Transport),
	SUM(Cars_Truck_Van_Carpool)/SUM(Total_Transport),
	SUM(Public_Transportation)/SUM(Total_Transport),
	SUM(Bicycle)/SUM(Total_Transport),
	SUM(Walking)/SUM(Total_Transport),
	SUM(Other_Means)/SUM(Total_Transport),
	SUM(Work_From_Home)/SUM(Total_Transport)
FROM Travel_Info
GROUP BY State, County;

CREATE TABLE Census_Percentages (
	State VARCHAR(40),
    County VARCHAR(40),
    Census_Tract VARCHAR(40),
	Travel_Time_0_9_Pct FLOAT,
	Travel_Time_10_19_Pct FLOAT,
	Travel_Time_20_29_Pct FLOAT,
	Travel_Time_30_44_Pct FLOAT,
	Travel_Time_45_59_Pct FLOAT,
	Travel_Time_60_89_Pct FLOAT,
	Travel_Time_90_up_Pct FLOAT,
    Cars_Truck_Van_Pct FLOAT,
	Cars_Truck_Van_Alone_Pct FLOAT,
	Cars_Truck_Van_Carpool_Pct FLOAT,
	Public_Transportation_Pct FLOAT,
	Bicycle_Pct FLOAT,
	Walking_Pct FLOAT,
	Other_Means_Pct FLOAT,
	Work_From_Home_Pct FLOAT
);


INSERT INTO Census_Percentages (
	State,
    County,
    Census_Tract,
    Travel_Time_0_9_Pct,
    Travel_Time_10_19_Pct,
    Travel_Time_20_29_Pct,
    Travel_Time_30_44_Pct,
    Travel_Time_45_59_Pct,
    Travel_Time_60_89_Pct,
    Travel_Time_90_Up_Pct,
    Cars_Truck_Van_Pct,
    Cars_Truck_Van_Alone_Pct,
    Cars_Truck_Van_Carpool_Pct,
    Public_Transportation_Pct,
    Bicycle_Pct,
    Walking_Pct,
    Other_Means_Pct,
    Work_From_Home_Pct
)
SELECT
	State,
    County,
    Census_Tract,
    COALESCE(SUM(Travel_Time_0_9)/NULLIF(SUM(Total_Workers),0),0),
    COALESCE(SUM(Travel_Time_10_19)/NULLIF(SUM(Total_Workers),0),0),
    COALESCE(SUM(Travel_Time_20_29)/NULLIF(SUM(Total_Workers),0),0),
    COALESCE(SUM(Travel_Time_30_44)/NULLIF(SUM(Total_Workers),0),0),
    COALESCE(SUM(Travel_Time_45_59)/NULLIF(SUM(Total_Workers),0),0),
    COALESCE(SUM(Travel_Time_60_89)/NULLIF(SUM(Total_Workers),0),0),
    COALESCE(SUM(Travel_Time_90_Up)/NULLIF(SUM(Total_Workers),0),0),
    COALESCE(SUM(Cars_Truck_Van)/NULLIF(SUM(Total_Transport),0),0),
    COALESCE(SUM(Cars_Truck_Van_Alone)/NULLIF(SUM(Total_Transport),0),0),
    COALESCE(SUM(Cars_Truck_Van_Carpool)/NULLIF(SUM(Total_Transport),0),0),
    COALESCE(SUM(Public_Transportation)/NULLIF(SUM(Total_Transport),0),0),
    COALESCE(SUM(Bicycle)/NULLIF(SUM(Total_Transport),0),0),
    COALESCE(SUM(Walking)/NULLIF(SUM(Total_Transport),0),0),
    COALESCE(SUM(Other_Means)/NULLIF(SUM(Total_Transport),0),0),
    COALESCE(SUM(Work_From_Home)/NULLIF(SUM(Total_Transport),0),0)
FROM Travel_Info
GROUP BY State, County, Census_Tract;

#Creating Max inquiries table:

CREATE TABLE Max_States(
	State_0_9 VARCHAR(31),
    Max_0_9 FLOAT
);

INSERT INTO Max_States(
	State_0_9,
    Max_0_9
)
SELECT
	State,
    Travel_Time_0_9_Pct
FROM State_Percentages
ORDER BY Travel_Time_0_9_Pct DESC
LIMIT 1;

ALTER TABLE Max_States
ADD COLUMN State_10_19 VARCHAR(31),
ADD COLUMN Travel_Time_10_19_Pct FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State_10_19 VARCHAR(31),
    Travel_Time_10_19_Pct FLOAT
);

INSERT INTO Hold_Val (
	State_10_19,
	Travel_Time_10_19_Pct
)
SELECT
	State,
    Travel_Time_10_19_Pct
FROM State_Percentages
ORDER BY Travel_Time_10_19_Pct DESC
LIMIT 1;

UPDATE Max_States M
JOIN Hold_Val H
SET
	M.State_10_19 = H.State_10_19,
    M.Travel_Time_10_19_Pct = H.Travel_Time_10_19_Pct;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_States
ADD COLUMN State_20_29 VARCHAR(31),
ADD COLUMN Travel_Time_20_29_Pct FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State_20_29 VARCHAR(31),
    Travel_Time_20_29_Pct FLOAT
);

INSERT INTO Hold_Val (
	State_20_29,
	Travel_Time_20_29_Pct
)
SELECT
	State,
    Travel_Time_20_29_Pct
FROM State_Percentages
ORDER BY Travel_Time_20_29_Pct DESC
LIMIT 1;

UPDATE Max_States M
JOIN Hold_Val H
SET
	M.State_20_29 = H.State_20_29,
    M.Travel_Time_20_29_Pct = H.Travel_Time_20_29_Pct;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_States
ADD COLUMN State_30_44 VARCHAR(31),
ADD COLUMN Travel_Time_30_44_Pct FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State_30_44 VARCHAR(31),
    Travel_Time_30_44_Pct FLOAT
);

INSERT INTO Hold_Val (
	State_30_44,
	Travel_Time_30_44_Pct
)
SELECT
	State,
    Travel_Time_30_44_Pct
FROM State_Percentages
ORDER BY Travel_Time_30_44_Pct DESC
LIMIT 1;

UPDATE Max_States M
JOIN Hold_Val H
SET
	M.State_30_44 = H.State_30_44,
    M.Travel_Time_30_44_Pct = H.Travel_Time_30_44_Pct;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_States
ADD COLUMN State_45_59 VARCHAR(31),
ADD COLUMN Travel_Time_45_59_Pct FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State_45_59 VARCHAR(31),
    Travel_Time_45_59_Pct FLOAT
);

INSERT INTO Hold_Val (
	State_45_59,
	Travel_Time_45_59_Pct
)
SELECT
	State,
    Travel_Time_45_59_Pct
FROM State_Percentages
ORDER BY Travel_Time_45_59_Pct DESC
LIMIT 1;

UPDATE Max_States M
JOIN Hold_Val H
SET
	M.State_45_59 = H.State_45_59,
    M.Travel_Time_45_59_Pct = H.Travel_Time_45_59_Pct;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_States
ADD COLUMN State_60_89 VARCHAR(31),
ADD COLUMN Travel_Time_60_89_Pct FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State_60_89 VARCHAR(31),
    Travel_Time_60_89_Pct FLOAT
);

INSERT INTO Hold_Val (
	State_60_89,
	Travel_Time_60_89_Pct
)
SELECT
	State,
    Travel_Time_60_89_Pct
FROM State_Percentages
ORDER BY Travel_Time_60_89_Pct DESC
LIMIT 1;

UPDATE Max_States M
JOIN Hold_Val H
SET
	M.State_60_89 = H.State_60_89,
    M.Travel_Time_60_89_Pct = H.Travel_Time_60_89_Pct;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_States
ADD COLUMN State_90_Up VARCHAR(31),
ADD COLUMN Travel_Time_90_Up_Pct FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State_90_Up VARCHAR(31),
    Travel_Time_90_Up_Pct FLOAT
);

INSERT INTO Hold_Val (
	State_90_Up,
	Travel_Time_90_Up_Pct
)
SELECT
	State,
    Travel_Time_90_Up_Pct
FROM State_Percentages
ORDER BY Travel_Time_90_Up_Pct DESC
LIMIT 1;

UPDATE Max_States M
JOIN Hold_Val H
SET
	M.State_90_Up = H.State_90_Up,
    M.Travel_Time_90_Up_Pct = H.Travel_Time_90_Up_Pct;

DROP TEMPORARY TABLE Hold_Val;

CREATE TABLE Max_Counties (
	State VARCHAR(33),
    County_0_9 VARCHAR(33),
    Max_0_9 FLOAT
);

INSERT INTO Max_Counties(
	State,
    County_0_9,
    Max_0_9
)
WITH Ranked_Time AS ( 
	SELECT
		State,
		County,
		Travel_Time_0_9_Pct,
		ROW_NUMBER() OVER (PARTITION BY STATE ORDER BY Travel_Time_0_9_Pct DESC) AS RN
	FROM County_Percentages
)
SELECT 
	State,
	County,
	Travel_Time_0_9_Pct
FROM Ranked_Time
WHERE RN = 1;

ALTER TABLE Max_Counties
ADD COLUMN County_10_19 VARCHAR(33),
ADD COLUMN Max_10_19 FLOAT;


CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
	County VARCHAR(33),
	Travel_Time_10_19_Pct FLOAT
);

INSERT INTO Hold_Val (State, County, Travel_Time_10_19_Pct) (
    WITH Ranked_Time AS ( 
	SELECT
		State,
		County,
		Travel_Time_10_19_Pct,
		ROW_NUMBER() OVER (PARTITION BY STATE ORDER BY Travel_Time_10_19_Pct DESC) AS RN
	FROM County_Percentages
	)
	SELECT 
		State,
        County,
        Travel_Time_10_19_Pct
	FROM Ranked_Time
	WHERE RN = 1
);

UPDATE Max_Counties M
JOIN Hold_Val H ON H.State = M.State
SET 
M.County_10_19 = H.County,
M.Max_10_19 = H.Travel_Time_10_19_Pct;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_Counties
ADD COLUMN County_20_29 VARCHAR(33),
ADD COLUMN Max_20_29 FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
	County VARCHAR(33),
	Travel_Time_20_29_Pct FLOAT
);

INSERT INTO Hold_Val (State, County, Travel_Time_20_29_Pct) (
    WITH Ranked_Time AS ( 
	SELECT
		State,
		County,
		Travel_Time_20_29_Pct,
		ROW_NUMBER() OVER (PARTITION BY STATE ORDER BY Travel_Time_20_29_Pct DESC) AS RN
	FROM County_Percentages
	)
	SELECT 
		State,
        County,
        Travel_Time_20_29_Pct
	FROM Ranked_Time
	WHERE RN = 1
);

UPDATE Max_Counties M
JOIN Hold_Val H ON H.State = M.State
SET 
M.County_20_29 = H.County,
M.Max_20_29 = H.Travel_Time_20_29_Pct;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_Counties
ADD COLUMN County_30_44 VARCHAR(33),
ADD COLUMN Max_30_44 FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
	County VARCHAR(33),
	Travel_Time_30_44_Pct FLOAT
);

INSERT INTO Hold_Val (State, County, Travel_Time_30_44_Pct) (
    WITH Ranked_Time AS ( 
	SELECT
		State,
		County,
		Travel_Time_30_44_Pct,
		ROW_NUMBER() OVER (PARTITION BY STATE ORDER BY Travel_Time_30_44_Pct DESC) AS RN
	FROM County_Percentages
	)
	SELECT 
		State,
        County,
        Travel_Time_30_44_Pct
	FROM Ranked_Time
	WHERE RN = 1
);

UPDATE Max_Counties M
JOIN Hold_Val H ON H.State = M.State
SET 
M.County_30_44 = H.County,
M.Max_30_44 = H.Travel_Time_30_44_Pct;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_Counties
ADD COLUMN County_45_59 VARCHAR(33),
ADD COLUMN Max_45_59 FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
	County VARCHAR(33),
	Travel_Time_45_59_Pct FLOAT
);

INSERT INTO Hold_Val (State, County, Travel_Time_45_59_Pct) (
    WITH Ranked_Time AS ( 
	SELECT
		State,
		County,
		Travel_Time_45_59_Pct,
		ROW_NUMBER() OVER (PARTITION BY STATE ORDER BY Travel_Time_45_59_Pct DESC) AS RN
	FROM County_Percentages
	)
	SELECT 
		State,
        County,
        Travel_Time_45_59_Pct
	FROM Ranked_Time
	WHERE RN = 1
);

UPDATE Max_Counties M
JOIN Hold_Val H ON H.State = M.State
SET 
M.County_45_59 = H.County,
M.Max_45_59 = H.Travel_Time_45_59_Pct;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_Counties
ADD COLUMN County_60_89 VARCHAR(33),
ADD COLUMN Max_60_89 FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
	County VARCHAR(33),
	Travel_Time_60_89_Pct FLOAT
);

INSERT INTO Hold_Val (State, County, Travel_Time_60_89_Pct) (
    WITH Ranked_Time AS ( 
	SELECT
		State,
		County,
		Travel_Time_60_89_Pct,
		ROW_NUMBER() OVER (PARTITION BY STATE ORDER BY Travel_Time_60_89_Pct DESC) AS RN
	FROM County_Percentages
	)
	SELECT 
		State,
        County,
        Travel_Time_60_89_Pct
	FROM Ranked_Time
	WHERE RN = 1
);

UPDATE Max_Counties M
JOIN Hold_Val H ON H.State = M.State
SET 
M.County_60_89 = H.County,
M.Max_60_89 = H.Travel_Time_60_89_Pct;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_Counties
ADD COLUMN County_90_Up VARCHAR(33),
ADD COLUMN Max_90_Up FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
	County VARCHAR(33),
	Travel_Time_90_Up_Pct FLOAT
);

INSERT INTO Hold_Val (State, County, Travel_Time_90_Up_Pct) (
    WITH Ranked_Time AS ( 
	SELECT
		State,
		County,
		Travel_Time_90_Up_Pct,
		ROW_NUMBER() OVER (PARTITION BY STATE ORDER BY Travel_Time_90_Up_Pct DESC) AS RN
	FROM County_Percentages
	)
	SELECT 
		State,
        County,
        Travel_Time_90_Up_Pct
	FROM Ranked_Time
	WHERE RN = 1
);

UPDATE Max_Counties M
JOIN Hold_Val H ON H.State = M.State
SET 
M.County_90_Up = H.County,
M.Max_90_Up = H.Travel_Time_90_Up_Pct;

DROP TEMPORARY TABLE Hold_Val;

CREATE TABLE Max_Census_Tract (
	State VARCHAR(33),
    County VARCHAR(33),
    Census_Tract_0_9 VARCHAR(33),
    Max_0_9 FLOAT
);

INSERT INTO Max_Census_Tract (
	State,
    County,
    Census_Tract_0_9,
    Max_0_9
)
(
	WITH Ranked_Time AS ( 
		SELECT
			State,
			County,
			Census_Tract,
			Travel_Time_0_9_Pct,
			ROW_NUMBER() OVER (PARTITION BY State, County ORDER BY Travel_Time_0_9_Pct DESC) AS RN
		FROM Census_Percentages
		)
		SELECT 
			State, 
			County, 
			Census_Tract,
			Travel_Time_0_9_Pct
		FROM Ranked_Time
		WHERE RN = 1
);

ALTER TABLE Max_Census_Tract 
ADD COLUMN Census_Tract_10_19 VARCHAR(33),
ADD COLUMN Max_10_19 FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
    County VARCHAR(33),
    Census_Tract_10_19 VARCHAR(33),
    Max_10_19 FLOAT
);

INSERT INTO Hold_Val (
	State,
    County,
    Census_Tract_10_19,
    Max_10_19
)
(
	WITH Ranked_Time AS ( 
		SELECT
			State,
			County,
			Census_Tract,
			Travel_Time_10_19_Pct,
			ROW_NUMBER() OVER (PARTITION BY State, County ORDER BY Travel_Time_10_19_Pct DESC) AS RN
		FROM Census_Percentages
		)
		SELECT 
			State, 
			County, 
			Census_Tract,
			Travel_Time_10_19_Pct
		FROM Ranked_Time
		WHERE RN = 1
);

UPDATE Max_Census_Tract M
JOIN Hold_Val H ON M.State = H.State AND M.County = H.County
SET 
	M.Census_Tract_10_19 = H.Census_Tract_10_19,
    M.Max_10_19 = H.Max_10_19;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_Census_Tract 
ADD COLUMN Census_Tract_20_29 VARCHAR(33),
ADD COLUMN Max_20_29 FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
    County VARCHAR(33),
    Census_Tract_20_29 VARCHAR(33),
    Max_20_29 FLOAT
);

INSERT INTO Hold_Val (
	State,
    County,
    Census_Tract_20_29,
    Max_20_29
)
(
	WITH Ranked_Time AS ( 
		SELECT
			State,
			County,
			Census_Tract,
			Travel_Time_20_29_Pct,
			ROW_NUMBER() OVER (PARTITION BY State, County ORDER BY Travel_Time_20_29_Pct DESC) AS RN
		FROM Census_Percentages
		)
		SELECT 
			State, 
			County, 
			Census_Tract,
			Travel_Time_20_29_Pct
		FROM Ranked_Time
		WHERE RN = 1
);

UPDATE Max_Census_Tract M
JOIN Hold_Val H ON M.State = H.State AND M.County = H.County
SET 
	M.Census_Tract_20_29 = H.Census_Tract_20_29,
    M.Max_20_29 = H.Max_20_29;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_Census_Tract 
ADD COLUMN Census_Tract_30_44 VARCHAR(33),
ADD COLUMN Max_30_44 FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
    County VARCHAR(33),
    Census_Tract_30_44 VARCHAR(33),
    Max_30_44 FLOAT
);

INSERT INTO Hold_Val (
	State,
    County,
    Census_Tract_30_44,
    Max_30_44
)
(
	WITH Ranked_Time AS ( 
		SELECT
			State,
			County,
			Census_Tract,
			Travel_Time_30_44_Pct,
			ROW_NUMBER() OVER (PARTITION BY State, County ORDER BY Travel_Time_30_44_Pct DESC) AS RN
		FROM Census_Percentages
		)
		SELECT 
			State, 
			County, 
			Census_Tract,
			Travel_Time_30_44_Pct
		FROM Ranked_Time
		WHERE RN = 1
);

UPDATE Max_Census_Tract M
JOIN Hold_Val H ON M.State = H.State AND M.County = H.County
SET 
	M.Census_Tract_30_44 = H.Census_Tract_30_44,
    M.Max_30_44 = H.Max_30_44;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_Census_Tract 
ADD COLUMN Census_Tract_45_59 VARCHAR(33),
ADD COLUMN Max_45_59 FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
    County VARCHAR(33),
    Census_Tract_45_59 VARCHAR(33),
    Max_45_59 FLOAT
);

INSERT INTO Hold_Val (
	State,
    County,
    Census_Tract_45_59,
    Max_45_59
)
(
	WITH Ranked_Time AS ( 
		SELECT
			State,
			County,
			Census_Tract,
			Travel_Time_45_59_Pct,
			ROW_NUMBER() OVER (PARTITION BY State, County ORDER BY Travel_Time_45_59_Pct DESC) AS RN
		FROM Census_Percentages
		)
		SELECT 
			State, 
			County, 
			Census_Tract,
			Travel_Time_45_59_Pct
		FROM Ranked_Time
		WHERE RN = 1
);

UPDATE Max_Census_Tract M
JOIN Hold_Val H ON M.State = H.State AND M.County = H.County
SET 
	M.Census_Tract_45_59 = H.Census_Tract_45_59,
    M.Max_45_59 = H.Max_45_59;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_Census_Tract 
ADD COLUMN Census_Tract_60_89 VARCHAR(33),
ADD COLUMN Max_60_89 FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
    County VARCHAR(33),
    Census_Tract_60_89 VARCHAR(33),
    Max_60_89 FLOAT
);

INSERT INTO Hold_Val (
	State,
    County,
    Census_Tract_60_89,
    Max_60_89
)
(
	WITH Ranked_Time AS ( 
		SELECT
			State,
			County,
			Census_Tract,
			Travel_Time_60_89_Pct,
			ROW_NUMBER() OVER (PARTITION BY State, County ORDER BY Travel_Time_60_89_Pct DESC) AS RN
		FROM Census_Percentages
		)
		SELECT 
			State, 
			County, 
			Census_Tract,
			Travel_Time_60_89_Pct
		FROM Ranked_Time
		WHERE RN = 1
);

UPDATE Max_Census_Tract M
JOIN Hold_Val H ON M.State = H.State AND M.County = H.County
SET 
	M.Census_Tract_60_89 = H.Census_Tract_60_89,
    M.Max_60_89 = H.Max_60_89;

DROP TEMPORARY TABLE Hold_Val;

ALTER TABLE Max_Census_Tract 
ADD COLUMN Census_Tract_90_Up VARCHAR(33),
ADD COLUMN Max_90_Up FLOAT;

CREATE TEMPORARY TABLE Hold_Val (
	State VARCHAR(33),
    County VARCHAR(33),
    Census_Tract_90_Up VARCHAR(33),
    Max_90_Up FLOAT
);

INSERT INTO Hold_Val (
	State,
    County,
    Census_Tract_90_Up,
    Max_90_Up
)
(
	WITH Ranked_Time AS ( 
		SELECT
			State,
			County,
			Census_Tract,
			Travel_Time_90_Up_Pct,
			ROW_NUMBER() OVER (PARTITION BY State, County ORDER BY Travel_Time_90_Up_Pct DESC) AS RN
		FROM Census_Percentages
		)
		SELECT 
			State, 
			County, 
			Census_Tract,
			Travel_Time_90_Up_Pct
		FROM Ranked_Time
		WHERE RN = 1
);

UPDATE Max_Census_Tract M
JOIN Hold_Val H ON M.State = H.State AND M.County = H.County
SET 
	M.Census_Tract_90_Up = H.Census_Tract_90_Up,
    M.Max_90_Up = H.Max_90_Up;

DROP TEMPORARY TABLE Hold_Val;