CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @total_start_time DATETIME, @total_end_time DATETIME;
	DECLARE @start_time DATETIME , @end_time DATETIME;
	BEGIN TRY
	SET @total_start_time = GETDATE();
		PRINT '===========================';
		PRINT 'Loading Bronze Layer';
		PRINT '===========================';
		PRINT ' '
		PRINT '---------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '---------------------------';

		SET @start_time = GETDATE();
		PRINT 'Loading crm_cust_info table';
		PRINT 'Truncating table...';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT 'Inserting data...';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'; 
		PRINT '------------------------------'

		SET @start_time = GETDATE();
		PRINT 'Loading crm_prd_info table';
		PRINT 'Truncating table...';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT 'Inserting data...';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '------------------------------'

		SET @start_time = GETDATE();
		PRINT 'Loading crm_sales_details table';
		PRINT 'Truncating table...';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT 'Inserting data...';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '------------------------------'

		PRINT '---------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '---------------------------';

		SET @start_time = GETDATE();
		PRINT 'Loading erp_cust_az12 table';
		PRINT 'Truncating table...';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT 'Inserting data...';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '------------------------------'

		SET @start_time = GETDATE();
		PRINT 'Loading erp_loc_a101 table';
		PRINT 'Truncating table...';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT 'Inserting data...';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '------------------------------'

		SET @start_time = GETDATE();
		PRINT 'Loading erp_px_cat_g1v2 table';
		PRINT 'Truncating table...';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
	
		PRINT 'Inserting data...';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '------------------------------'
		SET @total_end_time = GETDATE()
		PRINT 'Total Bronze Layer Load Time Duration: ' + CAST(DATEDIFF(second, @total_start_time, @total_end_time) AS NVARCHAR) + 'second(s)';
	END TRY
	BEGIN CATCH
		PRINT '=============================';
		PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=============================';
	END CATCH
END
