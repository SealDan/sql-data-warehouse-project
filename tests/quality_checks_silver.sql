/*
===============================================================================
Data Quality Validation
===============================================================================
Description:
    This script runs a series of validation checks to ensure the reliability and 
    consistency of data within the 'silver' layer. The checks cover:
        - Missing or duplicate primary key values.
        - Leading or trailing whitespace in text columns.
        - Standardization and uniform formatting of data.
        - Invalid or illogical date values.
        - Consistency between related attributes.

Usage Notes:
    - Execute this script after loading data into the Silver layer.
    - Review and address any issues identified by these checks.
===============================================================================
*/


-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- Check for Nulls/Duplicates in Primary Key
-- Expectations is no results
SELECT
  cst_id,
  COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check for unwanted Spaces
-- Expectations is to have no results
SELECT
	cst_firstname,
	cst_lastname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname) OR cst_lastname != TRIM(cst_lastname)


-- Data Standardization & Consistency
SELECT DISTINCT cst_marital_status, cst_gndr
FROM silver.crm_cust_info

SELECT * FROM silver.crm_cust_info

-- ====================================================================
-- Checking 'silver.crm_prd_info'
-- ====================================================================
SELECT * FROM silver.crm_prd_info

-- Check for NULLS and/or duplicates in Primary Key
-- Expectation is for it to have no results 
SELECT
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check for unwanted spaces
-- Expectation is to have no results
SELECT
prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)\

-- Check for NULLS or Negative numbers
-- Expectation is to have no results
SELECT
prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL or prd_cost < 0

-- Data standardization adn consistency
SELECT DISTINCT prd_line FROM silver.crm_prd_info

-- Check for Invalid Date Orders
SELECT * FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

-- ====================================================================
-- Checking 'silver.crm_sales_details'
-- ====================================================================
SELECT * FROM silver.crm_sales_details

-- Check for invalid dates
-- Expectations is no invalid dates
SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt 
FROM silver.crm_sales_details
WHERE sls_due_dt <= 0 
    OR LEN(sls_due_dt) != 8 
    OR sls_due_dt > 20350101 
    OR sls_due_dt < 19000101;

-- Check for Invalid Date Orders (Order Date > Shipping/Due Dates)
-- Expectation is No Results
SELECT 
    * 
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Check Data consistency where Sales = Quantity * Price
-- Expectations is no faults
SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity AS old_sls_quantity,
sls_price AS old_sls_prie
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price

-- ====================================================================
-- Checking 'silver.erp_cust_az12'
-- ====================================================================
-- Identify out-of-range dates
SELECT
CONVERT(DATE, bdate, 103) AS bdate_new
FROM silver.erp_cust_az12
WHERE CONVERT(DATE, bdate, 103) < '1924-01-01' OR CONVERT(DATE, bdate, 103) > GETDATE()

-- Data standarization and consistency
SELECT DISTINCT gen
FROM silver.erp_cust_az12

SELECT * FROM silver.erp_cust_az12

-- ====================================================================
-- Checking 'silver.erp_loc_a101'
-- ====================================================================
-- Data Standardization & Consistency
SELECT DISTINCT 
    cntry 
FROM silver.erp_loc_a101
ORDER BY cntry;

-- ====================================================================
-- Checking 'silver.erp_px_cat_g1v2'
-- ====================================================================
-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT 
    * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency
SELECT DISTINCT 
    maintenance 
FROM silver.erp_px_cat_g1v2;
