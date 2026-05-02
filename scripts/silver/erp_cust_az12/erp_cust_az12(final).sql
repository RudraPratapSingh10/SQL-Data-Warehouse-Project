use DataWarehouse;

-- Match the cid from   cst_key in silver customer info table
select
case when cid  like 'NAS%' then SUBSTRING(cid,4,len(cid))
  else cid
end as cid,
bdate,
gen
from silver.erp_cust_az12;

-- Identify out of range range
select bdate from silver.erp_cust_az12
where bdate  < '1924-01-01'	 or bdate > GETDATE();

-- Data Standardization & Consistency
select distinct gen
from silver.erp_cust_az12;
