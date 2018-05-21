#Exercises

#1-Get the amount of cities per country in the database. Sort them by country, country_id.
#2-Get the amount of cities per country in the database. Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest
#3-Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films. 
	#Show the ones who spent more money first .
#4-Find all the film titles that are not in the inventory. 
#5-Find all the films that are in the inventory but were never rented. 
	#Show title and inventory_id.
	#This exercise is complicated. 
	#hint: use sub-queries in FROM and in WHERE or use left join and ask if one of the fields is null.
#6-Generate a report with:
	#customer (first, last) name, store id, film title, 
	#when the film was rented and returned for each of these customers
	#order by store_id, customer last_name.
	
#7Show sales per store 
	#show store citi, country, manager info and total sales
	#(optional) Use concat to show city and country and manager first and last name

#8Show sales per film rating
#9Which actor has appeared in the most films?

#10Which film categories have the larger film duration (comparing average)?
	#Order by average in descending order
	
#Respuestas

#1) Get the amount of cities per country in the database. Sort them by country, country_id.

SELECT c.country, COUNT(*) AS 'Cantidad de Ciudades'
FROM country c, city ci
WHERE ci.country_id = c.country_id
GROUP BY c.country, c.country_id
ORDER BY c.country, c.country_id;
#Corroboramos que Argentina devuelva 13 ciudades
SELECT COUNT(*) 
FROM country c, city ci 
WHERE ci.country_id = c.country_id AND c.country = 'Argentina';

#2) Get the amount of cities per country in the database. Show only the countries with more than 10 cities, 
#order from the highest amount of cities to the lowest

SELECT c.country, COUNT(*) AS 'Cantidad de Ciudades'
FROM country c, city ci
WHERE ci.country_id = c.country_id 
GROUP BY c.country
HAVING COUNT(ci.city) > 10
ORDER BY COUNT(ci.city) DESC;

#3) Generate a report with customer (first, last) name, address, total films rented and the total 
   #money spent renting films. 
    #Show the ones who spent more money first.
    
SELECT c.first_name, c.last_name, a.address, COUNT(r.customer_id) AS 'Cantidad de Peliculas', SUM(p.amount) AS 'Precio'
FROM customer c, address a, rental r, payment p
WHERE c.address_id = a.address_id 
AND r.customer_id = c.customer_id 
AND c.customer_id = r.customer_id 
AND r.rental_id = p.rental_id
GROUP BY c.first_name, c.last_name, a.address
ORDER BY SUM(p.amount) DESC;

#4-Find all the film titles that are not in the inventory. 
 
SELECT f.title
  FROM film f
 WHERE f.film_id NOT IN (SELECT film_id
                     FROM inventory
                    WHERE inventory.film_id = film_id);
                    
#5-Find all the films that are in the inventory but were never rented. 
	#Show title and inventory_id.
	#This exercise is complicated. 
                    
SELECT f.title, i.inventory_id
FROM film f, inventory i, rental r
WHERE f.film_id NOT IN (SELECT f.film_id
					FROM inventory i, rental r
					WHERE f.film_id = i.film_id AND
					i.inventory_id = r.inventory_id 
					AND r.rental_id IS NULL)
group by f.title, i.inventory_id;

SELECT film.title, inventory_id
FROM film
INNER JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
WHERE rental_id IS NULL;

#6-Generate a report with:
	#customer (first, last) name, store id, film title, 
	#when the film was rented and returned for each of these customers
	#order by store_id, customer last_name.

SELECT DISTINCT c.last_name, c.first_name, c.store_id, film.title, rental.rental_date, rental.return_date
FROM rental
	INNER JOIN customer c USING (customer_id)
	INNER JOIN inventory USING (inventory_id)
	INNER JOIN film USING (film_id)
WHERE rental.return_date IS NOT NULL
ORDER BY store_id, c.last_name;

#7Show sales per store 
	#show store citi, country, manager info and total sales
	#(optional) Use concat to show city and country and manager first and last name
	
SELECT COUNT(*) AS 'Sales Per Store', a.address, c.city, co.country, st.first_name, st.last_name
FROM store
	INNER JOIN address a USING (address_id)
	INNER JOIN city c USING (city_id)
	INNER JOIN country co USING (country_id)
	INNER JOIN staff st USING (store_id)
	INNER JOIN payment pa USING (staff_id)
	GROUP BY a.address, c.city, co.country, st.first_name, st.last_name;
	
#8Show sales per film rating

SELECT COUNT(*) AS 'Sales per Film Rating', f.rating
FROM film f
	INNER JOIN inventory USING (film_id)
	INNER JOIN rental USING (inventory_id)
GROUP BY f.rating;
	
#9Which actor has appeared in the most films?

SELECT COUNT(*) AS 'Cantidad de Peliculas', a.last_name,a.first_name 
FROM actor a 
	INNER JOIN film_actor USING(actor_id)
	INNER JOIN film USING(film_id)
GROUP BY a.last_name, a.first_name 
LIMIT 1;

#10Which film categories have the larger film duration (comparing average)?
	#Order by average in descending order

SELECT c.category, AVG(f.length) AS 


