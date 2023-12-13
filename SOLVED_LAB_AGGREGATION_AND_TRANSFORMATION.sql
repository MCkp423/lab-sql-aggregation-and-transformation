-- Imagine you work at a movie rental company as an analyst. By using SQL in the challenges below, you are required to gain insights into different elements of its business operations.

## Challenge 1

-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
	-- - 1.1 Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.



SELECT MAX(film.length) AS max_duration,
MIN(film.length) as min_duration
FROM sakila.film;


-- - 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals.
   --   - *Hint: Look for floor and round functions.*
   
   SELECT ROUND(AVG(length),0)
   FROM sakila.film;

-- 2. You need to gain insights related to rental dates:
-- 	- 2.1 Calculate the **number of days that the company has been operating**.
   --  - *Hint: To do this, use the `rental` table, and the `DATEDIFF()` function to subtract the earliest date in the `rental_date` column from the latest date.*

SELECT rental_date
FROM sakila.rental;

SELECT DATEDIFF('2006-02-14','2005-05-24');

-- - 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.

SELECT * FROM sakila.rental;

ALTER TABLE sakila.rental
ADD month_of_rental INT;

Alter TABLE sakila.rental
ADD day_of_rental INT;

UPDATE sakila.rental
SET month_of_rental = MONTH(rental_date);

UPDATE sakila.rental
SET day_of_rental = DAY(rental_date);

SELECT * FROM sakila.rental
Limit 20;

-- - 2.3 *Bonus: Retrieve rental information and add an additional column called `DAY_TYPE` with values **'weekend' or 'workday'**, depending on the day of the week.*
   --   - *Hint: use a conditional expression.*

SELECT * FROM sakila.rental;

ALTER TABLE sakila.rental
ADD day_type VARCHAR(50);

UPDATE sakila.rental
SET day_type = WEEKDAY(rental_date);

UPDATE sakila.rental
SET rental.day_type = 
   CASE
      WHEN day_type= 0 THEN 'workday'
      WHEN day_type= 1 THEN 'workday'
      WHEN day_type= 2 THEN 'workday'
	  WHEN day_type= 3 THEN 'workday' 
	  WHEN day_type= 4 THEN 'workday'
	  WHEN day_type= 5 THEN 'workday'
      ELSE 'weekend'
	END;


-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the **film titles and their rental duration**. If any rental duration value is **NULL, replace** it with the string **'Not Available'**. Sort the results of the film title in ascending order.
   -- - *Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.*
   -- - *Hint: Look for the `IFNULL()` function.*


SELECT film.title, film.rental_duration
FROM sakila.film
WHERE IFNULL(rental_duration, 'NOT_AVAILABLE');



-- 4. *Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the **concatenated first and last names of customers**,
-- along with the **first 3 characters of their email** address, so that you can address them by their first name and use their email address to send personalized recommendations.
-- The results should be ordered by last name in ascending order to make it easier to use the data.*

ALTER TABLE sakila.customer
ADD full_name VARCHAR(50);

ALTER TABLE sakila.customer
ADD first_characters VARCHAR(50);

UPDATE sakila.customer
SET full_name = CONCAT(customer.first_name, customer.last_name);

UPDATE sakila.customer
SET first_characters = SUBSTRING(customer.email, 1, 3);

SELECT full_name, first_characters FROM sakila.customer;

## Challenge 2

-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the `film` table, determine:
-- - 1.1 The **total number of films** that have been released.

SELECT MAX(film_id)
FROM sakila.film;


-- 	- 1.2 The **number of films for each rating**.

SELECT rating, COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating;


-- 	- 1.3 The **number of films for each rating, sorting** the results in descending order of the number of films.
-- 	This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT rating, COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating
ORDER BY rating DESC;

-- 2. Using the `film` table, determine:
  -- - 2.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT AVG(length) AS avg_film_duration
FROM sakila.film
GROUP BY rating;

-- 	- 2.2 Identify **which ratings have a mean duration of over two hours** in order to help select films for customers who prefer longer movies.

SELECT rating, AVG(length) as average_length
FROM sakila.film
WHERE length>= 112
GROUP BY rating;


-- 3. *Bonus: determine which last names are not repeated in the table `actor`.*

SELECT DISTINCT last_name 
FROM sakila.actor
GROUP BY last_name;