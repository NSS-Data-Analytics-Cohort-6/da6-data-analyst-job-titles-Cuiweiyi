-- How many rows are in the data_analyst_jobs table?
Select count (*) from data_analyst_jobs;
--Answer: 1793

--Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10;

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
AND star_rating >= 4;
--Answer: 4

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
FROM data_analyst_jobs;
-- Answer: 881 unique job titles

--8. How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT(title))
FROM data_analyst_jobs
WHERE location = 'CA';
--Answer: 230

--9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT COUNT(DISTINCT(company)), AVG(star_rating) AS avg_star
FROM data_analyst_jobs
WHERE review_count >= 5000
--Answer:40 distinct companies

--10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT DISTINCT(company), AVG(star_rating) AS avg_star
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_star DESC;

--11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';
--Answer: 1636

--12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT COUNT(title) 
FROM data_analyst_jobs 
WHERE title NOT LIKE '%Analyst%' AND title NOT LIKE '%Analytics%';
--Answer: 39 if either word is capitalized,
SELECT COUNT(title) 
FROM data_analyst_jobs 
WHERE title NOT LIKE '%Analyst%' AND title NOT LIKE UPPER('%Analyst%') AND title NOT LIKE LOWER('%Analyst%') AND title NOT LIKE '%Analytics%' AND title NOT LIKE UPPER('%Analytics%') AND title NOT LIKE LOWER('%Analytics%');
--Answer: 4 for all spellings

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.

-- Disregard any postings where the domain is NULL.
-- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
-- Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

