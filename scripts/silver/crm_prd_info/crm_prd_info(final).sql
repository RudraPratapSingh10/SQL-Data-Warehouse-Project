use DataWarehouse;


-- check for null and duplicate in PK
-- Exception -: No result
select 
prd_id,
count(*) 
from silver.crm_prd_info 
group by prd_id having COUNT(*) > 1 or prd_id is null	;

-- Check unwanted space  
-- Exception -: No result
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);
  
-- Check for NULL and negative numbers  
-- Exception -: No result
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 or prd_cost is null;

-- Data Standardization and	Consistency 
select distinct prd_line  from silver.crm_prd_info;

-- Check for invalid date orders
select *  from silver.crm_prd_info
where prd_end_dt <prd_start_dt;

-- Final look to silver table
select *  from bronze.crm_prd_info;

