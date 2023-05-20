with Best_performing_month_year_for_each_category_in_each_region as ( --CTE Begins
select t4.month_year,
t4.region,
t4.category,
t4.c_sales,
t5.target,
--finding target attainment%
concat(round(cast(((t4.c_sales/t5.target)*100) as double precision)),'%') as target_percent,
--ranking region and category based on highest to lowest target attainment
dense_rank() over (partition by t4.region,t4.category order by cast(((t4.c_sales/t5.target)*100) as double precision) desc) as ranker
from
(select 
--extracting month name from date,trimming trailing white spaces and picking the first three letters from month
--extracing year from date, casting to charecter data type and picking the last two characters from year
--concating month + year
concat(left(trim(trailing from (to_char(order_date,'Month'))),3),'-',right((cast(extract(year from order_date) as varchar)),2)) as month_year,
category,
region,
--removing special char like "$" & "," from amount and converting data from str to float
--summing sales_amount for specific month_year
sum(cast(replace(replace(sales,'$',''),',','') as double precision)) as C_sales
from
(select t1.order_id,
t1.order_date,
t1.customer_name,
t1.city,
t1.country,
t1.region,
t1.segment,
t1.ship_date,
t1.ship_mode,
t1.state,
t2.product_name,
t2.discount,
t2.sales,
t2.profit,
t2.quantity,
t2.category,
t2.sub_category
from public.amazing_eu t1 left join public.amazing_eu_order t2 on --joining customer details with order details based on order_id in both tables
t1.order_id = t2.order_id) t3 group by 1,2,3 order by 1,2,3)t4 left join --aggregating sum(sales) by grouping month_year,region,category and joining them with target table based on month_year & category in both tables
(select monthoforderdate,
category,
--removing special char like "$" & "," from amount and converting data from str to float
cast(replace(replace(target,'$',''),',','') as double precision) as target
from public.amazing_eu_target)t5 on
t4.month_year = t5.monthoforderdate and t4.category = t5.category order by 2,3)
--CTE ends

--query to find the best performing month/year for each product category in each region
select * from Best_performing_month_year_for_each_category_in_each_region where ranker = 1 order by 2,3
