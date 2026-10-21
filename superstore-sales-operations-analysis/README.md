1. Project Title
    Superstore Sales and Operations Analysis
        An exploratory data analysis project examining sales, profitability, customer behavior, product performance, and shipping operations using the Superstore Dataset. The project uses SQL Server to clean, transform, analyze and build reporting views from the data.
2. Project Overview
        This project is about analyzing the sales and profitability of an online superstore mainly operating in the US that handles logistics focusing mainly on furnitures, office supplies and technological gadgets.
3. Objectives / Business Questions
    • Explore and understand the structure of the Superstore dataset.
    • Clean and validate the data for analysis.
    • Identify sales and profit patterns.
    • Analyze product, category, customer, and regional performance.
    • Examine relationships between discounts, profit, shipping modes, and other business variables.
    • Track sales and profit performance over time.
    • Compare year-over-year performance.
    • Identify high-value customers and high-performing products.
    • Build reusable customer and product reporting views.
4. Dataset
        This dataset is about a Superstore giant that primarily operates in the US states. Their items are mainly office supplies, gadgets and furnitures. 

        Source : This is from the Kaggle dataset that is originally from Tableau Community Forums. 
        Dataset Scope:  
            - 9, 994 rows
            - 21 columns
            - Date Range : 2014 - 2017
            - Geographic coverage : Entirely in the US states
            MAIN COLUMNS

                Order Information:
                    Order ID
                    Order Date
                    Ship Date
                    Ship Mode
                
                Customer Information:
                    Customer ID
                    Customer Name
                    Segment

                Location Information:
                    Country
                    City
                    State
                    Region
                    Postal Code

                Product Information:
                    Product ID
                    Category
                    Sub - Category
                    Product Name

                Business Metrics: 
                    Sales
                    Quantity
                    Discount
                    Profit

                Engineered Columns:
                    Shipping Days
                    Price
5. Tools Used
    SQL Server/ SSMS - data cleaning, transformation, analysis and reporting views.
    PowerBI - data visualization
    Git & GitHub - version control and project documentation
6. Project Workflow
    1. Database Setup 
        • Imported the dataset
        • Reviewed the database structure
        • Prepared the working environment
    2. Database Exploration
        • Reviewed the column names and data types
        • Checked missing values
        • Checked duplicate records 
    3. Data Cleaning and Preparation
        • Checked data quality
        • Handled relevant issues
        • Standardized data types
        • Created a cleaned working table
        • Created Shipping Days column
        • Created Price column 
        • Organized columns for easier analysis
    4. Exploratory Data Analysis
        • Database Exploration
        • Dimension Exploration
        • Date Exploration 
        • Measures Exploration
        • Magnitude Analysis
        • Ranking Analysis
        • Relationship Analysis
    5. Business Insights Analysis
        • Sales and Profit Trends
        • Cumulative Performance
        • Year-over-Year Comparisons
        • Category Growth 
        • Contribution Analysis
        • Customer Segmentation
    6. Reporting
        • Created customer report view
        • Created product report view
7. Data Cleaning and Feature Engineering
        Data Quality Checks
           • Reviewed missing values
           • Checked data types
           • Checked for duplicates or invalid records where applicable
           • Validated numerical fields
        Feature Engineering
           • Created Shipping Days by calculating the difference between Ship Date and Order Date.
           • Created Price to support product pricing and performance analysis.
8. Exploratory Data Analysis
        Database Exploration
           • Explored the tables and columns used in the project.
        Dimension Exploration
           • Explored geographic locations.
           • Explored product categories and sub-categories.
           • Examined customer and product distributions.
        Date Exploration
           • Identified the first and last order dates.
           • Determined the overall analysis period.
        Measures Exploration
           • Total sales
           • Total quantity
           • Average price
           • Total profit
           • Total orders
           • Total customers
           • Total products
        Magnitude and Ranking Analysis
           • Revenue by category
           • Customers by city
           • Product performance
           • Top and bottom products
           • Top customers
        Relationship Analysis
           • Discount vs Profit
           • Category vs Average Discount
           • Region vs Average Profit
           • Ship Mode vs Shipping Days
           • Segment vs Sales
           • Segment vs Discount
           • Ship Mode vs Profit
9. Business Insights Analysis
        Changes Over Time
           • Monthly sales
           • Monthly profit
           • Customer activity over time
        Cumulative Performance
           • Running total sales
           • Running total profit
           • Moving average sales
        Performance Comparison
           • Year-over-year sales
           • Year-over-year profit
           • Category growth
           • Contribution Analysis
           • Percentage of sales by category
           • Percentage of sales by region
           • Percentage of profit by segment
        Customer Segmentation
           • VIP customers
           • High-value customers
           • One-time customers
           • Repeat customers
10. Key Insights
        • Technology generating the highest sales and strong profitability.
        • Furniture generating high sales but substantially lower profit than the other major categories.
        • Higher discount levels generally being associated with lower average profit, especially at larger discounts.
        • Standard Class having the longest average shipping time.
        • Faster shipping modes being associated with higher average profit.
        • Consumer customers generating the highest total profit.
        • West and East regions showing stronger average profitability.
        • Sales and profit showing noticeable seasonal patterns across months/years.
11. Reporting Views
        Customer Report View
           • Customer ID and name
           • Segment
           • Total orders
           • Total sales
           • Total quantity
           • Number of products purchased
           • Last order date
           • Customer lifespan
           • Average order value
           • Average monthly spend
           • Customer classification/segment
        Product Report View
           • Product ID and name
           • Category and sub-category
           • Last sale date
           • Product lifespan
           • Total orders
           • Total customers
           • Total sales
           • Total quantity
           • Average selling price
           • Average order revenue
           • Average monthly revenue
           • Product performance segment
12. Repository Structure
        Superstore-Sales-Operations-Analysis/
    │
    ├── Dataset/
    │   └── Superstore.csv
    │
    ├── SQL/
    │   ├── 01_Database_Setup.sql
    │   ├── 02_Data_Exploration.sql
    │   ├── 03_Data_Cleaning.sql
    │   ├── 04_Exploratory_Analysis.sql
    │   ├── 05_Business_Insights.sql
    │   └── 06_Reports.sql
    │
    ├── README.md
13. Skills Demonstrated
    SQL Skills
      • Data Cleaning
      • Data Transformation
      • Aggregations 
      • GROUP BY
      • ORDER BY 
      • CASE
      • CTE
      • Window Functions
      • LAG()
      • Running Totals
      • Moving Averages
      • PARTITION BY
      • Date Functions
      • Ranking 
      • Contribution Analysis
      • SQL views
    Analysis Skills
        • Exploratory Data Analysis
        • Trend analysis
        • Performance comparison
        • Customer segmentation
        • Product analysis
        • Profitability analysis
        • Business insight generation
14. Conclusion
        • Turning raw transactional data into a cleaned analytical dataset
        • Using SQL to explore and analyze business performance
        • Moving from descriptive EDA into business-focused analysis
        • Creating reusable reporting views