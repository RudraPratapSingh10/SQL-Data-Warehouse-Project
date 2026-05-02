USE [DataWarehouse]
GO

/*
-- Data validation
SELECT cid,
cntry
  FROM bronze.erp_loc_a101;

--solution
select replace(cid,'-','')cid,
cntry from  bronze.erp_loc_a101;

--Data Consistency and Standardization
SELECT distinct
cntry
  FROM bronze.erp_loc_a101;

-- solution
select replace(cid,'-','')cid,
case when trim(cntry) = 'DE' then 'Germany'
	when trim(cntry) in ('US','USA') then 'United States'
	when trim(cntry) = '' or cntry is null then 'n/a'
	else trim(cntry)
end as cntry
from  bronze.erp_loc_a101;
	*/
	
-- Insert into silver layer
Insert into silver.erp_loc_a101(
cid,
cntry
)
select replace(cid,'-','')cid,
case when trim(cntry) = 'DE' then 'Germany'
	when trim(cntry) in ('US','USA') then 'United States'
	when trim(cntry) = '' or cntry is null then 'n/a'
	else trim(cntry)
end as cntry
from  bronze.erp_loc_a101;
