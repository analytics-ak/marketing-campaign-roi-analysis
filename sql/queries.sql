-- ============================================================
-- Customer Targeting & Campaign Effectiveness Analysis
-- SQL Queries used in the project
-- Database: marketing
-- Table: customers (2,205 rows, 43 columns)
-- ============================================================


-- ============================================================
-- 1. DATABASE SETUP
-- ============================================================

-- Create database
SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS marketing;
USE marketing;

-- Note: The customers table is loaded from the cleaned DataFrame 
-- in the Python notebook. It contains 43 columns:
-- 39 original columns from the dataset + 4 created columns:
--   - income_group (Low, Mid, High)
--   - age_group (Young, Middle, Senior)
--   - total_campaigns_accepted (sum of all 6 campaign responses)
--   - is_responder (1 if customer responded to at least one campaign)


-- ============================================================
-- 2. RESPONSE RATE BY INCOME GROUP
-- ============================================================

-- Check which income groups respond most to campaigns
SELECT 
    income_group,
    COUNT(*) AS customer_count,
    SUM(is_responder) AS responders,
    ROUND(AVG(is_responder) * 100, 2) AS response_rate
FROM customers
GROUP BY income_group
ORDER BY response_rate DESC;


-- ============================================================
-- 3. RESPONSE RATE BY AGE GROUP
-- ============================================================

-- Check if age affects response rate
SELECT 
    age_group,
    COUNT(*) AS customer_count,
    SUM(is_responder) AS responders,
    ROUND(AVG(is_responder) * 100, 2) AS response_rate
FROM customers
GROUP BY age_group
ORDER BY response_rate DESC;


-- ============================================================
-- 4. COMBINED SEGMENT: AGE × INCOME
-- ============================================================

-- Real targeting view — not just "high income" but "high income + which age group"
SELECT 
    age_group,
    income_group,
    COUNT(*) AS customer_count,
    SUM(is_responder) AS responders,
    ROUND(AVG(is_responder) * 100, 2) AS response_rate
FROM customers
GROUP BY age_group, income_group
ORDER BY response_rate DESC;


-- ============================================================
-- 5. RESPONSE RATE PER CAMPAIGN
-- ============================================================

-- Which campaigns actually worked and which flopped
SELECT 
    'Campaign 1' AS campaign, 
    COUNT(*) AS customers, 
    SUM(AcceptedCmp1) AS responders,
    ROUND(AVG(AcceptedCmp1) * 100, 2) AS response_rate
FROM customers
UNION ALL
SELECT 
    'Campaign 2', 
    COUNT(*), 
    SUM(AcceptedCmp2), 
    ROUND(AVG(AcceptedCmp2) * 100, 2) 
FROM customers
UNION ALL
SELECT 
    'Campaign 3', 
    COUNT(*), 
    SUM(AcceptedCmp3), 
    ROUND(AVG(AcceptedCmp3) * 100, 2) 
FROM customers
UNION ALL
SELECT 
    'Campaign 4', 
    COUNT(*), 
    SUM(AcceptedCmp4), 
    ROUND(AVG(AcceptedCmp4) * 100, 2) 
FROM customers
UNION ALL
SELECT 
    'Campaign 5', 
    COUNT(*), 
    SUM(AcceptedCmp5), 
    ROUND(AVG(AcceptedCmp5) * 100, 2) 
FROM customers
UNION ALL
SELECT 
    'Last Campaign', 
    COUNT(*), 
    SUM(Response), 
    ROUND(AVG(Response) * 100, 2) 
FROM customers
ORDER BY response_rate DESC;


-- ============================================================
-- 6. CHANNEL USAGE: RESPONDERS vs NON-RESPONDERS
-- ============================================================

-- How do responders buy compared to non-responders?
-- Named "channel usage" not "preference" — we observe behavior, not causation
SELECT 
    CASE 
        WHEN is_responder = 1 THEN 'Responder' 
        ELSE 'Non-Responder' 
    END AS customer_type,
    COUNT(*) AS customer_count,
    ROUND(AVG(NumWebPurchases), 2) AS avg_web,
    ROUND(AVG(NumCatalogPurchases), 2) AS avg_catalog,
    ROUND(AVG(NumStorePurchases), 2) AS avg_store,
    ROUND(AVG(NumDealsPurchases), 2) AS avg_deals,
    ROUND(AVG(NumWebVisitsMonth), 2) AS avg_web_visits
FROM customers
GROUP BY is_responder;


-- ============================================================
-- 7. HIGH-VALUE NON-RESPONDERS
-- ============================================================

-- Top spenders who never responded to any campaign
-- These customers are valuable but current campaigns aren't reaching them
SELECT 
    COUNT(*) AS customer_count,
    ROUND(AVG(MntTotal), 2) AS avg_total_spend,
    ROUND(AVG(Income), 2) AS avg_income,
    ROUND(AVG(Recency), 2) AS avg_recency
FROM customers
WHERE is_responder = 0
  AND MntTotal > (SELECT AVG(MntTotal) FROM customers);


-- ============================================================
-- 8. VALIDATION: OVERALL RESPONSE RATE
-- ============================================================

-- Used to confirm SQL matches Python calculation
-- Builds trust in the pipeline
SELECT 
    ROUND(AVG(is_responder) * 100, 2) AS overall_response_rate
FROM customers;


-- ============================================================
-- END
-- ============================================================