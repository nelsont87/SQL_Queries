USE sakila;

SELECT * FROM actor LIMIT 10;

SELECT first_name, last_name
FROM actor;

SELECT CONCAT(first_name, ' ' , last_name) AS "Actor Name"
FROM actor;

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'Joe%';

SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

SELECT last_name, first_name
FROM actor
WHERE last_name LIKE '%LI%';

SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan' , 'Bangladesh', 'China');

SHOW TABLES;

ALTER TABLE actor
ADD COLUMN description BLOB;

ALTER TABLE actor
DROP COLUMN description;

SELECT * FROM actor;

SELECT DISTINCT last_name
FROM actor;

SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS" ;

UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO" AND last_name = "WILLIAMS" ;

SHOW CREATE TABLE address;

SELECT 
	s.first_name,
    s.last_name,
    a.address
FROM
	staff s
INNER JOIN address a
	ON a.address_id = s.address_id;

SELECT * FROM payment;
	
SELECT 
	sum(p.amount)
FROM 
	staff s
LEFT JOIN payment p USING(staff_id)
WHERE p.payment_date LIKE "2005-08%";

SELECT 
	COUNT(a.actor_id),
    f.title
FROM film f
INNER JOIN film_actor a ON f.film_id = a.film_id
GROUP BY f.title;

SELECT
	COUNT(i.inventory_id),
	f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible"
GROUP BY f.title;

SELECT
    c.last_name,
    SUM(p.amount)
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.last_name
ORDER BY c.last_name;
    
SELECT title
FROM film
WHERE title LIKE "K%" OR "Q%" IN
	(SELECT language_id
		FROM language
		WHERE name = "English");

SELECT
	first_name,
    last_name
FROM actor
WHERE actor_id IN
	(
	SELECT actor_id
    FROM film_actor
    WHERE film_id IN
		(
		SELECT film_id
        FROM film
        WHERE title = "Alone Trip"
        )
	);
    
SELECT 
	c.first_name,
    c.last_name,
    c.email
FROM customer c
LEFT JOIN address a ON c.address_id = a.address_id
LEFT JOIN city ci ON ci.city_id = a.city_id
LEFT JOIN country co ON co.country_id = ci.country_id
WHERE co.country = "Canada";

SELECT f.title
FROM film f
INNER JOIN film_category fi ON f.film_id = fi.film_id
INNER JOIN category c ON c.category_id = fi.category_id
WHERE c.name = "Family";
    
SELECT
	COUNT(r.rental_id),
	f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC;


SELECT
	SUM(p.amount),
	c.store_id
FROM payment p
LEFT JOIN customer c ON p.customer_id = c.customer_id
GROUP BY c.store_id;

SELECT
	s.store_id,
	c.city,
    co.country
FROM store s
LEFT JOIN address a ON s.address_id = a.address_id
LEFT JOIN city c ON c.city_id = a.city_id
LEFT JOIN country co ON c.country_id = co.country_id;

SELECT
	c.name,
    SUM(p.amount)
FROM payment p
LEFT JOIN rental r ON r.rental_id = p.rental_id
LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
LEFT JOIN film_category f ON i.film_id = f.film_id
LEFT JOIN category c ON c.category_id = f.category_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC LIMIT 5;

CREATE VIEW top_five_genres AS
SELECT
	c.name,
    SUM(p.amount)
FROM payment p
LEFT JOIN rental r ON r.rental_id = p.rental_id
LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
LEFT JOIN film_category f ON i.film_id = f.film_id
LEFT JOIN category c ON c.category_id = f.category_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC LIMIT 5;

SELECT * FROM top_five_genres;

DROP VIEW top_five_genres;
