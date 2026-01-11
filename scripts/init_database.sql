/*
=============================================================
Database and Schema Initialization
=============================================================
Purpose:
    This script initializes a database called 'DataWarehouse'. It first checks
    whether the database already exists. If found, the existing database is
    removed and a fresh instance is created. The script then creates three
    schemas within the database: 'bronze', 'silver', and 'gold'.

WARNING!!! :
    Executing this script will completely remove the existing 'DataWarehouse'
    database, including all stored data. This action is irreversible.
    Please ensure appropriate backups are in place before running the script.
*/

USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO

-- Create the main "DataWarehouse" database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
