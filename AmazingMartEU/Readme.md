# Query to find the best perfoming month/year for each product category in each region
We are looking to find a list of month-year for each product category in each region that has the highest target attainment percentage (ie: Rank 1)
## Tables
1. **amazing_eu** - Table that contains customer details (order_id, order_date,customer_name,region etc..)
2. **amazing_eu_order** - Table that contains customer order details (order_id,product_name,category,quantity,sales etc..)
3. **amazing_eu_target** - Table that contains sales target data for each month-year (order_month_year,target_sales)

## Brief Procedure
- Extract first three letters from month name and last two numbers from year in column 'order_date' and concat them as 'Month-year' in amaing_eu table.
- Remove special characters like "$" and "," from columns sales and cast into float data type in amaing_eu_order table.
- Create an aggregated table using the above tables that gives sum(sales) for each month-year,product_category and region using left join.
- Combine the aggregated table with amazing_eu_target table using left join. Create a column target_attainment% by dividing sum(sales) by target_sales.
- Rank the target_attrainment percentage by descending order and filter for rank = 1 for each region in each product category.

## SQL Concepts and Functions used in this query
1. Concepts
     - Common Table Expression [CTE]
     - Left Join
     - Group by / Order by
2. Functions
     - **concat()** - stitches two or more strings together.
     - **cast()** - Used to convert a column from one data type to another.
     - **trim()** - Used to remove whitespaces or specific charecters from a string.
     - **replace()**  -Used to replace a specific character in string with user defined char.
     - **left()/right()** - Used to pick specfic set of characters from a string.
     - **extract()** - Used to extract d/m/y from a date.
     - **to_char** - Used to convert date values to character string values.
     - **sum()** - Returns total sum of a numeric column.
     - **dense_rank()** - Assigns rank to each row based on a specifc partiton and order
		 
		 
