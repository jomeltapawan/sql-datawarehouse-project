/*
=======================================
Create Database and Schemas
=======================================
Script Purpose:
	This script creates a new databse named 'DataWareHouse' after checking if it already exists.
	If the databse exists, it is dropped then recreated. Additionally, the script sets up three schemas within the database: 'bronze', 'silver', and 'gold'.

WARNING:
	Running this script will drop the entire 'DataWarehouse' database if it exists.
	All data in the database will be permanently deleted. Proceed with caution and ensure you have proper backups before running this script.
*/


USE master;
GO
--Drop and recareate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWareHouse')
BEGIN
	ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWareHouse;
END;
GO

-- Create the 'DataWareHouse' Database
CREATE DATABASE DataWarehouse;

USE DataWarehouse;
GO

--Create the Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
