/*

=====================================================================================
Create Database and Schemas
=====================================================================================

Script Purpose:
  This script create schemas for a new database named 'DataWarehouse'.
  The database is already created with PgAdmin.
  If the schema already exists, it dropped and recreated. 3 schemas are added for the database: 'bronze', 'silver', and 'gold'.

WARNING:
  Running this script will drop all the schemas if they are exists.
  All data in the schemas will be permanently deleted. Proceed with caution
  and ensure you have proper backups before running this script.

*/

DROP SCHEMA IF EXISTS bronze; 
CREATE SCHEMA bronze;

DROP SCHEMA IF EXISTS silver;
CREATE SCHEMA silver;

DROP SCHEMA IF EXISTS gold;
CREATE SCHEMA gold;

