/*
===================================================================================
--								Customer Report									 --
===================================================================================
Purpose: 
	- This report consolidates key customer metrics and behaviors.

Highlights:
	1. Gathers essential fields such as names, segments, and transaction details.
	2. Segments customers into categories (VIP, Repeat Customer, One-Time Customer).
	3. Aggregates customer - level metrics:
		- total orders 
		- total sales 
		- total profit
		- total quantity purchased
		- total products purchased
		- first and last order date
		- customer lifespan (in months)
	4. Calculates valuable KPIs:  
		- average order value : 
		Average Order Value = Total Sales / Total Nr. of Orders 
		- average monthly spend :
		Average Monthly Spending = Total Sales / Nr. of Months
=======================================================================================
*/

CREATE VIEW Customer_Report AS
WITH customer_aggregation AS (
    SELECT
        Customer_ID,
        Customer_Name,
        Segment,
        COUNT(DISTINCT Order_ID) AS total_orders,
        ROUND(SUM(Sales), 2) AS total_sales,
        ROUND(SUM(Profit), 2) AS total_profit,
        SUM(Quantity) AS total_quantity,
        COUNT(DISTINCT Product_ID) AS total_products,
        MIN(Order_Date) AS first_order_date,
        MAX(Order_Date) AS last_order_date,
        DATEDIFF(month, MIN(Order_Date), MAX(Order_Date)) AS lifespan_months
    FROM Superstore_Clean
    WHERE Order_Date IS NOT NULL
    GROUP BY
        Customer_ID,
        Customer_Name,
        Segment
)

SELECT
    Customer_ID,
    Customer_Name,
    Segment,

    CASE
        WHEN total_sales >= 5000 THEN 'VIP'
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_segment,

    first_order_date,
    last_order_date,
    lifespan_months,
    total_orders,
    total_sales,
    total_profit,
    total_quantity,
    total_products,

	-- Average Order Value
        ROUND(total_sales / NULLIF(total_orders, 0), 2)
        AS avg_order_value,

	-- Average Monthly Spending
        ROUND(total_sales / NULLIF(lifespan_months + 1, 0), 2)
        AS avg_monthly_spend

FROM customer_aggregation;


/*
=================================================================================================
--									Product Report											   --
=================================================================================================
Purpose: 
	- This report consolidates key product metrics and behaviors.

Highlights: 
	1. Gathers essential fields such as product name, category, subcategory, and price.
	2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
	3. Aggregates product-level metrics:
		- total orders
		- total customers (unique)
		- total sales 
		- total profit
		- total quantity sold
		- product lifespan (in months)
	4. Calculates valuable KPIs:
		- average selling price (ASP)
		- average order revenue (AOR) 
		- average monthly revenue (AMR)
=================================================================================================
*/

CREATE VIEW Product_Report AS
WITH product_aggregation AS (
    SELECT
        Product_ID,
        Product_Name,
        Category,
        Sub_Category,
        MIN(Order_Date) AS first_sale_date,
        MAX(Order_Date) AS last_sale_date,
        DATEDIFF(month, MIN(Order_Date), MAX(Order_Date)) AS lifespan_months,
        COUNT(DISTINCT Order_ID) AS total_orders,
        COUNT(DISTINCT Customer_ID) AS total_customers,
        ROUND(SUM(Sales), 2) AS total_sales,
        ROUND(SUM(Profit), 2) AS total_profit,
        SUM(Quantity) AS total_quantity,
        ROUND(AVG(Price), 2) AS avg_selling_price
    FROM Superstore_Clean
    WHERE Order_Date IS NOT NULL
    GROUP BY
        Product_ID,
        Product_Name,
        Category,
        Sub_Category
)

SELECT
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    first_sale_date,
    last_sale_date,

    CASE
        WHEN total_sales >= 50000 THEN 'High-Performer'
        WHEN total_sales >= 10000 THEN 'Mid-Range'
        ELSE 'Low-Performer'
    END AS product_segment,

    lifespan_months,
    total_orders,
    total_customers,
    total_sales,
    total_profit,
    total_quantity,
    avg_selling_price,

	-- Average Order Revenue
    ROUND(total_sales / NULLIF(total_orders, 0), 2) AS avg_order_revenue,

	-- Average Monthly Revenue
    ROUND(total_sales / NULLIF(lifespan_months + 1, 0), 2) AS avg_monthly_revenue

FROM product_aggregation;
