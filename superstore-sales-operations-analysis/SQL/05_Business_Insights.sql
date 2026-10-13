-- ====================================== --
--			Business Insights			  --
-- ====================================== --

-- ====================================== --
--			Sales Trend Analysis		  --
-- ====================================== --

-- Sales By Month
SELECT
	DATETRUNC(month, Order_Date) AS Order_Month,
	ROUND(SUM(Sales), 2) AS Total_Sales,
	COUNT(DISTINCT Customer_ID) AS Total_Customers,
	SUM(Quantity) AS Total_Quantity
FROM Superstore_Clean
WHERE Order_Date IS NOT NULL
GROUP BY DATETRUNC(month, Order_Date)
ORDER BY DATETRUNC(month, Order_Date);


-- Sales By Year
SELECT 
	DATETRUNC(year, Order_Date) AS Order_Year,
	ROUND(SUM(Sales), 2) AS Total_Sales,
	COUNT(DISTINCT Customer_ID) AS Total_Customers,
	SUM(Quantity) AS Total_Quantity
FROM Superstore_Clean
WHERE Order_Date IS NOT NULL
GROUP BY DATETRUNC(year, Order_Date)
ORDER BY DATETRUNC(year, Order_Date);


-- Profit By Month
SELECT 
	DATETRUNC(month, Order_Date) AS Order_Month,
	ROUND(SUM(Sales), 2) AS Total_Sales,
	SUM(Profit) AS Total_Profit
FROM Superstore_Clean
WHERE Order_Date IS NOT NULL
GROUP BY DATETRUNC(month, Order_Date)
ORDER BY DATETRUNC(month, Order_Date);

-- Orders By Month
SELECT 
	DATETRUNC(month, Order_Date) AS Order_Month,
	COUNT(DISTINCT Order_ID) AS Total_Orders
FROM Superstore_Clean
WHERE Order_Date IS NOT NULL
GROUP BY DATETRUNC(month, Order_Date)
ORDER BY DATETRUNC(month, Order_Date);


-- New Customers By First Order Year
WITH First_Order AS (
	SELECT	
		Customer_ID,
		MIN(Order_Date) AS First_Order_Date
	FROM Superstore_Clean
	GROUP BY Customer_ID
)

SELECT 
	YEAR(First_Order_Date) AS First_Order_Year,
	COUNT(Customer_ID) AS New_Customers
FROM First_Order
GROUP BY YEAR(First_Order_Date)
ORDER BY First_Order_Year;


-- ====================================== --
--			Cumulative Performance		  --
-- ====================================== --

-- Monthly Sales and Profit
WITH monthly_sales AS (
	SELECT 
		DATETRUNC(month, Order_Date) AS Order_Month, 
		ROUND(SUM(Sales), 2) AS Total_Sales,
		ROUND(SUM(Profit), 2) AS Total_Profit
	FROM Superstore_Clean
	WHERE Order_Date IS NOT NULL
	GROUP BY DATETRUNC(month, Order_Date)
)

SELECT 
	Order_Month,
	Total_Sales,
	Total_Profit,

	-- Running Total Sales
	SUM(Total_Sales) OVER (
		PARTITION BY YEAR(Order_Month)
		ORDER BY Order_Month) AS Running_Total_Sales,

	-- Running Total Profit
	SUM(Total_Profit) OVER (
		PARTITION BY YEAR(Order_Month)
		ORDER BY Order_Month) AS Running_Total_Profit,

	-- Moving Average Sales
	ROUND(AVG(Total_Sales) OVER (
		ORDER BY Order_Month 
		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
		), 2) AS Moving_Average_Sales 

FROM monthly_sales
ORDER BY Order_Month;


-- ====================================== --
--			Performance Analysis		  --
-- ====================================== --

-- Year Over Year Sales

WITH yearly_sales AS (
    SELECT
        YEAR(Order_Date) AS Order_Year,
        ROUND(SUM(Sales), 2) AS Total_Sales
    FROM Superstore_Clean
    WHERE Order_Date IS NOT NULL
    GROUP BY YEAR(Order_Date)
)

SELECT
    Order_Year,
    Total_Sales,
    ROUND(LAG(Total_Sales) OVER (
        ORDER BY Order_Year
    ), 2) AS Previous_Year_Sales,
    ROUND(
        Total_Sales - LAG(Total_Sales) OVER (
            ORDER BY Order_Year
        ), 2
    ) AS Sales_Difference,
    CONCAT(ROUND(
        (
            (Total_Sales - LAG(Total_Sales) OVER (
                ORDER BY Order_Year
            ))
            / LAG(Total_Sales) OVER (
                ORDER BY Order_Year
            )
        ) * 100,
        2
    ), ' %') AS Sales_Growth_Percentage
FROM yearly_sales
ORDER BY Order_Year;

-- Year-Over-Year Profit
WITH yearly_profit AS (
    SELECT
        YEAR(Order_Date) AS Order_Year,
        SUM(Profit) AS Total_Profit
    FROM Superstore_Clean
    WHERE Order_Date IS NOT NULL
    GROUP BY YEAR(Order_Date)
)

SELECT
    Order_Year,
    ROUND(Total_Profit, 2) AS Total_Profit,
    ROUND(LAG(Total_Profit) OVER (
            ORDER BY Order_Year), 2) AS Previous_Year_Profit,
    ROUND(
        Total_Profit - LAG(Total_Profit) OVER (
            ORDER BY Order_Year
        ), 2
    ) AS Profit_Difference,
    CONCAT(ROUND((
            (Total_Profit - LAG(Total_Profit) OVER (
                ORDER BY Order_Year))
            / NULLIF(
                LAG(Total_Profit) OVER (
                    ORDER BY Order_Year
                ), 0
            )
        ) * 100,
        2
    ), ' %') AS Profit_Growth_Percentage
FROM yearly_profit
ORDER BY Order_Year;

-- Category Performance
SELECT
	Category,
	ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Discount), 4) AS Average_Discount
FROM Superstore_Clean
GROUP BY Category
ORDER BY Total_Sales DESC;


-- Category Growth by Year

WITH category_yearly_sales AS (
    SELECT
        YEAR(Order_Date) AS Order_Year,
        Category,
        SUM(Sales) AS Total_Sales
    FROM Superstore_Clean
    WHERE Order_Date IS NOT NULL
    GROUP BY
        YEAR(Order_Date),
        Category
)

SELECT
    Order_Year,
    Category,
    ROUND(Total_Sales, 2) AS Total_Sales,
    ROUND(
        LAG(Total_Sales) OVER (
            PARTITION BY Category
            ORDER BY Order_Year
        ), 2
    ) AS Previous_Year_Sales,
    ROUND(
        Total_Sales - LAG(Total_Sales) OVER (
            PARTITION BY Category
            ORDER BY Order_Year
        ), 2
    ) AS Sales_Difference,
    CONCAT(ROUND(
        (
            (Total_Sales - LAG(Total_Sales) OVER (
                PARTITION BY Category
                ORDER BY Order_Year
            ))
            / NULLIF(
                LAG(Total_Sales) OVER (
                    PARTITION BY Category
                    ORDER BY Order_Year
                ), 0
            )
        ) * 100,
        2
    ), '%') AS Growth_Percentage
FROM category_yearly_sales
ORDER BY Category, Order_Year;


-- ====================================== --
--			Part-To-Whole Analysis		  --
-- ====================================== --

-- % Sales By Category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    CONCAT(ROUND(
        SUM(Sales) / SUM(SUM(Sales)) OVER () * 100,
        2
    ), '%') AS Sales_Percentage
FROM Superstore_Clean
GROUP BY Category
ORDER BY Total_Sales DESC;

-- % Sales By Region
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    CONCAT(ROUND(
        SUM(Sales) / SUM(SUM(Sales)) OVER () * 100,
        2
    ), '%') AS Sales_Percentage
FROM Superstore_Clean
GROUP BY Region
ORDER BY Total_Sales DESC;


-- % Profit By Segment
SELECT
    Segment,
    SUM(Profit) AS Total_Profit,
    CONCAT(ROUND(
        SUM(Profit) / SUM(SUM(Profit)) OVER () * 100,
        2
    ), '%') AS Profit_Percentage
FROM Superstore_Clean
GROUP BY Segment
ORDER BY Total_Profit DESC;



-- ====================================== --
--			Customer Segmentation		  --
-- ====================================== --
-- Segment customers based on their total sales and order frequency
WITH customer_summary AS (
    SELECT
        Customer_ID,
        Customer_Name,
        SUM(Sales) AS Total_Sales,
        COUNT(DISTINCT Order_ID) AS Total_Orders
    FROM Superstore_Clean
    GROUP BY Customer_ID, Customer_Name
)

SELECT
    Customer_ID,
    Customer_Name,
    Total_Sales,
    Total_Orders,
    CASE
        WHEN Total_Sales >= 10000 THEN 'VIP'
        WHEN Total_Sales >= 5000 THEN 'High Value'
        WHEN Total_Orders = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS Customer_Segment
FROM customer_summary
ORDER BY Total_Sales DESC;

