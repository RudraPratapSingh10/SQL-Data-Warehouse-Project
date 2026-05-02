use DataWarehouse;
GO

/*
-- check for null and duplicate in PK
-- Exception -: No result
select 
cst_id,
count(*) 
from bronze.crm_cust_info 
group by cst_id having COUNT(*) > 1 or cst_id is null	;

-- solution
select * from(
select *, ROW_NUMBER() over (partition by cst_id order by cst_create_date desc) as flag_last
from bronze.crm_cust_info)t where flag_last =1 and cst_id = 29466;

-- Check unwanted space  
-- Exception -: No result
SELECT *
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
   OR cst_lastname != TRIM(cst_lastname);

-- solution
select 
cst_id,
cst_key,
trim(cst_firstname) as cst_firstname ,
trim(cst_lastname) as cst_lastname,
cst_gndr,
cst_marital_status,
cst_create_date
from bronze.crm_cust_info;

-- Data Standardization and	Consistency 
select distinct cst_gndr from bronze.crm_cust_info;
select distinct cst_marital_status from bronze.crm_cust_info;


-- solution
select 
cst_id,
cst_key,
trim(cst_firstname) as cst_firstname ,
trim(cst_lastname) as cst_lastname,
case when upper(trim(cst_gndr)) = 'F' then 'Female'
	when  upper(trim(cst_gndr)) = 'M' then 'Male'
	else 'N/A'
end as cst_gndr,
case when upper(trim(cst_marital_status)) = 'S' then 'Single'
	when  upper(trim(cst_marital_status)) = 'M' then 'Married'
	else 'N/A'
end as cst_marital_status,
cst_create_date
from bronze.crm_cust_info;
*/
-- Insert into silver layer
INSERT INTO silver.crm_cust_info (
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_gndr,
    cst_marital_status,
    cst_create_date
)
SELECT 
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
    CASE 
        WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
        WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
        ELSE 'N/A'
    END AS cst_gndr,
    CASE 
        WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
        WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
        ELSE 'N/A'
    END AS cst_marital_status,
    cst_create_date
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY cst_id 
               ORDER BY cst_create_date DESC
           ) AS flag_last
    FROM bronze.crm_cust_info
    WHERE cst_id IS NOT NULL
) AS t
WHERE flag_last = 1;



