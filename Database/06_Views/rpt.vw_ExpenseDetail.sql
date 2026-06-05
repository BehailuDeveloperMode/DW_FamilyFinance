USE [DW_FamilyFinance]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************
View Name    : rpt.vw_ExpenseDetail
Author       : Behailu Tessema
Created Date : 06/04/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Provides detailed, business-readable expense transaction data by joining
    fact.FactExpense with related date, bank, and description dimensions.

Source Objects:
    - fact.FactExpense
    - dim.DimDate
    - dim.DimBank
    - dim.DimDescription

Grain:
    One row represents one expense transaction.

Business Rules:
    1. ExpenseAmount represents the finalized warehouse-calculated expense amount.
    2. TransactionDate comes from dim.DimDate.FullDate.
    3. BankName comes from dim.DimBank.
    4. Description, Category, SubCategory, and ExpenseType come from dim.DimDescription.
    5. SourceExpenseID supports source-to-warehouse traceability.
    6. LoadDate supports ETL audit and reporting-period review.

Used By:
    - SQL validation
    - Expense troubleshooting
    - Reconciliation review
    - Optional Power BI quick reporting

Power BI Recommendation:
    For an enterprise semantic model, use the fact and dimension tables
    directly instead of this flattened reporting view. Keep this view for
    validation, troubleshooting, and ad hoc SQL review.

Example:
    SELECT *
    FROM rpt.vw_ExpenseDetail;

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial expense detail reporting view.
------------------------------------------------------------------------------------------------***/
CREATE OR ALTER VIEW [rpt].[vw_ExpenseDetail]
AS
SELECT
    f.ExpenseFactKey,
    f.SourceExpenseID,
    f.TransactionID,
    d.FullDate AS TransactionDate,
    d.[Year],
    d.YearMonthNumber,
    d.YearMonthName,
    b.BankName,
    des.DescriptionName,
    des.[Description],
    des.Category,
    des.SubCategory,
    des.ExpenseType,
    f.ExpenseAmount,
    f.LoadDate,
    f.SourceSystem,
    f.CreatedDate
FROM fact.FactExpense f
INNER JOIN dim.DimDate d
    ON d.DateKey = f.TransactionDateKey
INNER JOIN dim.DimBank b
    ON b.BankKey = f.BankKey
INNER JOIN dim.DimDescription des
    ON des.DescriptionKey = f.DescriptionKey;
GO