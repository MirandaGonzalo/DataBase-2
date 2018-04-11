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
                WHERE a1.first_name = a2.first_name 
                  AND a1.actor_id <> a2.actor_id); #Devuelve 124
                  
SELECT COUNT(*) FROM actor; #Devuelve 200

SELECT last_name FROM actor;

#2) Find actors that don't work in any film

SELECT a.first_name,a.last_name
  FROM actor a 
 WHERE NOT EXISTS (SELECT * 
                     FROM film_actor fa 
                    WHERE fa.actor_id = a.actor_id); 


#3.Find customers that rented only one film

#4.Find customers that rented more than one film
				                    
#5.List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'

SELECT a.first_name, a.last_name 
  FROM actor a 
 WHERE a.actor_id IN (SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="BETRAYED REAR") 
   OR a.actor_id  IN (SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="CATCH AMISTAD")
ORDER BY a.first_name;
 

#6.List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'

SELECT a.first_name, a.last_name 
  FROM actor a 
 WHERE a.actor_id IN (SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="BETRAYED REAR") 
   AND a.actor_id NOT IN(SELECT a.actor_id 
                         FROM film_actor fa, film f 
                        WHERE fa.actor_id = a.actor_id AND f.film_id = fa.film_id AND f.title="CATCH AMISTAD")
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