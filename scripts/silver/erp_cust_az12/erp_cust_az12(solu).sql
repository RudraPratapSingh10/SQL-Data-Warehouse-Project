use DataWarehouse;

/*
-- Match the cid from   cst_key in silver customer info table
select
case when cid  like 'NAS%' then SUBSTRING(cid,4,len(cid))
  else cid
end as cid,
bdate,
gen
from bronze.erp_cust_az12;

 
-- Identify out of range range
select bdate from bronze.erp_cust_az12
where bdate  < '1924-01-01'	 or bdate > GETDATE();

-- solution
select
case when bdate > getdate() then NULL	
  else bdate
end as bdate
from bronze.erp_cust_az12;

-- Data Standardization & Consistency
select distinct gen
from bronze.erp_cust_az12;

--solution
select distinct 
case when upper(trim(gen)) in ('F','Female') then 'Female'
     when upper(trim(gen)) in ('M','Male') then 'Male'
     else 'N/A'
    end as gen
from bronze.erp_cust_az12;
*/
-- Insert into silver layer
Insert into silver.erp_cust_az12(
cid,
bdate,
gen
)
select
case when cid  like 'NAS%' then SUBSTRING(cid,4,len(cid))
  else cid
end as cid,
case when bdate > getdate() then NULL	
  else bdate
end as bdate,
case when upper(trim(gen)) in ('F','Female') then 'Female'
     when upper(trim(gen)) in ('M','Male') then 'Male'
     else 'N/A'
    end as gen
from bronze.erp_cust_az12;
