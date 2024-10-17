--1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT film_title as name, 
		release_year,
		worldwide_gross as gross
FROM specs as s
FULL JOIN revenue as rev
USING(movie_id)
ORDER BY gross

			--Answer: Semi-Tough--1977--$37187139



--2. What year has the highest average imdb rating?

SELECT release_year, 
		AVG(imdb_rating) as avg_imdb_rating
FROM specs as s
INNER JOIN rating as r
USING(movie_id)
GROUP BY s.release_year
ORDER BY avg_imdb_rating DESC;


		--Answer: 1991



--3. What is the highest grossing G-rated movie? Which company distributed it?

SELECT s.film_title, 
		s.mpaa_rating,
		d.company_name,
		r.worldwide_gross as gross
FROM specs as s
INNER JOIN distributors as d
ON s.domestic_distributor_id = d.distributor_id
INNER JOIN revenue as r
ON s.movie_id = r.movie_id
WHERE s.mpaa_rating = 'G'
ORDER BY gross DESC;

			--Answer: Toy Story 4




--4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.


SELECT d.distributor_id, d.company_name, COUNT(s.movie_id) as movie_count
FROM distributors as d
FULL JOIN specs as s
ON d.distributor_id = s.domestic_distributor_id
WHERE s.movie_id IS NULL 
	OR s.movie_id IS NOT NULL
GROUP BY d.distributor_id, d.company_name
ORDER BY movie_count;





		

--5. Write a query that returns the five distributors with the highest average movie budget.


SELECT d.company_name,
		AVG(r.film_budget) as avg_budget
FROM specs as s
INNER JOIN distributors as d
ON s.domestic_distributor_id = d.distributor_id
INNER JOIN revenue as r
USING(movie_id)
GROUP BY d.company_name
ORDER BY avg_budget DESC
LIMIT 5;


				--Answer: Walt Disney, Sony, Lionsgate, Dreamworks, Warner Bros.



--6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?



SELECT s.film_title,
		d.company_name,
		d.headquarters,
		r.imdb_rating
	FROM specs as s
INNER JOIN distributors as d
ON s.domestic_distributor_id = d.distributor_id
FULL JOIN rating as r
USING(movie_id)
WHERE d.headquarters NOT LIKE '%CA%'
ORDER BY r.imdb_rating DESC;

					--Answer: 2 Dirty Dancing



--7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?



SELECT 
	CASE
		WHEN length_in_min < 120 THEN 'under_2_hrs'
		WHEN length_in_min	>= 120 THEN 'over_2_hrs'
	END AS under_over_2hrs,
	AVG(imdb_rating)
FROM specs as s
INNER JOIN rating as r
USING(movie_id)
GROUP BY under_over_2hrs;


				--Answer: over_2hrs at 7.25