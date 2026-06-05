USE [DW_FamilyFinance]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************
View Name    : rpt.vw_MonthlyFinancialSummary
Author       : Behailu Tessema
Created Date : 06/04/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Provides a monthly financial summary of income, expenses, and net savings
    for SQL review, validation, and optional executive reporting.

Source Objects:
    - fact.FactExpense
    - fact.FactIncome
    - dim.DimDate

Grain:
    One row per YearMonthNumber.

Business Rules:
    1. TotalIncome is calculated from fact.FactIncome.EmployerNetPay.
    2. TotalExpense is calculated from fact.FactExpense.ExpenseAmount.
    3. NetSavings is calculated as TotalIncome minus TotalExpense.
    4. Expense activity is grouped by FactExpense.TransactionDateKey.
    5. Income activity is grouped by FactIncome.PayDateKey.
    6. Months with only income or only expense are retained using FULL OUTER JOIN.
    7. NULL income or expense values are converted to 0.00.

Calculations:
    TotalIncome  = SUM(fact.FactIncome.EmployerNetPay)
    TotalExpense = SUM(fact.FactExpense.ExpenseAmount)
    NetSavings   = TotalIncome - TotalExpense

Date Rules:
    Expense Date:
        fact.FactExpense.TransactionDateKey -> dim.DimDate.DateKey

    Income Date:
        fact.FactIncome.PayDateKey -> dim.DimDate.DateKey

Used By:
    - SQL validation
    - Monthly financial review
    - Optional executive summary reporting
    - Optional Power BI quick reporting

Power BI Recommendation:
    For an enterprise Power BI semantic model, use the underlying fact and
    dimension tables directly and create income, expense, and savings logic
    as DAX measures. Keep this view for SQL-based validation and review.

Example:
    SELECT *
    FROM rpt.vw_MonthlyFinancialSummary
    ORDER BY YearMonthNumber;

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial monthly financial summary view.
------------------------------------------------------------------------------------------------***/
CREATE OR ALTER VIEW [rpt].[vw_MonthlyFinancialSummary]
AS
WITH ExpenseMonthly AS
(
    SELECT
        d.[Year],
        d.YearMonthNumber,
        d.YearMonthName,
        SUM(e.ExpenseAmount) AS TotalExpense
    FROM fact.FactExpense e
    INNER JOIN dim.DimDate d
        ON d.DateKey = e.TransactionDateKey
    GROUP BY
        d.[Year],
        d.YearMonthNumber,
        d.YearMonthName
),
IncomeMonthly AS
(
    SELECT
        d.[Year],
        d.YearMonthNumber,
        d.YearMonthName,
        SUM(i.EmployerNetPay) AS TotalIncome
    FROM fact.FactIncome i
    INNER JOIN dim.DimDate d
        ON d.DateKey = i.PayDateKey
    GROUP BY
        d.[Year],
        d.YearMonthNumber,
        d.YearMonthName
)
SELECT
    COALESCE(e.[Year], i.[Year]) AS [Year],
    COALESCE(e.YearMonthNumber, i.YearMonthNumber) AS YearMonthNumber,
    COALESCE(e.YearMonthName, i.YearMonthName) AS YearMonthName,
    ISNULL(i.TotalIncome, 0.00) AS TotalIncome,
    ISNULL(e.TotalExpense, 0.00) AS TotalExpense,
    ISNULL(i.TotalIncome, 0.00) - ISNULL(e.TotalExpense, 0.00) AS NetSavings
FROM ExpenseMonthly e
FULL OUTER JOIN IncomeMonthly i
    ON e.YearMonthNumber = i.YearMonthNumber;
GO