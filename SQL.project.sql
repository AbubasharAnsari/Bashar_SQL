use pizza;
select * from food_sales;

# total sales for all order

select sum(total_price) as total_sales from food_sales;
select round(sum(total_price),2) as total_sales from food_sales;

# total order placed on the basis of order_id

select count(distinct order_id) as order_count from food_sales;

# average pizza per order? in the whole dataset
 
select sum(quantity)/count(distinct order_id) as avg_pizza_per_order from food_sales;

#top 5 best selling pizza

select pizza_name,sum(total_price) as total_revenue from food_sales
group by pizza_name
limit 5;

# month trend orders

select date_format(str_to_date(order_date,'%d-%m-%y'),'%M') as formatted_date,
count(distinct order_id) as total_order from food_sales
group by formatted_date;

# day trend order

select date_format(str_to_date(order_date,'%d-%m-%y'),'%W') as formatted_day,
count(distinct order_id) as total_order from food_sales
group by formatted_day;

# category wise percent sales

select pizza_category,sum(total_price)*100/(select sum(total_price) from food_sales)
as total_percent_sales from food_sales
group by pizza_category;

# quaterly pizza sales

select quarter(str_to_date(order_date,'%d-%m-%y'))
as qtr, round(sum(total_price)) 
as quaterly_sales from food_sales
group by qtr;

# pizza size percent sales

select pizza_size,sum(total_price)*100/(select sum(total_price) from food_sales)
as total_percent_pizza_size from food_sales
group by pizza_size


# week wise total sales


select date_format(str_to_date(order_date,'%d-%m-%y'),'%W') as formatted_day,
sum(total_price) from food_sales
group by formatted_day;


# weekends VS weekdays sales


select
   case
   when dayofweek(str_to_date(order_date,'%d-%m-%y')) in(1,7) then 'weekends'
   else 'weekdays'
end as day_category,
sum(total_price) as total_sales from food_sales
group by day_category;