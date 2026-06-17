/*************************************************************************************************
Project    : DW_FamilyFinance
Script     : Clean_DW_Data_And_Reload
Author     : Behailu Tessema
Purpose    : Cleans DW fact and reloadable dimension data, resets identity keys,
             then reloads DW data from the ETL stored procedure or SSIS package.

Important:
    - Fact tables are deleted first because they reference dimension tables.
    - Reloadable dimensions are deleted after fact tables.
    - DimDate is NOT deleted here because it is maintained by DW_Initial_Setup.dtsx.
    - DBCC CHECKIDENT resets identity values back to the starting point.
    - After cleanup, reload the DW using DW_Load_FamilyFinance.dtsx or
      etl.usp_Load_DW_FamilyFinance.
*************************************************************************************************/

USE DW_FamilyFinance;
GO

/*************************************************************************************************
STEP 1: Check current row counts before cleanup
*************************************************************************************************/
SELECT 'fact.FactExpense' AS TableName, COUNT(*) AS [RowCount] FROM fact.FactExpense
UNION ALL
SELECT 'fact.FactIncome', COUNT(*) FROM fact.FactIncome
UNION ALL
SELECT 'dim.DimBank', COUNT(*) FROM dim.DimBank
UNION ALL
SELECT 'dim.DimDescription', COUNT(*) FROM dim.DimDescription
UNION ALL
SELECT 'dim.DimIncomeSource', COUNT(*) FROM dim.DimIncomeSource
UNION ALL
SELECT 'dim.DimDate', COUNT(*) FROM dim.DimDate;
GO

/*************************************************************************************************
STEP 2: Delete fact tables first
*************************************************************************************************/
DELETE FROM fact.FactExpense;
GO

DELETE FROM fact.FactIncome;
GO

/*************************************************************************************************
STEP 3: Delete reloadable dimension tables
    Note:
        DimDate is intentionally excluded.
        DimDate is loaded separately by DW_Initial_Setup.dtsx.
*************************************************************************************************/
DELETE FROM dim.DimBank;
GO

DELETE FROM dim.DimDescription;
GO

DELETE FROM dim.DimIncomeSource;
GO

/*************************************************************************************************
STEP 4: Reset identity columns
    Note:
        DimDate does not need identity reseeding because DateKey is YYYYMMDD.
*************************************************************************************************/
DBCC CHECKIDENT ('fact.FactExpense', RESEED, 0);
GO

DBCC CHECKIDENT ('fact.FactIncome', RESEED, 0);
GO

DBCC CHECKIDENT ('dim.DimBank', RESEED, 0);
GO

DBCC CHECKIDENT ('dim.DimDescription', RESEED, 0);
GO

DBCC CHECKIDENT ('dim.DimIncomeSource', RESEED, 0);
GO

/*************************************************************************************************
STEP 5: Confirm DW is clean before reload
    Expected:
        FactExpense        = 0
        FactIncome         = 0
        DimBank            = 0
        DimDescription     = 0
        DimIncomeSource    = 0
        DimDate            > 0
*************************************************************************************************/
SELECT 'fact.FactExpense' AS TableName, COUNT(*) AS [RowCount] FROM fact.FactExpense
UNION ALL
SELECT 'fact.FactIncome', COUNT(*) FROM fact.FactIncome
UNION ALL
SELECT 'dim.DimBank', COUNT(*) FROM dim.DimBank
UNION ALL
SELECT 'dim.DimDescription', COUNT(*) FROM dim.DimDescription
UNION ALL
SELECT 'dim.DimIncomeSource', COUNT(*) FROM dim.DimIncomeSource
UNION ALL
SELECT 'dim.DimDate', COUNT(*) FROM dim.DimDate;
GO

/*************************************************************************************************
STEP 6: Reload DW
    Option 1:
        Run SSIS package manually:
            DW_Load_FamilyFinance.dtsx

    Option 2:
        Run wrapper procedure directly:
*************************************************************************************************/
EXEC etl.usp_Load_DW_FamilyFinance;
GO

/*************************************************************************************************
STEP 7: Validate row counts after reload
*************************************************************************************************/
SELECT 'fact.FactExpense' AS TableName, COUNT(*) AS [RowCount] FROM fact.FactExpense
UNION ALL
SELECT 'fact.FactIncome', COUNT(*) FROM fact.FactIncome
UNION ALL
SELECT 'dim.DimBank', COUNT(*) FROM dim.DimBank
UNION ALL
SELECT 'dim.DimDescription', COUNT(*) FROM dim.DimDescription
UNION ALL
SELECT 'dim.DimIncomeSource', COUNT(*) FROM dim.DimIncomeSource
UNION ALL
SELECT 'dim.DimDate', COUNT(*) FROM dim.DimDate;
GO

/*************************************************************************************************
STEP 8: Validation checks
*************************************************************************************************/

-- Check for duplicate expense source records
SELECT
    SourceExpenseID,
    COUNT(*) AS DuplicateCount
FROM fact.FactExpense
GROUP BY SourceExpenseID
HAVING COUNT(*) > 1;
GO

-- Check for duplicate income source records
SELECT
    SourceIncomeID,
    COUNT(*) AS DuplicateCount
FROM fact.FactIncome
GROUP BY SourceIncomeID
HAVING COUNT(*) > 1;
GO

-- Check for missing expense dimension references
SELECT COUNT(*) AS MissingExpenseDateKeys
FROM fact.FactExpense f
LEFT JOIN dim.DimDate d
    ON f.TransactionDateKey = d.DateKey
WHERE d.DateKey IS NULL;
GO

-- Check for missing income date references
SELECT COUNT(*) AS MissingIncomeDateKeys
FROM fact.FactIncome f
LEFT JOIN dim.DimDate d
    ON f.PayDateKey = d.DateKey
WHERE d.DateKey IS NULL;
GO