USE [DW_FamilyFinance]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************
View Name    : rpt.vw_IncomeReconciliation
Author       : Behailu Tessema
Created Date : 06/04/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Reconciles source income records against fact.FactIncome to verify
    that all staging paycheck records have been successfully loaded into
    the warehouse fact table.

Source Table:
    - STG_FamilyLiving.dbo.Family_Income

Target Table:
    - DW_FamilyFinance.fact.FactIncome

Business Rules:
    1. SourceRowCount represents the total number of source income records.
    2. FactRowCount represents the total number of records loaded into FactIncome.
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
        All source income records successfully loaded.

    RowDifference > 0
        Source income rows exist that have not been loaded into FactIncome.

    RowDifference < 0
        FactIncome contains more rows than the source and should be investigated.

Used By:
    - Data quality monitoring
    - ETL validation
    - Payroll reconciliation
    - Power BI administration dashboard

Power BI Recommendation:
    Recommended for a hidden Data Quality page used by administrators
    and developers to validate warehouse load completeness.

Example:
    SELECT *
    FROM rpt.vw_IncomeReconciliation;

Future Enhancement:
    Extend reconciliation reporting to include:
        - Income amount reconciliation
        - Payroll validation checks
        - Missing income source mappings
        - Duplicate paycheck detection
        - ETL exception reporting

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial income reconciliation view.
------------------------------------------------------------------------------------------------***/
CREATE OR ALTER VIEW [rpt].[vw_IncomeReconciliation]
AS
SELECT
    'Income' AS SubjectArea,

    (SELECT COUNT(*)
     FROM STG_FamilyLiving.dbo.Family_Income) AS SourceRowCount,

    (SELECT COUNT(*)
     FROM fact.FactIncome) AS FactRowCount,

    (SELECT COUNT(*)
     FROM STG_FamilyLiving.dbo.Family_Income)
    -
    (SELECT COUNT(*)
     FROM fact.FactIncome) AS RowDifference,

    CASE
        WHEN
            (
                (SELECT COUNT(*)
                 FROM STG_FamilyLiving.dbo.Family_Income)
                -
                (SELECT COUNT(*)
                 FROM fact.FactIncome)
            ) = 0
        THEN 'PASS'
        ELSE 'FAIL'
    END AS ReconciliationStatus;
GO