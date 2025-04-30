/*
===========================================
Cleaning/Loading of crm_cust_info file
===========================================
Purpose: This SQL file shows the data standardization and normalization of the crm_cust_info table of the silver layer
- Data Standardization
- Data Normalization
- Window functions
*/


INSERT INTO silver.crm_cust_info (
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)
SELECT
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname, -- Standardized coded values to meaningful descriptions/names
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
	WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
	ELSE 'n/a'
END cst_marital_status, -- Normalize marital status values to a readable/digestable format
CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
	WHEN UPPER(TRIM(cst_gndr)) = 'M' Then 'Male'
	ELSE 'n/a'
END cst_gndr, -- Normalize gender values to readable format
cst_create_date
FROM (
SELECT
*,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
)t WHERE flag_last = 1 -- Removed duplicates
