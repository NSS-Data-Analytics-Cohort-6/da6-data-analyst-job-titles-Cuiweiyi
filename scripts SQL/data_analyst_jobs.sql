-- How many rows are in the data_analyst_jobs table?
Select count (*) from data_analyst_jobs;
--Answer: 1793

--Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10;
--Answer: ExxonMobil

--How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE location = 'TN'
--Answer: from TN = 21
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY'
--Answer b:27 either TN or KY. KY only has 6

--4. How many postings in Tennessee have a star rating above 4?
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE location = 'TN'
AND star_rating > 4;
--Answer: 3

-- 5.How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE review_count >= 500 AND review_count <= 1000;
-- Answer: 151

--6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
SELECT location AS state, AVG(star_rating) AS avg_rating 
FROM data_analyst_jobs
GROUP BY state
ORDER BY avg_rating DESC;
--Answer: Nebraska has the highest avg rating

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT COUNT(DISTINCT(title))
FROM data_analyst_jobs
WHERE title IS NOT NULL;
-- Answer: 881 unique job titles

--8. How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT(title))
FROM data_analyst_jobs
WHERE location = 'CA';
--Answer: 230

--9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT COUNT(DISTINCT(company)), AVG(star_rating) AS avg_star
FROM data_analyst_jobs
WHERE review_count > 5000;
--Answer:40 distinct companies

--10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT DISTINCT(company), AVG(star_rating) AS avg_star
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_star DESC;

--11. Find all the job titles that contain the word ???Analyst???. How many different job titles are there?
SELECT COUNT(DISTINCT(title))
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';
--Answer: 774

--12. How many different job titles do not contain either the word ???Analyst??? or the word ???Analytics???? What word do these positions have in common?
SELECT (title) 
FROM data_analyst_jobs 
WHERE title NOT iLIKE '%Analyst%' AND title NOT iLIKE '%Analytics%';
--Answer: they all have Tableau in the title
SELECT COUNT(title) 
FROM data_analyst_jobs 
WHERE title NOT LIKE '%Analyst%' AND title NOT LIKE UPPER('%Analyst%') AND title NOT LIKE LOWER('%Analyst%') AND title NOT LIKE '%Analytics%' AND title NOT LIKE UPPER('%Analytics%') AND title NOT LIKE LOWER('%Analytics%');
--Answer: 4 for all spellings

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
SELECT COUNT(title), days_since_posting
FROM data_analyst_jobs
WHERE days_since_posting >= 21 AND skill LIKE '%SQL%'
AND title IS NOT NULL
GROUP BY title, days_since_posting
ORDER BY days_since_posting DESC;

-- Disregard any postings where the domain is NULL.
--Answer: seems to be 351 rows

-- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
SELECT title, days_since_posting
FROM data_analyst_jobs
WHERE days_since_posting >= 21  AND skill LIKE '%SQL%'
AND title IS NOT NULL
GROUP BY title, days_since_posting
ORDER BY days_since_posting DESC;

-- Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?
SELECT COUNT(domain), domain
FROM data_analyst_jobs
WHERE skill LIKE '%SQL%'
	AND days_since_posting > 21
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY count DESC
LIMIT 4;

SELECT (62+61+57+52)
AS result;
--Answer: Internet and Software at 62, Banks and Financial at 61, Business Consulting with 57 means there were 232 jobs listed for 3 weeks or more by the top 4 industries. 

--NOTES upon review. To return specific rows we can use the below formula in lieu of limitations. 
SELECT *
FROM (SELECT ROW_NUMBER () OVER () AS RowNum, *
        FROM data_analyst_jobs ) sub
WHERE RowNum = 100;

