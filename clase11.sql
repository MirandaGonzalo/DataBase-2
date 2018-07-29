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

SELECT co.country, COUNT(ci.city) AS 'Cantidad de Ciudades'
FROM country co
	INNER JOIN city ci USING (country_id)
	GROUP BY co.country, co.country_id
	ORDER BY co.country, co.country_id;
		
#2-Get the amount of cities per country in the database. Show only the countries with more than 10 cities, 
#order from the highest amount of cities to the lowest

SELECT COUNT(city.city) AS 'Cantidad de Ciudades', country.country 
FROM country 
	INNER JOIN city USING (country_id)
	GROUP BY country.country
HAVING COUNT(city.city) > 10
ORDER BY 1 DESC;

#3-Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films. 

SELECT customer.first_name, customer.last_name, address.address, COUNT(rental.rental_id) AS 'Cantidad de Rentas', SUM(payment.amount) AS 'Total'
FROM customer 
	INNER JOIN address USING (address_id)
	INNER JOIN rental USING (customer_id)
	INNER JOIN payment USING (customer_id)
GROUP BY 1,2,3
ORDER BY 5 DESC;

#4-Find all the film titles that are not in the inventory. 

SELECT film.title
FROM film 
	WHERE film.film_id NOT IN 
	(SELECT film_id FROM inventory);
	
#5-Find all the films that are in the inventory but were never rented. 
	#Show title and inventory_id.
	#This exercise is complicated. 

SELECT film.title, inventory.inventory_id, rental.rental_id
FROM film 
	INNER JOIN inventory USING (film_id)
	LEFT OUTER JOIN rental USING (inventory_id)
	WHERE rental.rental_id IS NULL

	
#6-Generate a report with:
	#customer (first, last) name, store id, film title, 
	#when the film was rented and returned for each of these customers
	#order by store_id, customer last_name.

SELECT customer.first_name, customer.last_name, inventory.store_id, film.title, rental.rental_date, rental.return_date
FROM film 
	INNER JOIN inventory USING (film_id)
    INNER JOIN rental USING (inventory_id)
    INNER JOIN customer USING (customer_id)
WHERE rental.return_date IS NOT NULL
ORDER BY inventory.store_id, customer.last_name;
	
	
#7Show sales per store 
	#show store citi, country, manager info and total sales
	#(optional) Use concat to show city and country and manager first and last name

SELECT CONCAT(staff.last_name, ',' ,staff.first_name) AS manager, CONCAT(city.city, ',' ,country.country) AS direccion, COUNT(*) AS 'Total de Ventas' , SUM(payment.amount) AS 'Precio'
FROM store 
	INNER JOIN address USING (address_id)
	INNER JOIN city USING (city_id)
	INNER JOIN country USING (country_id)
	INNER JOIN staff USING (store_id)
	INNER JOIN payment USING (staff_id)
GROUP BY 1,2;

33489.47
33927.04

#8Show sales per film rating

SELECT film.rating, COUNT(*), SUM(payment.amount)
FROM film
	INNER JOIN inventory USING (film_id)
	INNER JOIN rental USING (inventory_id)
	INNER JOIN payment USING (rental_id)
GROUP BY film.rating;

#9Which actor has appeared in the most films?

SELECT actor.last_name, actor.first_name, COUNT(actor_id) AS cantidad
FROM actor 
	INNER JOIN film_actor USING (actor_id)
GROUP BY actor_id
ORDER BY COUNT(actor_id) DESC
LIMIT 1;

#10Which film categories have the larger film duration (comparing average)?
	#Order by average in descending order

SELECT category.name, AVG(film.length)
FROM film
	INNER JOIN film_category USING (film_id)
	INNER JOIN category USING (category_id)
GROUP BY 1
HAVING (AVG(film.length) > (SELECT AVG(length) FROM film))
ORDER BY AVG(film.length) DESC;


SELECT category.name, AVG(film.length)
FROM category
	INNER JOIN film_category USING (category_id)
	INNER JOIN film USING (film_id)
GROUP BY 1
HAVING (AVG(film.length) > (SELECT AVG(length) FROM film))
ORDER BY AVG(film.length) DESC;


Genere un reporte mostrando el nombre y apellido de cada customer con la cantidad
de películas que alquilo y la cantidad de dinero que ha gastado.
La cantidad de películas debe ser el total (incluyendo las que no ha devuelto todavía)
mostrar solo los clientes que hayan gastado entre 100 y 150 dolares.


SELECT customer.first_name, customer.last_name, COUNT(rental.rental_date) AS 'Cantidad de alquileres',SUM(payment.amount) AS 'Total Pagado'
FROM customer
	INNER JOIN rental USING (customer_id)
	INNER JOIN payment USING (rental_id)
WHERE rental.rental_date IS NOT NULL
GROUP BY customer.customer_id
HAVING SUM(payment.amount) BETWEEN 100 AND 150
ORDER BY 1,2;

Muestre un reporte de la cantidad de películas rentadas por país y por categoría de películas
Columnas a mostrar nombre del país, nombre la categoría y cantidad de películas alquiladas
Ejemplo:
Pais Categoria Cantidad
Argentina Action 25
Argentina Animation 26
Argentina Children 13
Argentina Classics 18

SELECT country.country , category.name, COUNT(rental.rental_date) AS 'Cantidad'
FROM rental
	INNER JOIN customer USING (customer_id)
	INNER JOIN address USING (address_id)
	INNER JOIN city USING (city_id)
	INNER JOIN country USING (country_id)
	INNER JOIN inventory USING (inventory_id)
	INNER JOIN film USING (film_id)
	INNER JOIN film_category USING (film_id)
	INNER JOIN category USING (category_id)
GROUP BY 1,2;
	

Muestre la cantidad películas que tienen los clientes alquiladas (es decir que todavía no se han devuelto)
agrupadas por rating (G, PG, etc...)

SELECT film.rating, COUNT(*) AS 'Cantidad'
FROM customer
	LEFT JOIN rental USING(customer_id)
	INNER JOIN inventory USING (inventory_id)
	INNER JOIN film USING (film_id)
	WHERE rental.return_date IS NULL
GROUP BY 1;


Muestre los clientes y actores que compartan el apellido

Se deben mostrar todos los clientes, y cuando los actores compartan el apellido, mostrar esos actores. 
También mostrar la cantidad de películas en las que un actor determinado actuó.


SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.actor_id) AS 'num_of_films',
customer.customer_id, customer.first_name, customer.last_name
FROM store
	RIGHT JOIN customer USING (store_id)
	RIGHT JOIN actor USING (last_name)
	INNER JOIN film_actor USING (actor_id)
GROUP BY 1,2,3,5,6,7
ORDER BY actor.last_name;
	
	