USE [DW_FamilyFinance];


GO
SET ANSI_NULLS ON;


GO
SET QUOTED_IDENTIFIER ON;


GO
/***************************************************************************************************
View Name    : rpt.vw_ExpenseRecordCountByYearBank
Author       : Behailu Tessema
Created Date : 06/04/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Provides yearly expense transaction counts by bank/source for audit,
    reconciliation, source review, and data-quality monitoring.

Source Objects:
    - fact.FactExpense
    - dim.DimDate
    - dim.DimBank

Replaces Old Objects:
    - STG_FamilyLiving.dbo.FamilyLiving_Audit
    - STG_FamilyLiving.dbo.usp_FamilyLiving_Audit

Grain:
    One row represents one bank/source for one calendar year.

Business Rules:
    1. RecordCount represents the number of expense fact rows.
    2. Year is derived from dim.DimDate.
    3. BankName is derived from dim.DimBank.
    4. Counts are based on fact.FactExpense transaction rows.
    5. This view replaces the old staging-level audit process.

Used By:
    - SQL validation
    - Source volume review
    - Data quality monitoring
    - Optional Power BI admin page

Power BI Recommendation:
    Use this view for a hidden Data Quality or Admin dashboard page to
    monitor annual expense transaction volume by bank/source.

Example:
    SELECT *
    FROM rpt.vw_ExpenseRecordCountByYearBank
    ORDER BY [Year], BankName;

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial annual expense count audit view.
------------------------------------------------------------------------------------------------***/
CREATE OR ALTER VIEW [rpt].[vw_ExpenseRecordCountByYearBank]
AS
SELECT   d.[Year],
         b.BankName,
         COUNT_BIG(*) AS RecordCount
FROM     fact.FactExpense AS f
         INNER JOIN
         dim.DimDate AS d
         ON d.DateKey = f.TransactionDateKey
         INNER JOIN
         dim.DimBank AS b
         ON b.BankKey = f.BankKey
GROUP BY d.[Year], b.BankName;