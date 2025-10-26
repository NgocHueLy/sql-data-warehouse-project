/*
========================================================================
Stored Procedure: Load Bronze Layers (Source --> Bronze)
========================================================================

Script Purpose:
	This stored procedure loads data into 'bronze' schema from external CSV files.
	It performs the following actions:
	- Truncate bronze tables before loading the data.
	- Use COPY command to bulk loading data from CSV files to bronze tables.	
	
Parameters:
	None.
	This stored procedure does not accept any parameters or return any values.

Usage Example:
	CALL bronze.load_bronze();

*/




CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
	v_count BIGINT;
	start_time TIMESTAMP;
	end_time TIMESTAMP;
	diff_seconds DOUBLE PRECISION;
BEGIN
	RAISE NOTICE '====================================================';
	RAISE NOTICE 'LOAD BRONZE LAYER';
	RAISE NOTICE '====================================================';

	RAISE NOTICE '----------------------------------------------------';
	RAISE NOTICE 'LOAD CRM TABLES';
	RAISE NOTICE '----------------------------------------------------';

-- ==========================================================
	-- Load CRM Customer Info table
-- ==========================================================
	-- Clear the table content before loading data to it to avoid duplicates
	start_time = NOW();
	RAISE NOTICE '>> Truncating Table: bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;

	RAISE NOTICE '>> Loading Table: bronze.crm_cust_info';
	COPY bronze.crm_cust_info
	FROM 'D:\1_projects\sql_data_warehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	DELIMITER ','
	CSV HEADER;
	
	-- Test number of rows

	SELECT COUNT(*) INTO v_count FROM bronze.crm_cust_info;
	RAISE NOTICE 'bronze.crm_cust_info load: % rows', v_count;
	end_time = NOW();
	diff_seconds = EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load duration: % seconds.', diff_seconds;
	RAISE NOTICE '~~~~~~~~~~~~~~~~';

-- ==========================================================
-- Load CRM Product Info Table
-- ==========================================================
	start_time = NOW();
	RAISE NOTICE '>> Truncating Table: bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;

	RAISE NOTICE '>> Loading Table: bronze.crm_prd_info';
	COPY bronze.crm_prd_info
	FROM 'D:\1_projects\sql_data_warehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	DELIMITER ','
	CSV HEADER;

	-- Test number of rows

	SELECT COUNT(*) INTO v_count FROM bronze.crm_prd_info;
	RAISE NOTICE 'bronze.crm_prd_info load: % rows', v_count;
	
	end_time = NOW();
	diff_seconds = EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load duration: % seconds.', diff_seconds;
	RAISE NOTICE '~~~~~~~~~~~~~~~~';
	
	
-- ==========================================================
	-- Load CRM Sales Details Table
-- ==========================================================

	start_time = NOW();
	RAISE NOTICE '>> Truncating Table: bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;

	RAISE NOTICE '>> Loading Table: bronze.crm_sales_details';
	COPY bronze.crm_sales_details
	FROM 'D:\1_projects\sql_data_warehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	DELIMITER ','
	CSV HEADER;

	-- Test number of rows

	SELECT COUNT(*) INTO v_count FROM bronze.crm_sales_details;
	RAISE NOTICE 'bronze.crm_sales_details load: % rows', v_count;
	
	end_time = NOW();
	diff_seconds = EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load duration: % seconds.', diff_seconds;
	RAISE NOTICE '~~~~~~~~~~~~~~~~';

	RAISE NOTICE '----------------------------------------------------';
	RAISE NOTICE 'LOAD ERP TABLES';
	RAISE NOTICE '----------------------------------------------------';


-- ===============================================
-- Load ERP customer table
-- ===============================================

	start_time = NOW();
	RAISE NOTICE '>> Truncating Table: bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;

	RAISE NOTICE '>> Loading Table: bronze.erp_cust_az12';
	COPY bronze.erp_cust_az12
	FROM 'D:\1_projects\sql_data_warehouse\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	DELIMITER ','
	CSV HEADER;

	-- Test number of rows

	SELECT COUNT(*) INTO v_count FROM bronze.erp_cust_az12;
	RAISE NOTICE 'bronze.erp_cust_az12 load: % rows', v_count;
	
	end_time = NOW();
	diff_seconds = EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load duration: % seconds.', diff_seconds;
	RAISE NOTICE '~~~~~~~~~~~~~~~~';

-- ============================================================
-- Load ERP Location Table
-- ============================================================

	start_time = NOW();
	RAISE NOTICE '>> Truncating Table: bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;

	RAISE NOTICE '>> Loading Table: bronze.erp_loc_a101';
	COPY bronze.erp_loc_a101
	FROM 'D:\1_projects\sql_data_warehouse\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	DELIMITER ','
	CSV HEADER;

	-- Test number of rows

	SELECT COUNT(*) INTO v_count FROM bronze.erp_loc_a101;
	RAISE NOTICE 'bronze.erp_loc_a101 load: % rows', v_count;

	end_time = NOW();
	diff_seconds = EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load duration: % seconds.', diff_seconds;
	RAISE NOTICE '~~~~~~~~~~~~~~~~';


-- ==========================================================
-- Load ERP Category Table
-- ==========================================================

	start_time = NOW();
	RAISE NOTICE '>> Truncating Table: bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;

	RAISE NOTICE '>> Loading Table: bronze.erp_px_cat_g1v2';
	COPY bronze.erp_px_cat_g1v2
	FROM 'D:\1_projects\sql_data_warehouse\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	DELIMITER ','
	CSV HEADER;

	-- Test number of rows

	SELECT COUNT(*) INTO v_count FROM bronze.erp_px_cat_g1v2;
	RAISE NOTICE 'bronze.erp_px_cat_g1v2 load: % rows', v_count;
	
	end_time = NOW();
	diff_seconds = EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load duration: % seconds.', diff_seconds;
	RAISE NOTICE '~~~~~~~~~~~~~~~~';

	RAISE NOTICE '====================================================';
	RAISE NOTICE 'LOAD BRONZE LAYER COMPLETED';
	RAISE NOTICE '====================================================';

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE '==========================================================';
		RAISE NOTICE 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
		RAISE NOTICE 'Error Message: %', SQLERRM;
		RAISE NOTICE '==========================================================';
	
END;
$$;
