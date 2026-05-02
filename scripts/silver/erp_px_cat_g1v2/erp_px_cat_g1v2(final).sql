use DataWarehouse;

/*
-- Check for unwanted space
select 
id,
cat,
subcat,
maintenance
from bronze.erp_px_cat_g1v2 
where cat != trim(cat) or subcat != trim(subcat) or maintenance != TRIM(maintenance);

--solution
-- Everything is correct

--Data Standardization & consistency
select distinct	
cat,
subcat,
maintenance
from bronze.erp_px_cat_g1v2;
*/
--solution
-- Everything is correct

--Insert into silver layer
Insert into silver.erp_px_cat_g1v2
(
id,
cat,
subcat,
maintenance
)
select 
id,
cat,
subcat,
maintenance
from bronze.erp_px_cat_g1v2; 


