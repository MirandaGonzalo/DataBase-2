CREATE TABLE IF NOT EXISTS film 
(film_id INT(10) NOT NULL AUTO_INCREMENT,
  title VARCHAR(30) NOT NULL,
  description VARCHAR(100),
  release_year DATE,
  CONSTRAINT films_pk PRIMARY KEY (film_id)
);

CREATE TABLE IF NOT EXISTS actor 
(actor_id INT(10) NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(100),
  CONSTRAINT actor_pk PRIMARY KEY (actor_id)
);

CREATE TABLE IF NOT EXISTS film_actor 
(actor_id INT(10) NOT NULL,
film_id INT (10) NOT NULL);

ALTER TABLE actor 
ADD last_update TIMESTAMP NOT NULL;

ALTER TABLE film
ADD last_update TIMESTAMP NOT NULL;

#Alter table add foreign keys to film_actor table 

ALTER TABLE film_actor ADD 
  CONSTRAINT fk_film_actor
    FOREIGN KEY (actor_id)
    REFERENCES actor (actor_id);
    
ALTER TABLE film_actor ADD 
  CONSTRAINT fk_film_actor
    FOREIGN KEY (film_id)
    REFERENCES film (film_id);
    
INSERT INTO actor (actor_id, first_name, last_name) VALUES (1, "Pepe", "Sanchez")

INSERT INTO actor (actor_id, first_name, last_name) VALUES (2, "Juan", "Perez")

INSERT INTO film (film_id, title, description, release_year) VALUES (1, "Gladiador", "Pelicula donde hay gladiadores", '2012-01-01')

INSERT INTO film (film_id, title, description, release_year) VALUES (2, "Titanic", "Pelicula donde se hunde un barco", '1990-04-20')
