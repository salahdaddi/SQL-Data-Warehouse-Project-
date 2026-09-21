/* 
 Stored Procedure of Bronze Layer To load Data From Source Systeme (CSV Files) Into Tables 
 - Truncate Table before Loading Data 
 - Use BULK INSERT 
 - Usage Exemple : 
      EXEC bronze.load_bronze
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME , @end_time DATETIME ;
    BEGIN TRY
	    SET @start_time = GETDATE();
	    PRINT '------------------------------- ';
	    PRINT '***** LOADING BRONZE LAYER ***** ';
		PRINT '------------------------------- ';
		PRINT '';
		PRINT '*** LOADING CRM TABLE ***';
		PRINT '';
		PRINT 'TRUNCATING TABLE : crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info ;
		PRINT 'INSERTING DATA INTO TABLE : crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Dell\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		PRINT '';
		PRINT 'TRUNCATING TABLE : crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info ;
		PRINT 'INSERTING DATA INTO TABLE : crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Dell\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		PRINT '';
		PRINT 'TRUNCATING TABLE : crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details ;
		PRINT 'INSERTING DATA INTO TABLE : crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Dell\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		--    *****  ERB TABLE  ******** 
		PRINT '';
		PRINT '*** LOADING ERP TABLE ***';
		PRINT '';
		PRINT 'TRUNCATING TABLE : erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12 ;
		PRINT 'INSERTING DATA INTO TABLE : erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Dell\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		PRINT '';
		PRINT 'TRUNCATING TABLE : erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101 ;
		PRINT 'INSERTING DATA INTO TABLE : erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Dell\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		PRINT '';
		PRINT 'TRUNCATING TABLE : erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2 ;
		PRINT 'INSERTING DATA INTO TABLE : erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Dell\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		); 
		SET @end_time = GETDATE();
		PRINT '=================================================';
		PRINT 'TOTAL LOAD TIME OF BRONZE LAYER :' + CAST(DATEDIFF(second,@start_time,@end_time )AS NVARCHAR) + ' Second';
		PRINT '=================================================';
	END TRY
	BEGIN CATCH
		PRINT '=====================================';
		PRINT 'ERROR DURING LOADING BRONZE LAYER ';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR);
	END CATCH
END
