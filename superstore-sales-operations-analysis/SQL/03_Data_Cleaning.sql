-- ============================================
-- Data Cleaning
-- ============================================


-- Create a working copy
SELECT * 
INTO Superstore_Clean 
FROM Superstore;

-- ======================================
-- 1. Converting Data Types --
-- ======================================


-- Row_ID to int 
ALTER TABLE Superstore_Clean
ALTER COLUMN Row_ID INT;

-- Order_Date to Date
ALTER TABLE Superstore_Clean
ALTER COLUMN Order_Date DATE;

-- Ship_Date to Date 
ALTER TABLE Superstore_Clean
ALTER COLUMN Ship_Date DATE;


-- Quantity to int
ALTER TABLE Superstore_Clean
ALTER COLUMN Quantity INT;


-- Discount to Decimal
ALTER TABLE Superstore_Clean
ALTER COLUMN Discount DECIMAL(5,4);

-- Profit to Decimal
ALTER TABLE Superstore_Clean
ALTER COLUMN Profit DECIMAL(10,2);


-- ======================================
-- 2. Rename Column -- 
-- ======================================


-- Renaming State to State_Name
EXEC sp_rename
'Superstore_Clean.State',
'State_Name',
'COLUMN';

-- To verify the changes
EXEC sp_help Superstore_Clean;


-- ======================================
--		3. Validate text consistency
-- ======================================

SELECT DISTINCT Segment 
FROM Superstore_Clean;

SELECT DISTINCT Ship_Mode
FROM Superstore_Clean;

SELECT DISTINCT Region 
FROM Superstore_Clean;

SELECT DISTINCT Category
FROM Superstore_Clean;

SELECT DISTINCT Sub_Category 
FROM Superstore_Clean;


-- ======================================
--			4. Validate Dates
-- ======================================

SELECT *
FROM Superstore_Clean
WHERE Ship_Date < Order_Date;


-- ======================================
--		5. Validate numeric fields 
-- ======================================

SELECT * 
FROM Superstore_Clean
WHERE Sales < 0;

SELECT *
FROM Superstore_Clean
WHERE Quantity <= 0;

SELECT *
FROM Superstore_Clean
WHERE Discount < 0
OR Discount > 1;

SELECT * 
FROM Superstore_Clean
WHERE Profit IS NULL;


-- ======================================
--		6. Duplicate Order + Product
-- ======================================

SELECT 
Order_ID, Product_ID,
COUNT(*) AS DuplicateCount
FROM Superstore_Clean
GROUP BY 
Order_ID, Product_ID
HAVING COUNT(*) > 1;


SELECT *
FROM Superstore_Clean
WHERE Order_ID = 'US-2014-150119'
AND Product_ID = 'FUR-CH-10002965';

SELECT *
FROM Superstore_Clean
WHERE Order_ID = 'CA-2016-137043'
AND Product_ID = 'FUR-FU-10003664';

SELECT *
FROM Superstore_Clean
WHERE Order_ID = 'CA-2015-103135'
AND Product_ID = 'OFF-BI-10000069';

SELECT *
FROM Superstore_Clean
WHERE Order_ID = 'CA-2016-140571'
AND Product_ID = 'OFF-PA-10001954';

SELECT *
FROM Superstore_Clean
WHERE Order_ID = 'CA-2016-129714'
AND Product_ID = 'OFF-PA-10001970';


SELECT *
FROM Superstore_Clean
WHERE Order_ID = 'CA-2017-152912'
AND Product_ID = 'OFF-ST-10003208';

SELECT *
FROM Superstore_Clean
WHERE Order_ID = 'CA-2017-118017'
AND Product_ID = 'TEC-AC-10002006';

SELECT *
FROM Superstore_Clean
WHERE Order_ID = 'US-2016-123750'
AND Product_ID = 'TEC-AC-10004659';



-- ======================================
--		7. Verifying Postal Code
-- ======================================

SELECT 
MIN(Postal_Code) AS MinPostal,
MAX(Postal_Code) AS MaxPostal
FROM Superstore_Clean;


 
-- ======================================
--		8. Create Shipping Days column
-- ======================================

ALTER TABLE Superstore_Clean
ADD Shipping_Days INT;

UPDATE Superstore_Clean
SET Shipping_Days =
DATEDIFF(day, Order_Date, Ship_Date);


SELECT * 
FROM Superstore_Clean;

-- ======================================
--		9. Create Price column
-- ======================================

ALTER TABLE Superstore_Clean
ADD Price DECIMAL(10,2);


UPDATE Superstore_Clean
SET Price =
CASE
    WHEN Quantity = 0 THEN NULL
    ELSE Sales / Quantity
END;

