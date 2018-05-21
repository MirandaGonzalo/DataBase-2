SELECT MAX(LENGTH) FROM film;

#1.List all the actors that share the last name. Show them in order
#2.Find actors that don't work in any film
#3.Find customers that rented only one film
#4.Find customers that rented more than one film
#5.List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
#6.List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'
#7.List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
#8.List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'


#1) List all the actors that share the last name. Show them in order
SELECT first_name,last_name 
  FROM actor a1 
 WHERE EXISTS (SELECT * 
                 FROM actor a2 
                WHERE a1.last_name = a2.last_name 
                  AND a1.actor_id <> a2.actor_id)
ORDER BY last_name, first_name; #Devuelve 134
                  
SELECT first_name, last_name
FROM actor a1
WHERE last_name IN (SELECT last_name
					FROM actor a2
					WHERE a1.actor_id <> a2.actor_id); #Devuelve 134

SELECT COUNT(*) FROM actor; #Devuelve 200

SELECT last_name FROM actor;

#2) Find actors that don't work in any film

SELECT a.first_name,a.last_name
  FROM actor a 
 WHERE NOT EXISTS (SELECT * 
                     FROM film_actor fa 
                    WHERE fa.actor_id = a.actor_id); 
                    
SELECT first_name, last_name
FROM actor a1
WHERE actor_id NOT IN (SELECT DISTINCT actor_id
						FROM film_actor)		


#3.Find customers that rented only one film

SELECT DISTINCT r1.customer_id FROM rental r1 
WHERE NOT EXISTS(SELECT * FROM rental r2 
	WHERE r1.customer_id = r2.customer_id
	AND r1.rental_id <> r2.rental_id);

#4.Find customers that rented more than one film
	
SELECT DISTINCT r.customer_id 
FROM rental r 
WHERE EXISTS (SELECT* 
	FROM rental r2
	WHERE r.customer_id = r2.customer_id
	AND r.rental_id <> r2.rental_id);
	
#5.List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'

SELECT a.first_name, a.last_name 
  FROM actor a 
 WHERE a.actor_id IN (SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title IN 
                        ("BETRAYED REAR", "CATCH AMISTAD")) 
ORDER BY a.first_name;
 
#6.List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'

SELECT a.first_name, a.last_name 
  FROM actor a 
 WHERE a.actor_id IN (SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id 
                        AND f.film_id = fa.film_id 
                        AND f.title="BETRAYED REAR") 
   AND a.actor_id NOT IN(SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id 
                        AND f.film_id = fa.film_id 
                        AND f.title="CATCH AMISTAD")
ORDER BY a.first_name;

#7.List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'

SELECT * FROM actor a, film f, film_actor fa WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id 
AND f.title="BETRAYED REAR";

SELECT * FROM actor a, film f, film_actor fa WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id 
AND f.title="CATCH AMISTAD";

SELECT a.first_name, a.last_name 
  FROM actor a 
 WHERE a.actor_id IN (SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="BETRAYED REAR") 
   AND a.actor_id IN(SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="CATCH AMISTAD")
ORDER BY a.first_name;
#8.List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'

SELECT a.first_name, a.last_name 
  FROM actor a 
 WHERE a.actor_id NOT IN (SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="BETRAYED REAR") 
   AND a.actor_id NOT IN(SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="CATCH AMISTAD")
ORDER BY a.first_name;

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id NOT IN (SELECT actor.actor_id
					FROM film_actor, actor, film
					WHERE actor.actor_id = film_actor.actor_id
					AND film.film_id = film_actor.film_id
					AND title IN ("BETRAYED REAR","CATCH AMISTAD")
					and actor.actor_id = film_actor.actor_id)
					