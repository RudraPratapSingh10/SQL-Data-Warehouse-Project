use DataWarehouse;

/*
-- check for null and duplicate in PK
-- Exception -: No result
select 
prd_id,
count(*) 
from bronze.crm_prd_info 
group by prd_id having COUNT(*) > 1 or prd_id is null	;

--solution
select 
prd_id,
prd_key,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) as prd_key, 
prd_cost,
prd_end_dt,
prd_line,
prd_nm	,
prd_start_dt	
from bronze.crm_prd_info;
/*
 where REPLACE(SUBSTRING(prd_key,1,5),'-','_') not in
 (select distinct id from bronze.erp_px_cat_g1v2);
 where SUBSTRING(prd_key,7,LEN(prd_key)) in 
(select sls_prd_key  from bronze.crm_sales_details)
*/


-- Check unwanted space  
-- Exception -: No result
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);
  
-- Check for NULL and negative numbers  
-- Exception -: No result
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 or prd_cost is null;

--solution
select 
prd_id,
prd_key,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) as prd_key, 
ISNULL(prd_cost,0) as prd_cost,
prd_end_dt,
prd_line,
prd_nm	,
prd_start_dt	
from bronze.crm_prd_info;

-- Data Standardization and	Consistency 
select distinct prd_line  from bronze.crm_prd_info;

-- solution
select 
prd_id,
prd_key,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) as prd_key, 
ISNULL(prd_cost,0) as prd_cost,
prd_end_dt,
case when upper(trim(prd_line)) = 'R' then 'Road'
	 when  upper(trim(prd_line)) = 'M' then 'Mountain'
	 when  upper(trim(prd_line)) = 'S' then 'Other Sales'
	 when  upper(trim(prd_line)) = 'T' then 'Touring'
	else 'N/A'
end as prd_line,
prd_nm	,
prd_start_dt	
from bronze.crm_prd_info;

-- Check for invalid date orders
select *  from bronze.crm_prd_info

--solution
select 
prd_id,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) as prd_key, 
prd_nm	,
ISNULL(prd_cost,0) as prd_cost,
case when upper(trim(prd_line)) = 'R' then 'Road'
	 when  upper(trim(prd_line)) = 'M' then 'Mountain'
	 when  upper(trim(prd_line)) = 'S' then 'Other Sales'
	 when  upper(trim(prd_line)) = 'T' then 'Touring'
	else 'N/A'
end as prd_line,
cast(prd_start_dt as date ) as prd_start_dt,
cast(lead(prd_start_dt) over(partition by prd_key order by prd_start_dt)-1 as date )as prd_end_dt 
from bronze.crm_prd_info;
*/

-- Insert into silver layer
INSERT INTO silver.crm_prd_info(
prd_id,
cat_id,
prd_key, 
prd_nm	,
prd_line,
prd_cost,
prd_start_dt,
prd_end_dt
)
select 
prd_id,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) as prd_key, 
prd_nm	,

case when upper(trim(prd_line)) = 'R' then 'Road'
	 when  upper(trim(prd_line)) = 'M' then 'Mountain'
	 when  upper(trim(prd_line)) = 'S' then 'Other Sales'
	 when  upper(trim(prd_line)) = 'T' then 'Touring'
	else 'N/A'
end as prd_line,
prd_cost,
cast(prd_start_dt as date ) as prd_start_dt,
cast(lead(prd_start_dt) over(partition by prd_key order by prd_start_dt)-1 as date )as prd_end_dt 
from bronze.crm_prd_info;
