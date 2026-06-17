USE [DW_FamilyFinance];


GO
SET ANSI_NULLS ON;


GO
SET QUOTED_IDENTIFIER ON;


GO
/***************************************************************************************************
View Name    : rpt.vw_RecordCountReconciliation
Author       : Behailu Tessema
Created Date : 06/04/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Provides a combined record-count reconciliation between staging source
    tables and DW_FamilyFinance fact tables for expense and income subject areas.

Source Tables:
    - STG_FamilyLiving.dbo.STG_FamilySourceData
    - STG_FamilyLiving.dbo.Family_Income

Target Tables:
    - DW_FamilyFinance.fact.FactExpense
    - DW_FamilyFinance.fact.FactIncome

Business Rules:
    1. SourceExpenseRows represents total expense rows in staging.
    2. FactExpenseRows represents total expense rows loaded into fact.FactExpense.
    3. SourceIncomeRows represents total income rows in staging.
    4. FactIncomeRows represents total income rows loaded into fact.FactIncome.
    5. ExpenseRowDifference is SourceExpenseRows minus FactExpenseRows.
    6. IncomeRowDifference is SourceIncomeRows minus FactIncomeRows.
    7. Audit_Status is PASS only when both expense and income row counts match.
    8. Audit_Status is FAIL when either subject area has a row-count difference.

Expected Result:
    Audit_Status = PASS

Used By:
    - ETL validation
    - Data quality monitoring
    - Warehouse reconciliation
    - Optional Power BI admin dashboard

Power BI Recommendation:
    Use this view on a hidden Data Quality page to provide a quick
    warehouse health-check card for expense and income row-count alignment.

Example:
    SELECT *
    FROM rpt.vw_RecordCountReconciliation;

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial combined record-count reconciliation view.
------------------------------------------------------------------------------------------------***/
CREATE OR ALTER VIEW [rpt].[vw_RecordCountReconciliation]
AS
SELECT stg_exp.SourceExpenseRows,
       dw_exp.FactExpenseRows,
       stg_exp.SourceExpenseRows - dw_exp.FactExpenseRows AS ExpenseRowDifference,
       stg_inc.SourceIncomeRows,
       dw_inc.FactIncomeRows,
       stg_inc.SourceIncomeRows - dw_inc.FactIncomeRows AS IncomeRowDifference,
       CASE WHEN stg_exp.SourceExpenseRows = dw_exp.FactExpenseRows
                 AND stg_inc.SourceIncomeRows = dw_inc.FactIncomeRows THEN 'PASS' ELSE 'FAIL' END AS Audit_Status
FROM   (SELECT COUNT_BIG(*) AS SourceExpenseRows
        FROM   STG_FamilyLiving.dbo.STG_FamilySourceData) AS stg_exp CROSS JOIN (SELECT COUNT_BIG(*) AS FactExpenseRows
                                                                                 FROM   DW_FamilyFinance.fact.FactExpense) AS dw_exp CROSS JOIN (SELECT COUNT_BIG(*) AS SourceIncomeRows
                                                                                                                                                 FROM   STG_FamilyLiving.dbo.Family_Income) AS stg_inc CROSS JOIN (SELECT COUNT_BIG(*) AS FactIncomeRows
                                                                                                                                                                                                                   FROM   DW_FamilyFinance.fact.FactIncome) AS dw_inc;