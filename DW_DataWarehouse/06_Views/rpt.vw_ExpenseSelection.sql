USE [DW_FamilyFinance]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************
View Name    : rpt.vw_ExpenseSelection
Author       : Behailu Tessema
Created Date : 06/04/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Provides expense transaction detail for filtering and analysis by
    year, month, bank, category, subcategory, and expense type.

Source Objects:
    - fact.FactExpense
    - dim.DimDate
    - dim.DimBank
    - dim.DimDescription

Replaces Old Object:
    - STG_FamilyLiving.dbo.usp_ExpenseSelectoion

Grain:
    One row represents one expense transaction.

Business Rules:
    1. TransactionDate is sourced from dim.DimDate.
    2. BankName is sourced from dim.DimBank.
    3. Description attributes are sourced from dim.DimDescription.
    4. ExpenseAmount is the finalized warehouse-calculated amount.
    5. SourceExpenseID provides source-to-warehouse traceability.
    6. LoadDate supports ETL audit and reporting-period review.

Available Filters:
    - Year
    - MonthNumber
    - MonthName
    - YearMonthNumber
    - YearMonthName
    - BankName
    - Category
    - SubCategory
    - ExpenseType
    - DescriptionName

Example Queries:

    -- All expenses for 2026
    SELECT *
    FROM rpt.vw_ExpenseSelection
    WHERE [Year] = 2026;

    -- May 2026 expenses
    SELECT *
    FROM rpt.vw_ExpenseSelection
    WHERE [Year] = 2026
      AND MonthNumber = 5;

    -- Wells Fargo expenses
    SELECT *
    FROM rpt.vw_ExpenseSelection
    WHERE BankName = 'Wells Fargo';

    -- Grocery expenses
    SELECT *
    FROM rpt.vw_ExpenseSelection
    WHERE Category = 'GROCERIES';

Used By:
    - SQL reporting
    - Ad hoc analysis
    - Data validation
    - Troubleshooting
    - Reconciliation review

Power BI Recommendation:
    Enterprise Power BI models should use the underlying star schema
    tables directly. This view is intended primarily for SQL-based
    reporting, validation, and analyst self-service queries.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Replacement for usp_ExpenseSelectoion.
------------------------------------------------------------------------------------------------***/
CREATE OR ALTER VIEW [rpt].[vw_ExpenseSelection]
AS
SELECT
    d.FullDate AS TransactionDate,
    d.[Year],
    d.MonthNumber,
    d.MonthName,
    d.YearMonthNumber,
    d.YearMonthName,

    des.DescriptionName,
    des.[Description],
    des.Category,
    des.SubCategory,
    des.ExpenseType,

    b.BankName,

    f.ExpenseAmount,
    f.LoadDate,
    f.SourceExpenseID,
    f.TransactionID
FROM fact.FactExpense f
INNER JOIN dim.DimDate d
    ON d.DateKey = f.TransactionDateKey
INNER JOIN dim.DimBank b
    ON b.BankKey = f.BankKey
INNER JOIN dim.DimDescription des
    ON des.DescriptionKey = f.DescriptionKey;
GO