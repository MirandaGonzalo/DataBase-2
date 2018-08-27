# 1) - Write a query that gets all the customers that live in Argentina. Show the first and last name in one column, the address and the
# city.

SELECT CONCAT(customer.last_name, customer.first_name) AS 'Apellido y Nombre', a.address AS 'Direccion', ci.city 'Ciudad' FROM customer
INNER JOIN address a USING (address_id)
INNER JOIN city ci USING (city_id)
INNER JOIN country co USING (country_id)
WHERE co.country = "Argentina";

# 2) - Write a query that shows the film title, language and rating. Rating shall be shown as the full text described here: https://
# en.wikipedia.org/wiki/Motion_picture_content_rating_system#United_States. Hint: use case.

SELECT l.name, f.rating,  CASE f.rating
	WHEN 'G' THEN 'All Ages Are Admitted'
	WHEN 'PG-13' THEN 'Some Material May Be Inappropiate For Children Under 13'
	WHEN 'PG' THEN 'Some Material May Not Be Suitable for Children'
	WHEN 'R' THEN 'Requires Accompayning Parent Of Adult Guardian'
	ELSE'No One 17 and Under Admitted'
	END as "rating"
FROM film f INNER JOIN language l USING (language_id);
 
# 3) - Write a search query that shows all the films (title and release year) an actor was part of. Assume the actor comes from a text box 
# introduced by hand from a web page. Make sure to "adjust" the input text to try to find the films as effectively as you think is possible. 

SELECT f.title, f.release_year 
FROM film f
INNER JOIN film_actor fa USING (film_id)
INNER JOIN actor a USING (actor_id)
WHERE TRIM(LOWER(CONCAT(a.first_name))) LIKE TRIM(LOWER(' Zero '));

# 4) - Find all the rentals done in the months of May and June. Show the film title, customer name and if it was returned or not. There
# should be returned column with two possible values 'Yes' and 'No'.

SELECT f.title as 'Titulo', customer.first_name as 'Cliente',
IF (return_date IS NULL, 'No', 'Yes') AS 'Devuelto'
FROM film f
INNER JOIN inventory USING (film_id)
INNER JOIN rental USING (inventory_id)
INNER JOIN customer USING (customer_id)
WHERE MONTH(rental_date) IN ('5', '6'); 

#5
#The CAST() function converts a value from one datatype to another datatype:
SELECT CAST(customer_id AS CHAR)
FROM customer
WHERE first_name LIKE "%a"; 

#The MySQL CONVERT function converts a value 
#from one datatype to another, or one character set to another.
SELECT CONVERT(return_date , DATE)
FROM rental
WHERE return_date IS NOT NULL;

#6
#The MySQL IFNULL() function lets you return an alternative value if an expression is NULL:
SELECT IFNULL(NULL, "Es null"), return_date
FROM rental
WHERE return_date IS NULL

#ISNULL() function is used to specify how we want to treat NULL values.
#The NVL() and COALESCE() functions can also be used to achieve the same result.

SELECT rental_date, rental_id, COALESCE(return_date, "no devuelta")
FROM rental
WHERE return_date IS NULL

#oracle
SELECT rental_date, rental_id, NVL(return_date, "no devuelta")
FROM rental
WHERE return_date IS NULL


SELECT ISNULL(return_date)
FROM rental
WHERE return_date IS NULL

