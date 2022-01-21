# 1- Write a query to display for each store its store ID, city, and country.
use sakila;
select s.store_id, ci.city, co.country from sakila.store s
join sakila.address a
on s.address_id = a.address_id
join sakila.city ci
on a.city_id = ci.city_id
join sakila.country co
on ci.country_id = co.country_id
group by 1
order by 1;
# 2- Write a query to display how much business, in dollars, each store brought in.
SELECT 
    s.store_id, SUM(p.amount) AS bussiness_amount
FROM
    sakila.store s
        JOIN
    sakila.staff sf ON s.store_id = sf.store_id
        JOIN
    sakila.payment p ON sf.staff_id = p.staff_id
GROUP BY 1
ORDER BY 1;

# 3- What is the average running time of films by category?

SELECT 
    c.name as category_name, round(avg(f.length),2) AS average_running_time
FROM
    film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
GROUP BY 1
ORDER BY 2 DESC;

# 4- Which film categories are longest?
# Answer: if we consider just the longest film, the answer is action with 185 min. if we consider average length, the answer is sports with average length of 128.20

SELECT 
    c.name AS category_name, round(avg(f.length),2) AS max_average_running_time
FROM
    film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
GROUP BY 1
ORDER BY 2 DESC
limit 1;
# 5- Display the most frequently rented movies in descending order.
SELECT 
    f.title, count(r.rental_id) AS most_frequently_rented_movies
FROM
    film f
        JOIN
    inventory i  ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 1
ORDER BY 2 DESC
limit 5;

# 6- List the top five genres in gross revenue in descending order.

SELECT 
    c.name AS category_name, SUM(p.amount) AS gross_revenue
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id
        JOIN
    film f ON f.film_id = fc.film_id
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
        JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

# 7- Is "Academy Dinosaur" available for rent from Store 1?
# Answer: yes it is available for rent from Store 1.
SELECT 
    f.title, i.store_id, r.rental_id
FROM
    film f
        JOIN
    inventory i  ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
where f.title = "ACADEMY DINOSAUR" and i.store_id = 1
GROUP BY 1;