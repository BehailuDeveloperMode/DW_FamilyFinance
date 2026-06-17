/*************************************************************************************************
Object Name: rpt.vw_ExpenseByCategory
Created By : Behailu Tessema
Project    : DW_FamilyFinance
Purpose    : Provides summarized expense amounts and transaction counts by expense category.

Description:
    - Aggregates expense transactions from FactExpense.
    - Uses DimDescription to retrieve Category information.
    - Returns total expense and number of transactions for each category.
    - Used for expense analysis, reporting, and Power BI dashboards.

Source Tables:
    - fact.FactExpense
    - dim.DimDescription

Business Rules:
    - Expense totals are calculated using ExpenseAmount.
    - TransactionCount represents the number of expense records.
    - Categories originate from DimDescription.

Example Usage:
    SELECT *
    FROM rpt.vw_ExpenseByCategory
    ORDER BY TotalExpense DESC;

*************************************************************************************************/
USE DW_FamilyFinance;
GO

CREATE OR ALTER VIEW rpt.vw_ExpenseByCategory
AS
SELECT
      d.Category
    , SUM(f.ExpenseAmount) AS TotalExpense
    , COUNT(*) AS TransactionCount
FROM fact.FactExpense AS f
INNER JOIN dim.DimDescription AS d
    ON f.DescriptionKey = d.DescriptionKey
GROUP BY
      d.Category;
GO