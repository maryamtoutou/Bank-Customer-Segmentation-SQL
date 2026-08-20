/*
  =============================================================================
  BANK CUSTOMER SEGMENTATION & TRANSACTION ANALYSIS
  Objective: Cleanse raw transaction data, optimize query performance using temp 
  tables, and segment customers by age, gender, and geographic location.
  =============================================================================
*/

-- ======================================================================
-- PHASE 1: DATA PROFILING & CLEANSING
-- ======================================================================

-- Task: Find the True Number of Unique Customers
SELECT COUNT(DISTINCT CustomerID) AS unique_customers
FROM `data-analysis-projects-496119.bank_transactions.raw_transactions`;

-- Task: Create an Optimized, Clean Temporary Table
-- Insight: Filtering out invalid birth dates (e.g., year 1800) and missing genders 
-- to create a reliable dataset of 987,831 valid transactions.
CREATE OR REPLACE TABLE `data-analysis-projects-496119.bank_transactions.clean_bank_transactions` AS 
SELECT *
FROM `data-analysis-projects-496119.bank_transactions.raw_transactions` 
WHERE CustomerDOB LIKE '%/%/%' 
  AND CustomerDOB NOT LIKE '%/%/%1800' 
  AND CustGender IS NOT NULL;


-- ======================================================================
-- PHASE 2: CUSTOMER SEGMENTATION & DEMOGRAPHICS
-- ======================================================================

-- Task: Find Our VIP Customers (Top 10 by Transaction Volume)
SELECT CustomerID, COUNT(TransactionID) AS transaction_count
FROM `data-analysis-projects-496119.bank_transactions.clean_bank_transactions` 
GROUP BY CustomerID
ORDER BY transaction_count DESC
LIMIT 10;

-- Task: Transaction Volume by Gender (Percentage split)
SELECT 
  CustGender,
  COUNT(*) AS transaction_count, 
  ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM `data-analysis-projects-496119.bank_transactions.clean_bank_transactions`), 0) AS percentage
FROM `data-analysis-projects-496119.bank_transactions.clean_bank_transactions`
GROUP BY CustGender;

-- Task: Customer Age Segmentation
-- Goal: Group active customers into age cohorts for targeted marketing.
-- Logic: Parses string dates, calculates exact age at baseline, and segments.
SELECT 
  CASE 
    WHEN DATE_DIFF(DATE '2016-12-31', PARSE_DATE('%d/%m/%y', CustomerDOB), YEAR) BETWEEN 18 AND 25 THEN '18-25'
    WHEN DATE_DIFF(DATE '2016-12-31', PARSE_DATE('%d/%m/%y', CustomerDOB), YEAR) BETWEEN 26 AND 35 THEN '26-35'
    WHEN DATE_DIFF(DATE '2016-12-31', PARSE_DATE('%d/%m/%y', CustomerDOB), YEAR) BETWEEN 36 AND 50 THEN '36-50'
    WHEN DATE_DIFF(DATE '2016-12-31', PARSE_DATE('%d/%m/%y', CustomerDOB), YEAR) > 50 THEN '50+'
    ELSE 'Unknown'
  END AS Age_Group,
  COUNT(*) AS Total_Transactions
FROM `data-analysis-projects-496119.bank_transactions.clean_bank_transactions`
WHERE CustomerDOB IS NOT NULL
GROUP BY Age_Group
ORDER BY Total_Transactions DESC;


-- ======================================================================
-- PHASE 3: FINANCIAL PERFORMANCE & GEO-ANALYSIS
-- ======================================================================

-- Task: Average Transaction Value by Gender
-- Insight: Identifies the spending power gap between male and female customers.
SELECT 
  CustGender, 
  ROUND(AVG(`TransactionAmount _INR_`), 2) AS avg_transaction_value 
FROM `data-analysis-projects-496119.bank_transactions.clean_bank_transactions` 
GROUP BY CustGender
ORDER BY avg_transaction_value DESC;

-- Task: Top Spending Locations (By Volume)
SELECT 
  CustLocation, 
  COUNT(*) AS transaction_count
FROM `data-analysis-projects-496119.bank_transactions.clean_bank_transactions`
GROUP BY CustLocation
ORDER BY transaction_count DESC
LIMIT 10;

-- Task: Total Revenue by Location
-- Insight: Identifies the most profitable regions (e.g., Mumbai) for branch expansion.
SELECT 
  CustLocation, 
  ROUND(SUM(`TransactionAmount _INR_`), 0) AS Total_revenue  
FROM `data-analysis-projects-496119.bank_transactions.clean_bank_transactions` 
GROUP BY CustLocation
ORDER BY Total_revenue DESC
LIMIT 10;

-- Task: Busiest Transaction Dates
-- Insight: Helps IT operations plan server maintenance during low-traffic days.
SELECT 
  TransactionDate, 
  COUNT(*) AS transaction_count
FROM `data-analysis-projects-496119.bank_transactions.clean_bank_transactions`
GROUP BY TransactionDate
ORDER BY transaction_count DESC
LIMIT 10;
