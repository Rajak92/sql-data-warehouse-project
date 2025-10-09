/*
====================================================================================
Stored Procedure: Load Silver (Bronze -> Silver)
====================================================================================
Script Purpose:
  This stored procedure performs the ETL (Extract, Transform, Load) process to 
  populate the 'silver' schema tables from the 'bronze' schema. 
Actions Performed:
  - Truncates Silver Tables.
  - Inserts transformed and cleansed data from Bronze to Silver tables.

Parameters:
  None.
  This stored procedure does not accept any parameters or return any values.

Usage Example.
  Exec Silver.load,silver;
====================================================================================
*/



CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
	BEGIN

	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
			SET @batch_start_time = GETDATE();
			PRINT '======================================================================================================================================';
			PRINT 'Loading Bronze Layer';
			PRINT '======================================================================================================================================';

			PRINT '-------------------------------------------------------------------------------------------------------------------------------------- ';
			PRINT 'Loading CRM Tables';
			PRINT '-------------------------------------------------------------------------------------------------------------------------------------- ';
	
			SET @start_time = GETDATE();
			PRINT '>> Truncating Table:Bronze.crm_cust_info';
			TRUNCATE TABLE Bronze.crm_cust_info;

			PRINT '>> Inserting Data Into:crm_cust_info';
			BULK INSERT Bronze.crm_cust_info
			FROM 'C:\Users\Raja\Documents\Raja - Career Related\Raja Kumar\IT & Data Materials\SQL Project Materials\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			WITH (

				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '--------------';

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table:Bronze.crm_prd_info';
			TRUNCATE TABLE Bronze.crm_prd_info;

			PRINT '>> Inserting Data Into:crm_prd_info';
			BULK INSERT Bronze.crm_prd_info
			FROM 'C:\Users\Raja\Documents\Raja - Career Related\Raja Kumar\IT & Data Materials\SQL Project Materials\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			WITH (

				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '--------------';

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table:Bronze.crm_sales_details';
			TRUNCATE TABLE Bronze.crm_sales_details;
			PRINT '>> Inserting Data Into:crm_sales_details';
			BULK INSERT Bronze.crm_sales_details
			FROM 'C:\Users\Raja\Documents\Raja - Career Related\Raja Kumar\IT & Data Materials\SQL Project Materials\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			WITH (

				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '--------------';

			PRINT '-------------------------------------------------------------------------------------------------------------------------------------- ';
			PRINT 'Loading ERP Tables';
			PRINT '-------------------------------------------------------------------------------------------------------------------------------------- ';

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table:Bronze.erp_cust_AZ12';
			TRUNCATE TABLE Bronze.erp_cust_AZ12;
			PRINT '>> Inserting Data Into:erp_cust_AZ12';
			BULK INSERT Bronze.erp_cust_AZ12
			FROM 'C:\Users\Raja\Documents\Raja - Career Related\Raja Kumar\IT & Data Materials\SQL Project Materials\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			WITH (

				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '--------------';

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table:Bronze.erp_loc_a101';
			TRUNCATE TABLE Bronze.erp_loc_a101;
			PRINT '>> Inserting Data Into:erp_loc_a101';
			BULK INSERT Bronze.erp_loc_a101
			FROM 'C:\Users\Raja\Documents\Raja - Career Related\Raja Kumar\IT & Data Materials\SQL Project Materials\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			WITH (

				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '--------------';

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table:Bronze.erp_px_cat_gv12';
			TRUNCATE TABLE Bronze.erp_px_cat_gv12;
			PRINT '>> Inserting Data Into:erp_px_cat_gv12';
			BULK INSERT Bronze.erp_px_cat_gv12
			FROM 'C:\Users\Raja\Documents\Raja - Career Related\Raja Kumar\IT & Data Materials\SQL Project Materials\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			WITH (

				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
				);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '--------------';

			SET @batch_end_time = GETDATE();
			PRINT '===================================================================='
			PRINT 'Loading Bronze Layer is Completed';
			PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
			PRINT '===================================================================='

		END TRY
		BEGIN CATCH
			PRINT '===================================================================='
			PRINT ' EORROR OCCURED DURING LOADING BRONZE LAYER'
			PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
			PRINT 'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
			PRINT 'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
			PRINT '===================================================================='
		END CATCH
	END
