CREATE DATABASE porto_ds_salaries;

SELECT * FROM ds_salaries;

-- 1. Job title yang termasuk ke Data Analyst
SELECT DISTINCT 
	job_title
FROM 
	ds_salaries
WHERE 
	job_title 
		LIKE "%Data Analyst%";

-- 2. Rata-rata salaries Data Analyst
SELECT DISTINCT
	job_title
    , AVG(salary_in_usd) AS salary
FROM
	ds_salaries
WHERE
	job_title
		LIKE "%Data Analyst%"
GROUP BY
	job_title;

-- 3. Rata-rata salaries Data Analyst berdasarkan Experience Level dan Employment Type
SELECT DISTINCT
	job_title
    , AVG(salary_in_usd) AS salary
    , experience_level
    , employment_type
FROM
	ds_salaries
WHERE
	job_title
		LIKE "%Data Analyst%"
GROUP BY
	job_title
    , experience_level
    , employment_type
ORDER BY
	salary DESC;

-- 4. Negara dengan salaries Data Analyst terbesar dibandingkan dengan rata-rata salaries berdasarkan Experience Level 
-- dan Employment Type
SELECT
	job_title
    , AVG(salary_in_usd) AS salary
    , company_location
    , experience_level
    , employment_type
FROM
	ds_salaries
WHERE
	job_title
		LIKE "%Data Analyst%"
GROUP BY
    job_title
    , experience_level
    , employment_type
    , company_location
HAVING
	salary > 
			(SELECT AVG(salary_in_usd) AS salary
				FROM ds_salaries
                WHERE
					job_title
						LIKE "%Data Analyst%");
                        
-- 5. Negara dengan rata-rata salaries Data Analyst terbesar dengan Experience Level "Entry level dan Medium Level"
-- dan Employment Type "Full Time"
SELECT
	job_title
    , company_location
    , experience_level
    , employment_type
    , AVG(salary_in_usd) AS salary
FROM
	ds_salaries
WHERE job_title LIKE "%Data Analyst%"
                    AND experience_level IN ('EN', 'MI')
                    AND employment_type = 'FT'
GROUP BY
	job_title
    , company_location
    , experience_level
    , employment_type
HAVING
	salary > (SELECT AVG(salary_in_usd) AS avg_salary
				FROM ds_salaries
                WHERE job_title LIKE "%Data Analyst%"
                    AND experience_level IN ('EN', 'MI')
                    AND employment_type = 'FT');

-- 6. Perubahan salaries Data Analyst dari tahun ke tahun dengan Experience Level "Entry Level" dan
-- Employment Level "FT"
SELECT DISTINCT
	work_year
    , experience_level
    , employment_type
    , AVG(salary_in_usd) AS salary
FROM
	ds_salaries
WHERE 
	job_title 
		LIKE "%Data Analyst%"
        AND experience_level = 'EN'
        AND employment_type = 'FT'
GROUP BY
	work_year
    , experience_level
    , employment_type;

-- 7. Rata-rata perubahan salaries Data Analyst dari Experience Level "Entry to Senior" dan Employment Level "FT"
WITH ds1 AS (SELECT
	work_year
    , AVG(salary_in_usd) AS avg_salary_en
FROM 
	ds_salaries
WHERE 
	job_title LIKE '%Data Analyst%'
	AND experience_level = 'EN'
	AND employment_type = 'FT'
GROUP BY
	work_year),
ds2 AS (SELECT
	work_year
    , AVG(salary_in_usd) AS avg_salary_mi
FROM
	ds_salaries
WHERE
	job_title LIKE '%Data Analyst%'
    AND experience_level = 'MI'
    AND employment_type = 'FT'
GROUP BY
	work_year),
ds3 AS (SELECT
	work_year
    , AVG(salary_in_usd) AS avg_salary_se
FROM
	ds_salaries
WHERE
	job_title LIKE '%Data Analyst%'
    AND experience_level = 'SE'
    AND employment_type = 'FT'
GROUP BY
	work_year)
SELECT
	ds1.work_year
	, ds1.avg_salary_en
    , ds2.avg_salary_mi
    , ds3.avg_salary_se
    , (ds2.avg_salary_mi - ds1.avg_salary_en) AS diff_en_mi
    , (ds3.avg_salary_se - ds2.avg_salary_mi) AS diff_mi_se
FROM
	ds1
LEFT JOIN 
	ds2 
		ON ds1.work_year = ds2.work_year
LEFT JOIN
	ds3
		ON ds1.work_year = ds3.work_year
GROUP BY
	ds1.work_year
    , ds1.avg_salary_en
    , ds2.avg_salary_mi
    , ds3.avg_salary_se
ORDER BY
	ds1.work_year;