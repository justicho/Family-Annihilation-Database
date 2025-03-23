USE familyannihilationdb;

CREATE TABLE Incidents (
    IncidentID INT PRIMARY KEY,
    IncidentDate VARCHAR(50),
    State VARCHAR(50),
    CityOrCounty VARCHAR(100),
    Address VARCHAR(255),
    VictimsKilled INT,
    VictimsInjured INT,
    SuspectsKilled INT,
    SuspectsInjured INT,
    SuspectsArrested INT,
    Operations VARCHAR(20)  
);

ALTER TABLE incidents ADD COLUMN suspectGender VARCHAR(10);
ALTER TABLE incidents ADD COLUMN suspectAgeRange VARCHAR(10);
ALTER TABLE incidents ADD COLUMN suspectStatus VARCHAR(10); 
ALTER TABLE incidents
DROP COLUMN Operations;

CREATE TABLE malelist (
    IncidentId INT PRIMARY KEY
);
CREATE TABLE femalelist (
    IncidentId INT PRIMARY KEY
);
CREATE TABLE adultlist (
    IncidentId INT PRIMARY KEY
);
CREATE TABLE teenlist (
    IncidentId INT PRIMARY KEY
);
CREATE TABLE killedlist (
    IncidentId INT PRIMARY KEY
);
CREATE TABLE suicidelist (
    IncidentId INT PRIMARY KEY
);
CREATE TABLE arrestedlist (
    IncidentId INT PRIMARY KEY
);


UPDATE incidents
SET suspectGender = 'Male'
WHERE IncidentId IN (SELECT IncidentId FROM malelist);

UPDATE incidents
SET suspectGender = 'Female'
WHERE IncidentId IN (SELECT IncidentId FROM femalelist);

UPDATE incidents
SET suspectGender = 'Male'
WHERE incidentid = 2850574;

SELECT *
FROM 
(SELECT incidentid FROM malelist) AS males
JOIN 
(SELECT incidentid FROM femalelist) AS females
ON males.incidentid = females.incidentid;

UPDATE incidents
SET suspectGender = 'Both'
WHERE incidentid IN (545525, 2985812, 2444683, 2521514);

UPDATE incidents
SET suspectGender = 'Unknown'
WHERE incidentid = 2966486;

UPDATE incidents
SET suspectStatus = 'Suicide'
WHERE IncidentId IN (SELECT IncidentId FROM suicidelist);

SELECT kl.IncidentId
FROM killedlist kl
LEFT JOIN suicidelist sl ON kl.IncidentId = sl.IncidentId
WHERE sl.IncidentId IS NULL;

UPDATE incidents
SET suspectstatus = 'Killed'
WHERE incidentid IN (293377, 485811, 2100397, 2587288, 2720893, 2907644, 2949841, 3067101, 3097837, 3118521);

UPDATE incidents
SET suspectStatus = 'Arrested'
WHERE IncidentId IN (SELECT IncidentId FROM arrestedlist);

SELECT *
FROM incidents
WHERE suspectStatus IS NULL;

UPDATE incidents
SET suspectAgeRange = 'Unknown'
WHERE incidentid = 2966486;

UPDATE incidents
SET suspectAgeRange = 'Adult 18+'
WHERE IncidentId IN (SELECT IncidentId FROM adultlist);

UPDATE incidents
SET suspectAgeRange = 'Teen 12-17'
WHERE IncidentId IN (SELECT IncidentId FROM teenlist);




SELECT * FROM incidents;

SELECT *
FROM incidents
WHERE suspectAgeRange IS NULL;

SELECT COUNT(*) AS FemaleCount
FROM incidents
WHERE suspectGender = 'Female';

SELECT COUNT(*) AS MaleCount
FROM incidents
WHERE suspectGender = 'Male';

SELECT suspectGender, COUNT(*) AS Count
FROM incidents
GROUP BY suspectGender;

SELECT 
    suspectGender,
    COUNT(*) AS Count,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM incidents) * 100), 2) AS Percentage
FROM incidents
GROUP BY suspectGender;

SELECT suspectGender, AVG(VictimsKilled) AS AvgVictims
FROM incidents
GROUP BY suspectGender;

SELECT 
    suspectStatus,
    COUNT(*) AS Count,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM incidents) * 100), 2) AS Percentage
FROM incidents
GROUP BY suspectStatus;

SELECT 
    suspectStatus,
    suspectAgeRange,
    COUNT(*) AS Count,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM incidents WHERE suspectGender = 'Male') * 100), 2) AS Percentage
FROM incidents
WHERE suspectGender = 'Male'
GROUP BY suspectStatus, suspectAgeRange;

SELECT 
    suspectStatus,
    COUNT(*) AS Count,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM incidents WHERE suspectGender = 'Female') * 100), 2) AS Percentage
FROM incidents
WHERE suspectGender = 'Female'
GROUP BY suspectStatus;

SELECT 
    suspectStatus,
    COUNT(*) AS Count,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM incidents WHERE suspectGender = 'Both') * 100), 2) AS Percentage
FROM incidents
WHERE suspectGender = 'Both'
GROUP BY suspectStatus;

SELECT 
    suspectGender,
    suspectStatus,
    COUNT(*) AS Count,
    ROUND((COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY suspectGender) * 100), 2) AS Percentage
FROM incidents
GROUP BY suspectGender, suspectStatus;

SELECT 
    suspectGender,
    suspectStatus,
    suspectAgeRange,
    COUNT(*) AS Count,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM incidents) * 100), 2) AS Percentage
FROM incidents
GROUP BY suspectGender, suspectStatus, suspectAgeRange;