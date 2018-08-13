# 1)

CREATE OR REPLACE VIEW list_of_customers AS
SELECT c.customer_id AS 'ID', CONCAT(c.first_name,'',c.last_name) AS 'Nombre Completo', a.address AS 'Direccion', a.postal_code AS 'Codigo Postal', a.phone AS 'Telefono', ci.city AS 'Ciudad', co.country AS 'Pais',IF (c.active IS FALSE, 'inactive', 'active') AS 'Status', c.store_id AS 'ID Store' 
FROM customer c
	INNER JOIN address a USING (address_id)
	INNER JOIN city ci USING (city_id)	
	INNER JOIN country co USING (country_id)
	ORDER BY c.customer_id ASC;

SELECT * FROM list_of_customers;

# 2 Create a view named film_details, it should contain the following columns:
# film id,  title, description,  category,  price,  length,  rating, actors  - as a string of all the actors separated by comma. Hint use 
# GROUP_CONCAT

CREATE OR REPLACE VIEW film_details AS
SELECT f.film_id AS 'Film ID', f.title AS 'Titulo', f.description AS 'Descripcion', c.name AS 'Categoria', f.replacement_cost AS 'Price', f.length AS 'Duracion', f.rating AS 'Calificacion', GROUP_CONCAT(DISTINCT a.last_name ORDER BY a.last_name DESC SEPARATOR ',')
FROM film f
	INNER JOIN film_actor fa USING (film_id)
	INNER JOIN actor a USING (actor_id)
	INNER JOIN film_category fc USING (film_id)
	INNER JOIN category c USING (category_id)
	GROUP BY 1,2,3,4,5,6,7;

# 3) Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.

CREATE OR REPLACE VIEW sales_by_film_category 
SELECT c.name AS 'Categoria', SUM(p.amount) AS 'Total'
	FROM category c
	INNER JOIN film_category fc USING (category_id)
	INNER JOIN film f USING (film_id)
	INNER JOIN inventory i USING(film_id)
	INNER JOIN rental r USING (inventory_id)
	INNER JOIN payment p USING (rental_id)
	ORDER BY 2 ASC;	

