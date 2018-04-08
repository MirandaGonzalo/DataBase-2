SELECT * FROM actor LIMIT 10;

SELECT title, description,rental_rate, rental_rate * 15 AS "In Pesos" FROM film;

SELECT name AS val FROM category WHERE name LIKE 'A%' OR name LIKE 'M%' UNION SELECT title FROM film WHERE title LIKE 'A%' Or title LIKE 'S%';

#Show title and special_features of films that are PG-13

SELECT title, special_features, rating FROM film WHERE rating = 'PG-13';

#Get a list of all the different films duration.

SELECT DISTINCT `length` FROM film ORDER BY `length`;

#Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00

SELECT title, rental_rate, replacement_cost FROM film WHERE replacement_cost BETWEEN 20.00 AND 24.00 ORDER BY replacement_cost;

#Show title, category and rating of films that have 'Behind the Scenes'as special_features

SELECT f.title, c.name, f.rating ,special_features FROM film f, category c WHERE special_features = 'Behind the Scenes';

#Show first name and last name of actors that acted in 'ZOOLANDER FICTION'

SELECT a.first_name, a.last_name, f.title FROM actor a ,film f WHERE f.title = 'ZOOLANDER FICTION';

#Show the address, city and country of the store with id 1

SELECT a.address, c.city, co.country, s.store_id FROM address a, city c, country co, store s WHERE s.address_id = a.address_id AND a.city_id=c.city_id AND c.country_id = co.country_id AND s.store_id = 1;

#Show pair of film titles and rating of films that have the same rating.

SELECT f1.title, f2.title, f1.rating  FROM film f1, film f2 WHERE f1.rating <> f2.rating;

#Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).
