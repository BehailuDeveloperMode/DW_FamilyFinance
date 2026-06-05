USE [DW_FamilyFinance]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************
View Name    : rpt.vw_ExpenseReconciliation
Author       : Behailu Tessema
Created Date : 06/04/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Reconciles source expense records against fact.FactExpense to verify
    that all staging transactions have been successfully loaded into the
    warehouse fact table.

Source Table:
    - STG_FamilyLiving.dbo.STG_FamilySourceData

Target Table:
    - DW_FamilyFinance.fact.FactExpense

Business Rules:
    1. SourceRowCount represents the total number of source expense records.
    2. FactRowCount represents the total number of records loaded into FactExpense.
    3. RowDifference is calculated as:
       
       SourceRowCount - FactRowCount

    4. ReconciliationStatus is determined as follows:

       PASS
           RowDifference = 0

       FAIL
           RowDifference <> 0

Expected Result:
    RowDifference = 0
    ReconciliationStatus = PASS

Interpretation:
    RowDifference = 0
        All source records successfully loaded.

    RowDifference > 0
        Source records exist that have not been loaded into FactExpense.

    RowDifference < 0
        FactExpense contains more rows than the source and should be
        investigated.

Used By:
    - Data quality monitoring
    - ETL validation
    - Warehouse reconciliation
    - Power BI administration dashboard

Power BI Recommendation:
    Recommended for a hidden Data Quality page used by administrators
    and developers to validate warehouse load completeness.

Example:
    SELECT *
    FROM rpt.vw_ExpenseReconciliation;

Future Enhancement:
    Extend reconciliation reporting to include:
        - Income reconciliation
        - Missing dimension records
        - Unmapped descriptions
        - Duplicate source transactions
        - ETL exception reporting

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial expense reconciliation view.
------------------------------------------------------------------------------------------------***/
CREATE OR ALTER VIEW [rpt].[vw_ExpenseReconciliation]
AS
SELECT
    'Expense' AS SubjectArea,

    (SELECT COUNT(*)
     FROM STG_FamilyLiving.dbo.STG_FamilySourceData) AS SourceRowCount,

    (SELECT COUNT(*)
     FROM fact.FactExpense) AS FactRowCount,

    (SELECT COUNT(*)
     FROM STG_FamilyLiving.dbo.STG_FamilySourceData)
    -
    (SELECT COUNT(*)
     FROM fact.FactExpense) AS RowDifference,

    CASE
        WHEN
            (
                (SELECT COUNT(*)
                 FROM STG_FamilyLiving.dbo.STG_FamilySourceData)
                -
                (SELECT COUNT(*)
                 FROM fact.FactExpense)
            ) = 0
        THEN 'PASS'
        ELSE 'FAIL'
    END AS ReconciliationStatus;
GO