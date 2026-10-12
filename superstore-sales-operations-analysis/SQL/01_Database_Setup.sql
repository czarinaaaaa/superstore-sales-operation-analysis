-- ============================================
-- Superstore Sales & Operations Analysis
-- Database Setup
-- ============================================

-- Verify imported data
SELECT * 
FROM dbo.Superstore;


-- Verify imported data
SELECT TOP 10 * 
FROM dbo.Superstore;


-- Check imported data types
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Superstore';
