SELECT * 
FROM bakery.worldlifexpectancy;


SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM worldlifexpectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;

SET SQL_SAFE_UPDATES = 0;


SELECT *
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM worldlifexpectancy) AS Row_Table
WHERE Row_Num > 1
    ;
    
DELETE FROM worldlifexpectancy
WHERE 
	Row_ID IN (
    SELECT Row_ID
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM worldlifexpectancy) AS Row_Table
WHERE Row_Num > 1
);


SELECT * 
FROM bakery.worldlifexpectancy
WHERE Status = ' '
;


SELECT DISTINCT(Status)
FROM bakery.worldlifexpectancy
WHERE Status <> ' '
;

SELECT DISTINCT(Country)
FROM bakery.worldlifexpectancy
WHERE Status = 'Developing'
;

UPDATE worldlifexpectancy
SET Status = 'Developing'
WHERE Country IN (SELECT DISTINCT(Country)
				FROM bakery.worldlifexpectancy
				WHERE Status = 'Developing');


UPDATE worldlifexpectancy t1
JOIN worldlifexpectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ' '
AND t2.Status <> ' '
AND t2.Status = 'Developing'
;

SELECT *
FROM worldlifexpectancy 
WHERE Country = 'United States of America'
;

UPDATE worldlifexpectancy t1
JOIN worldlifexpectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ' '
AND t2.Status <> ' '
AND t2.Status = 'Developed'
;

SELECT *
FROM worldlifexpectancy 
#WHERE `Life expectancy` = ' '
;

SELECT Country, Year, `Lifeexpectancy`
FROM worldlifexpectancy 
#WHERE `Life expectancy` = ' '
;

SELECT t1.Country, t1.Year, t1.`Lifeexpectancy`, 
t2.Country, t2.Year, t2.`Lifeexpectancy`,
t3.Country, t3.Year, t3.`Lifeexpectancy`,
ROUND((t2.`Lifeexpectancy` + t3.`Lifeexpectancy`)/2,1)
FROM worldlifexpectancy t1
JOIN worldlifexpectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN worldlifexpectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Lifeexpectancy` = ' '
;



UPDATE worldlifexpectancy t1
JOIN worldlifexpectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN worldlifexpectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Lifeexpectancy` = ROUND((t2.`Lifeexpectancy` + t3.`Lifeexpectancy`)/2,1)
WHERE t1.`Lifeexpectancy` = ' '
;
 
