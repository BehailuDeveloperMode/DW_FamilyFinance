/*************************************************************************************************
Object Name: rpt.vw_MonthlyExpenseTrend
Created By : Behailu Tessema
Project    : DW_FamilyFinance
Purpose    : Provides monthly expense trends for financial reporting and analysis.

Description:
    - Summarizes expenses by month and year.
    - Uses DimDate for calendar attributes.
    - Returns monthly expense totals and transaction counts.
    - Supports trend analysis and Power BI visualizations.

Source Tables:
    - fact.FactExpense
    - dim.DimDate

Business Rules:
    - Expenses are grouped by Year and YearMonthNumber.
    - TotalExpense is calculated from ExpenseAmount.
    - TransactionCount represents the number of expense records.

Example Usage:
    SELECT *
    FROM rpt.vw_MonthlyExpenseTrend
    ORDER BY Year, YearMonthNumber;

*************************************************************************************************/
USE DW_FamilyFinance;
GO

CREATE OR ALTER VIEW rpt.vw_MonthlyExpenseTrend
AS
SELECT
      d.Year
    , d.YearMonthNumber
    , d.YearMonthName
    , SUM(f.ExpenseAmount) AS TotalExpense
    , COUNT(*) AS TransactionCount
FROM fact.FactExpense AS f
INNER JOIN dim.DimDate AS d
    ON f.TransactionDateKey = d.DateKey
GROUP BY
      d.Year
    , d.YearMonthNumber
    , d.YearMonthName;
GO