# 1) 

INSERT INTO customer (store_id, first_name, last_name, email, address_id) 
VALUES (1, "Pepito", "Juarez", "pepejuarez@gmail.com",
	(SELECT address.address_id FROM address
	INNER JOIN city USING (city_id) 
	INNER JOIN country USING (country_id) 
	WHERE country.country = "United States" ORDER BY country.country_id DESC LIMIT 1));

# 2) 

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id) 
VALUES (CURRENT_DATE(),
		(SELECT inventory.inventory_id FROM inventory 
			INNER JOIN film USING (film_id) 
			WHERE film.title = "WIFE TURN" LIMIT 1)
		, 43, 
		(SELECT staff.staff_id FROM store 
		INNER JOIN staff USING (store_id) 
		WHERE store.store_id = 2 ORDER BY staff.staff_id DESC LIMIT 1)); 
# 3) 

UPDATE film
SET release_year = CASE
	WHEN rating = 'G' THEN 2001
	WHEN rating = 'PG' THEN 1200
	WHEN rating = 'NC-17' THEN  1500
	WHEN rating = 'PG-13' THEN 1700
	WHEN rating = 'R' THEN 2999
	END;

# 4) Return a film

Write the necessary statements and queries for the following steps.
Find a film that was not yet returned. And use that rental id. Pick the latest that was rented for example.
Use the id to return the film.

SELECT f.title, r.rental_id FROM film f
INNER JOIN inventory i USING (film_id)
LEFT JOIN rental r USING (inventory_id)
WHERE r.return_date IS NULL ORDER BY r.rental_id DESC LIMIT 1;

UPDATE rental
SET return_date = CURRENT_DATE()
WHERE rental.rental_id = 16050;

UPDATE payment
SET amount = amount + 20
WHERE payment.rental_id = 16050;

