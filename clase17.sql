1 - Create two or three queries using address table in sakila db:

	-include postal_code in where (try with in/not it operator) 
	-eventually join the table with city/country tables.
	-measure execution time.
	-Then create an index for postal_code on address table.
	-measure execution time again and compare with the previous ones.
	-Explain the results


2 - Run queries using actor table, searching for first and last name columns independently. Explain the differences and why is that happening?

3 - Compare results finding text in the description on table film with LIKE and in the film_text using MATCH ... AGAINST. Explain the results.

/======= Results =======/

1) 	SELECT a.address_id AS 'ID', a.postal_code AS 'Codigo Postal', a.address AS 'Direccion', ci.city AS 'Ciudad', co.country AS 'Pais' 
	FROM address a
	INNER JOIN city ci USING (city_id)
	INNER JOIN country co USING (country_id)
	WHERE a.postal_code > 3000
	ORDER BY 2 DESC; --580 rows in set (0.01 sec)

	SELECT a.address_id AS 'ID', a.postal_code AS 'Codigo Postal', a.address AS 'Direccion' 
	FROM address a
	WHERE a.postal_code BETWEEN 1000 AND 2000
	ORDER BY 2 DESC; --7 rows in set (0.00 sec)

	-- With index for postal_code

	CREATE INDEX postal_code_index
	ON address
	(postal_code DESC);

	--With Index
	SELECT a.address_id AS 'ID', a.postal_code AS 'Codigo 	Postal', a.address AS 'Direccion' 
	FROM address a
	WHERE a.postal_code BETWEEN 1000 AND 2000
	ORDER BY 2 DESC; --7 rows in set (0.00 sec) (In MySql terminal)

	--With Index
	SELECT a.address_id AS 'ID', a.postal_code AS 'Codigo Postal', a.address AS 'Direccion', ci.city AS 'Ciudad', co.country AS 'Pais' 
	FROM address a
	INNER JOIN city ci USING (city_id)
	INNER JOIN country co USING (country_id)
	WHERE a.postal_code > 3000
	ORDER BY 2 DESC; --580 rows in set (0.00 sec) (In MySql terminal)

2)	Run queries using actor table, searching for first and last name columns independently. Explain the differences and why is that happening?

	SELECT a.first_name AS 'Nombre', a.last_name AS 'Apellido' 
	FROM actor a
	WHERE a.first_name LIKE a.last_name
	ORDER BY 1 DESC;

	SELECT a.first_name AS 'Nombre', a.last_name AS 'Apellido' 
	FROM actor a
	WHERE LENGTH(a.first_name) > 8 
	AND LENGTH (a.last_name) < 5
	ORDER BY 1 DESC; 

	SELECT a.first_name AS 'Nombre', a.last_name AS 'Apellido' 
	FROM actor a
	WHERE LENGTH(a.first_name) > LENGTH (a.last_name)
	ORDER BY 1 DESC;  

	

	
