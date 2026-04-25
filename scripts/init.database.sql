/*
==============================================
Create Database and Schemas
==============================================

Script Purpose:
This script creates a new database named 'DataWarehouse' after checking if it already exists.
If the database exists, it is dropped and recreated.
Additionally, the script sets up three schemas within the database:
'bronze', 'silver', and 'gold'.

WARNING:
Running this script will drop the entire 'DataWarehouse' database if it exists.
All data in the database will be permanently deleted.
Proceed with caution and ensure you have proper backups before running this script.
*/


-- CREATE DATABASE data_warehouse;
USE data_warehouse;

-- Drop and recreate the "Data Warehouse" database
Drop database if exist data_warehouse;

-- Create the data warehouse database
create database data_warehouse;

USE data_warehouse;

-- create schemas
create schema bronze;
create schema silver;
create schema gold;
