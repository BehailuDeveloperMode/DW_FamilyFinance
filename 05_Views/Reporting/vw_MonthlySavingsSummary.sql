USE [DW_FamilyFinance];


GO
SET ANSI_NULLS ON;


GO
SET QUOTED_IDENTIFIER ON;


GO
/***************************************************************************************************
View Name    : rpt.vw_MonthlySavingsSummary
Author       : Behailu Tessema
Created Date : 06/04/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Provides monthly income, expense, net savings, and annual savings totals
    for SQL review, savings validation, and optional executive reporting.

Source Objects:
    - fact.FactIncome
    - fact.FactExpense
    - dim.DimDate

Replaces Old Object:
    - STG_FamilyLiving.dbo.usp_Grand_Saving

Grain:
    One row per YearMonthNumber.

Business Rules:
    1. TotalPay is calculated from fact.FactIncome.EmployerNetPay.
    2. TotalExpense is calculated from fact.FactExpense.ExpenseAmount.
    3. NetSavings is calculated as TotalPay minus TotalExpense.
    4. GrandSaving is the annual total of monthly NetSavings.
    5. GrandSaving is partitioned by calendar year.
    6. Income is grouped by FactIncome.PayDateKey.
    7. Expense is grouped by FactExpense.TransactionDateKey.
    8. Months with only income or only expense are retained using FULL OUTER JOIN.
    9. NULL income or expense values are converted to 0.00.

Calculations:
    TotalPay     = SUM(fact.FactIncome.EmployerNetPay)
    TotalExpense = SUM(fact.FactExpense.ExpenseAmount)
    NetSavings   = TotalPay - TotalExpense
    GrandSaving  = SUM(NetSavings) OVER (PARTITION BY Year)

Date Rules:
    Income Date:
        fact.FactIncome.PayDateKey -> dim.DimDate.DateKey

    Expense Date:
        fact.FactExpense.TransactionDateKey -> dim.DimDate.DateKey

Used By:
    - SQL validation
    - Savings review
    - Financial summary analysis
    - Optional executive reporting
    - Optional Power BI quick reporting

Power BI Recommendation:
    For an enterprise Power BI semantic model, use the underlying fact and
    dimension tables directly and create savings logic as DAX measures.
    Keep this view for SQL-based validation and quick review.

Example:
    SELECT *
    FROM rpt.vw_MonthlySavingsSummary
    WHERE [Year] = 2026
    ORDER BY YearMonthNumber;

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Replacement for usp_Grand_Saving.
------------------------------------------------------------------------------------------------***/
CREATE OR ALTER VIEW [rpt].[vw_MonthlySavingsSummary]
AS
WITH   ExpenseMonthly
AS     (SELECT   d.[Year],
                 d.MonthNumber,
                 d.MonthName,
                 d.YearMonthNumber,
                 d.YearMonthName,
                 SUM(e.ExpenseAmount) AS TotalExpense
        FROM     fact.FactExpense AS e
                 INNER JOIN
                 dim.DimDate AS d
                 ON d.DateKey = e.TransactionDateKey
        GROUP BY d.[Year], d.MonthNumber, d.MonthName, d.YearMonthNumber, d.YearMonthName),
       IncomeMonthly
AS     (SELECT   d.[Year],
                 d.MonthNumber,
                 d.MonthName,
                 d.YearMonthNumber,
                 d.YearMonthName,
                 SUM(i.EmployerNetPay) AS TotalPay
        FROM     fact.FactIncome AS i
                 INNER JOIN
                 dim.DimDate AS d
                 ON d.DateKey = i.PayDateKey
        GROUP BY d.[Year], d.MonthNumber, d.MonthName, d.YearMonthNumber, d.YearMonthName)
SELECT COALESCE (i.[Year], e.[Year]) AS [Year],
       COALESCE (i.MonthNumber, e.MonthNumber) AS MonthNumber,
       COALESCE (i.MonthName, e.MonthName) AS MonthName,
       COALESCE (i.YearMonthNumber, e.YearMonthNumber) AS YearMonthNumber,
       COALESCE (i.YearMonthName, e.YearMonthName) AS YearMonthName,
       ISNULL(i.TotalPay, 0.00) AS TotalPay,
       ISNULL(e.TotalExpense, 0.00) AS TotalExpense,
       ISNULL(i.TotalPay, 0.00) - ISNULL(e.TotalExpense, 0.00) AS NetSavings,
       SUM(ISNULL(i.TotalPay, 0.00) - ISNULL(e.TotalExpense, 0.00)) OVER (PARTITION BY COALESCE (i.[Year], e.[Year])) AS GrandSaving
FROM   IncomeMonthly AS i
       FULL OUTER JOIN
       ExpenseMonthly AS e
       ON i.YearMonthNumber = e.YearMonthNumber;