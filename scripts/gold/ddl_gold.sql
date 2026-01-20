/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Description:
    This script defines the views used in the Gold layer of the data warehouse.
    The Gold layer contains the final star-schema structures, including
    dimension and fact representations.

    Each view applies necessary transformations and merges data from the Silver
    layer to produce a refined, analytics-ready dataset.

Usage:
    - Query these views directly for reporting and analytical workloads.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================

IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO
  
CREATE VIEW gold.dim_customers AS 
SELECT
	ROW_NUMBER () OVER (ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname as first_name,
	ci.cst_lastname as last_name,
	la.cntry as country,
	ci.cst_marital_status as marital_status,
	CASE WHEN ci.cst_gndr != 'Unknown' THEN ci.cst_gndr -- CRM is Master File
		ELSE COALESCE(ca.gen, 'Unknown')
	END AS gender,
	ca.bdate as birthdate,
	ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON	ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON	ci.cst_key = la.cid
GO
  
-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO
  
CREATE VIEW gold.dim_products AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
	pn.prd_id AS product_id,
	pn.prd_key AS product_number,
	pn.prd_nm AS product_name,
	pn.cat_id AS category_id,
	pc.cat AS category,
	pc.subcat AS subcategory,
	pc.maintenance,
	pn.prd_cost AS cost,
	pn.prd_line AS product_line,
	pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON        pn.cat_id = pc.id
WHERE prd_end_dt IS NULL -- Filter out all historical info/data
GO
  
-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT
  sd.sls_ord_num as order_number,
  pr.product_key,
  cu.customer_key,
  sd.sls_order_dt as order_date,
  sd.sls_ship_dt as shipping_date,
  sd.sls_due_dt as due_date,
  sd.sls_sales as sales_amount,
  sd.sls_quantity as quantity,
  sd.sls_price as price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON       sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
ON       sd.sls_cust_id = cu.customer_id
GO
