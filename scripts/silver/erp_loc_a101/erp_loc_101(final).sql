use DataWarehouse;


-- Data validation
SELECT cid,
cntry
  FROM silver.erp_loc_a101;


--Data Consistency and Standardization
SELECT distinct
cntry
FROM silver.erp_loc_a101;

