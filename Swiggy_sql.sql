use swiggy;
select * from swiggy
where city = 'Bangalore';

-- 1. Which top 5 restaurant offers highest number of categories?

select restaurant_name , count(distinct menu_category) as no_of_categories
from swiggy
group by restaurant_name
order by no_of_categories desc
limit 5;

-- 2. Which is the restaurant providing the lowest average price for all items?

select distinct restaurant_name , round(avg(price),2) as avg_price
from swiggy
group by restaurant_name
order by avg_price
limit 1;

-- 3. Which Restaurant offers the most no of items in the main course category?

select distinct restaurant_name , menu_category , count(item) as no_of_items
from swiggy
where menu_category='Main Course'
group by restaurant_name
order by no_of_items desc
limit 1;

-- 4. Details of restaurants that have the same name but are located in different cities.

select distinct s1.restaurant_name 
from swiggy s1
join swiggy s2 on s1.restaurant_name = s2.restaurant_name and s1.city <> s2.city;

-- 5. Find the restaurant that have an cost which is higher than the total average cost of all restaurants together

select distinct restaurant_name , cost_per_person
from swiggy
where cost_per_person > (select avg(cost_per_person) from swiggy)
order by cost_per_person; 

-- 6. Top 5 most expensive restaurants that offer cuisine other than indian cuisine.

select distinct restaurant_name , cuisine , cost_per_person
from swiggy
where cuisine not like '%Indian%'
order by cost_per_person desc
limit 5;

-- Highest price of item under the recommended menu category for each restaurant?

select distinct restaurant_name , menu_category , max(price) over(partition by restaurant_name) as highest_price
from swiggy
where menu_category = 'Recommended';

-- 7. Most common cuisine among the restaurants

with cte1 as
(select cuisine , count(cuisine) as no_of_cuisine , dense_rank() over(order by count(cuisine) desc) as ranking
from swiggy
group by cuisine)
select cuisine , no_of_cuisine 
from cte1
where ranking = 1;

-- 8. No of Resturants having the word 'Pizza' in their name

select distinct restaurant_name
from swiggy
where restaurant_name like '%PIZZA%';

-- 9. Number of restaurants have a rating greater than 4.5?

select count(distinct restaurant_name) as 'no_of_res_rating > 4.5' 
from swiggy
where rating > 4.5;
 