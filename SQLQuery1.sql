select gender as g,sum(purchase_amount) as f
from Employees
group by gender;

-- Q-2
select customer_id , purchase_amount
from Employees
where discount_applied='Yes' and purchase_amount >= (select AVG(purchase_amount) from Employees)

--5 prod highest rating
select  top 5 item_purchased,round(avg(review_rating),2) as rating
from Employees
group by item_purchased
order  by rating desc

--Q-3 Comair avg purchase amount of Express	 and Standard of shipping_type
select shipping_type as g,avg(purchase_amount) as avrge
from Employees
where shipping_type in ('Express','Standard')
group by shipping_type

-- Q-4 subs vs non_subs of avg and purchase amt
select subscription_status as g,count(customer_id) as cust,avg(purchase_amount) as avrge , sum(purchase_amount) as spr
from Employees
group by subscription_status


--5 top prod % with discount applyed
select  top 5 item_purchased,round((sum(purchase_amount)*100/ (select sum(purchase_amount) from Employees)),2) as rating
from Employees
where discount_applied='Yes'
group by item_purchased
order  by rating desc


--Q-6 Segement customer according to their purchase power 
with cte as (select customer_id,previous_purchases,
					case 
						when previous_purchases=1 then 'New'
						when 	previous_purchases between 2 and 10 then 'Returning'
						else 'Loyal' end as segment

				from Employees)

select segment , count(*) as cnt
from cte
group by segment;

--Top 3 prod within each category 
with cte as (select category,item_purchased,sum(purchase_amount) as amt
from Employees 
group by category,item_purchased)

select *  
from (select *,dense_rank() over(partition by category order by amt desc) as rn from cte) t
where rn <=3

--Revenue contribution by ages
select Age_Group,sum(purchase_amount) as revenue
from Employees
group by Age_Group
order by revenue desc

