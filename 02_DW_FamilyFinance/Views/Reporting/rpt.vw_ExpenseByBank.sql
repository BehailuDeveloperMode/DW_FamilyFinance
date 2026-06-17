/*************************************************************************************************
Object Name: rpt.vw_ExpenseByBank
Created By : Behailu Tessema
Project    : DW_FamilyFinance
Purpose    : Provides summarized expense amounts and transaction counts by bank.

Description:
    - Aggregates expenses by financial institution.
    - Uses DimBank for bank name information.
    - Returns total expense and transaction counts for each bank.
    - Supports bank spending analysis and reconciliation reporting.

Source Tables:
    - fact.FactExpense
    - dim.DimBank

Business Rules:
    - Expense totals are calculated using ExpenseAmount.
    - TransactionCount represents the number of expense records.
    - Bank information is sourced from DimBank.

Example Usage:
    SELECT *
    FROM rpt.vw_ExpenseByBank
    ORDER BY TotalExpense DESC;

*************************************************************************************************/
USE DW_FamilyFinance;
GO

CREATE OR ALTER VIEW rpt.vw_ExpenseByBank
AS
SELECT
      b.BankName
    , SUM(f.ExpenseAmount) AS TotalExpense
    , COUNT(*) AS TransactionCount
FROM fact.FactExpense AS f
INNER JOIN dim.DimBank AS b
    ON f.BankKey = b.BankKey
GROUP BY
      b.BankName;
GO
WELLSFARGO BANK
