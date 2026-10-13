-- ============================================
-- Data Exploration
-- ============================================

-- Preview the first 10 rows
SELECT TOP 10 * 
FROM dbo.Superstore;


-- Count total records/rows
SELECT COUNT(*) AS TotalRows
FROM Superstore;


-- Count total columns
SELECT COUNT(*) AS TotalColumns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Superstore';


-- Review column names and data types 
SELECT 
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Superstore';


-- Summary statistics for sales
SELECT 
	COUNT(*) AS CountRows,
	MIN(Sales) AS MinSales,
	MAX(Sales) AS MaxSales,
	AVG(Sales) AS AvgSales
FROM Superstore;


-- Check missing values
SELECT 
	SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS MissingCustomerID,
	SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS MissingSales,
	SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS MissingProfit
FROM Superstore;


-- Check duplicate records
SELECT *,
	COUNT(*) AS DuplicateRows
FROM Superstore
GROUP BY
	Row_ID,
	Order_ID,
	Order_Date,
	Ship_Date,
	Ship_Mode,
	Customer_ID,
	Customer_Name,
	Segment,
	Country,
	City,
	State,
	Postal_Code,
	Region,
	Product_ID,
	Category,
	Sub_Category,
	Product_Name, 
	Sales, 
	Quantity, 
	Discount,
	Profit
HAVING COUNT(*) > 1;


-- Unique Customer Segments
SELECT DISTINCT Segment FROM Superstore;


-- Unique Customer Ship Modes
SELECT DISTINCT Ship_Mode FROM Superstore;

-- Unique regions
SELECT DISTINCT Region FROM Superstore;

-- Unique categories
SELECT DISTINCT Category FROM Superstore;

-- Unique sub-categories
SELECT DISTINCT Sub_Category FROM Superstore;



-- Count records by region
SELECT
    Region,
    COUNT(*) AS TotalOrders
FROM Superstore
GROUP BY Region
ORDER BY TotalOrders DESC;
