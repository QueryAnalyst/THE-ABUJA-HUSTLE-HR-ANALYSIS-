-- ----------------------------DATA CLEANING -------------------------
DESCRIBE `human resources 2`;
-- Changing the date format to sql format by cleaning and updating it-----------
SELECT birthdate
FROM `human resources 2`;
UPDATE `human resources 2` 
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL 
END;

ALTER TABLE `human resources 2`
MODIFY COLUMN birthdate DATE;

-- Changing the hire_date format to sql format ---
SELECT hire_date
FROM `human resources 2`;

UPDATE `human resources 2`
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE `human resources 2`
MODIFY COLUMN hire_date DATE;

-- Modify the termination date --- 

UPDATE `human resources 2`
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from `human resources 2`;

SET sql_mode = 'ALLOW_INVALID_DATES';
ALTER TABLE `human resources 2` 
MODIFY COLUMN termdate DATE;

-- CREATE AN AGE COLUMN---
ALTER TABLE `human resources 2` ADD COLUMN age INT;

UPDATE `human resources 2` 
SET age = timestampdiff(YEAR,birthdate,CURDATE());
 
SELECT birthdate, age 
FROM `human resources 2`;

-- TO FIND OUT THE AGE RANGE THATS NEEDED ---
SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM `human resources 2`;

SELECT count(*) FROM `human resources 2` WHERE age < 18;



