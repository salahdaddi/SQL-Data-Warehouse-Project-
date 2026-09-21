
-- custemer info 
SELECT * 
FROM (
	SELECT cst_id,
	COUNT(*) AS total 
	FROM silver.crm_cust_info
	GROUP BY cst_id )t 
	WHERE total > 1

SELECT st_firstname 
FROM silver.crm_cust_info
WHERE st_firstname != TRIM(st_firstname)

SELECT cst_lastname 
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info

SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

-- prd_info 
SELECT prd_id,
COUNT(*) AS Total 
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

SELECT prd_nm
FROM silver.crm_prd_info 
WHERE prd_nm != TRIM(prd_nm)

SELECT DISTINCT prd_line 
FROM silver.crm_prd_info 


SELECT  * 
FROM silver.crm_prd_info 

-- sales details
SELECT * FROM bronze.crm_sales_details

SELECT 
sls_ord_num ,
sls_prd_key,
sls_cust_id
FROM silver.crm_sales_details
WHERE sls_ord_num IS NULL OR sls_prd_key IS NULL OR sls_cust_id IS NULL

SELECT 
sls_prd_key
FROM silver.crm_sales_details
WHERE sls_prd_key NOT IN(SELECT prd_key FROM silver.crm_prd_info)

SELECT 
sls_cust_id
FROM silver.crm_sales_details
WHERE sls_cust_id NOT IN(SELECT cst_id FROM silver.crm_cust_info)

SELECT 
*
FROM
silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt


SELECT 
*
FROM
silver.crm_sales_details
WHERE  sls_ship_dt IS NULL

SELECT 
*
FROM
silver.crm_sales_details
WHERE sls_due_dt IS NULL

SELECT * FROM silver.crm_sales_details
WHERE sls_quantity * sls_price != sls_sales

SELECT * FROM silver.crm_sales_details
WHERE sls_quantity < 0 OR sls_quantity IS NULL

SELECT * FROM silver.crm_sales_details
WHERE sls_price < 0 OR sls_price IS NULL

SELECT * FROM silver.crm_sales_details
WHERE sls_sales < 0 OR sls_sales IS NULL

SELECT * FROM silver.crm_sales_details

--  cust az12
SELECT * FROM bronze.erp_cust_az12

SELECT cid,
COUNT(*) 
FROM  silver.erp_cust_az12
GROUP BY cid 
HAVING COUNT(*) >1 

SELECT * FROM silver.erp_cust_az12
WHERE cid IS NULL

SELECT * FROM silver.erp_cust_az12
WHERE cid NOT IN (SELECT cst_key FROM silver.crm_cust_info)

SELECT * FROM silver.erp_cust_az12
WHERE bdate > GETDATE()

SELECT DISTINCT gen 
FROM silver.erp_cust_az12

-- loc_a101
SELECT * FROM silver.erp_loc_a101

SELECT cid,
COUNT(*) 
FROM  silver.erp_loc_a101
GROUP BY cid 
HAVING COUNT(*) >1 

SELECT DISTINCT cntry
FROM silver.erp_loc_a101

SELECT * FROM silver.erp_loc_a101
WHERE cid NOT IN (SELECT cst_key FROM silver.crm_cust_info)

-- px_cat_g1v2

SELECT * FROM silver.erp_px_cat_g1v2
