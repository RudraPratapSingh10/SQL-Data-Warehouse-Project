use DataWarehouse;
go

-- check for null and duplicate in PK
-- Exception -: No result
select 
cst_id,
count(*) 
from silver.crm_cust_info 
group by cst_id having COUNT(*) > 1 or cst_id is null	;

-- Check unwanted space  
-- Exception -: No result
SELECT *
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
   OR cst_lastname != TRIM(cst_lastname);

-- Data Standardization and	Consistency 
select distinct cst_gndr from silver.crm_cust_info;
select distinct cst_marital_status from silver.crm_cust_info;

select *  from silver.crm_cust_info;
