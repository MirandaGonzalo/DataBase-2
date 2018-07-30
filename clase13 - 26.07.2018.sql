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

# 4) 

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

# 5) Delete a film

#This is not working for the Constraints

DELETE film FROM film
WHERE film.film_id = 1;

#This works

DELETE payment 
FROM rental 
	INNER JOIN payment USING (rental_id)
	INNER JOIN inventory USING (inventory_id)
	WHERE film_id = 1;

DELETE rental
FROM inventory
	INNER JOIN rental USING (inventory_id)
	WHERE film_id = 1;

DELETE film_actor FROM film_actor WHERE film_id = 1;

DELETE film_category FROM film_category WHERE film_id = 1;

DELETE film FROM film WHERE film_id = 1;

Results:

-- 1

INSERT INTO sakila.customer
(store_id, first_name, last_name, email, address_id, active)
VALUES(1, 'Pepe', 'Suarez', 'pepesuarez@gmail.com', 599, 1);


#El max da 599
SELECT MAX(a.address_id)
FROM address a
WHERE (SELECT c.country_id
        FROM country c, city c1
        WHERE c.country = "United States"
        AND c.country_id = c1.country_id
        AND c1.city_id = a.city_id);


SELECT *
FROM customer
WHERE last_name = "Suarez";



-- 2

INSERT INTO sakila.rental
(rental_date, inventory_id, customer_id, return_date, staff_id)
SELECT CURRENT_TIMESTAMP, 
        (SELECT MAX(r.inventory_id)
         FROM inventory r
         INNER JOIN film USING(film_id)
         WHERE film.title = "ARABIA DOGMA"
         LIMIT 1), 
         601, -- Find an user here
         NULL,
         (SELECT staff_id
          FROM staff
          INNER JOIN store USING(store_id)
          WHERE store.store_id = 2
          LIMIT 1);

SELECT MAX(r.inventory_id)
FROM inventory r
INNER JOIN film USING(film_id)
WHERE film.title = "ALIEN CENTER";

SELECT staff_id
FROM staff
INNER JOIN store USING(store_id)
WHERE store.store_id = 2
LIMIT 1;


-- 3

UPDATE sakila.film
SET release_year='2001'
WHERE rating = "G";

UPDATE sakila.film
SET release_year='2005'
WHERE rating = "PG";

UPDATE sakila.film
SET release_year='2010'
WHERE rating = "PG-13";

UPDATE sakila.film
SET release_year='2015'
WHERE rating = "R";

UPDATE sakila.film
SET release_year='2020'
WHERE rating = "NC-17";


-- 4

#Rental id devuelto 11496 , el precio 2,99, el customer = 155, staff = 1
SELECT rental_id, rental_rate, customer_id, staff_id
FROM film
INNER JOIN inventory USING(film_id)
INNER JOIN rental USING(inventory_id)
WHERE rental.return_date IS NULL
LIMIT 1;

#Hago un update a rental para decir que la pelicula fue devuelta
UPDATE sakila.rental
SET  return_date=CURRENT_TIMESTAMP
WHERE rental_id=11496;


-- 6

SELECT inventory_id, rental_id, store_id
FROM film
INNER JOIN inventory USING(film_id)
INNER JOIN rental USING(inventory_id)
WHERE rental.return_date IS NOT NULL
and store_id = 2

-- inventory_id 

INSERT INTO sakila.rental
(rental_date, inventory_id, customer_id, return_date, staff_id)
--

SELECT CURRENT_TIMESTAMP,        
        t1.inventory_id, 
        customer.customer_id,
        NULL,
        t1.staff_id
FROM customer
INNER JOIN (SELECT store_id, staff_id, inventory_id
          FROM staff
          INNER JOIN store USING(store_id)
          INNER JOIN inventory USING(store_id)
          WHERE inventory_id = 10) t1
     USING(store_id)
ORDER BY customer_id DESC
LIMIT 1;

--
INSERT INTO sakila.payment
(customer_id, staff_id, rental_id, amount, payment_date, last_update)
--


SELECT r.customer_id, 
       r.staff_id, 
       r.rental_id,
      (SELECT f.rental_rate 
       from film f
       inner join inventory i USING (film_id)
       WHERE i.inventory_id = r.inventory_id ) as amount,
       r.rental_date   
FROM rental r
WHERE return_date IS NULL
AND inventory_id = 10;

