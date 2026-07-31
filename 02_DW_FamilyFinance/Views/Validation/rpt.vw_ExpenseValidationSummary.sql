USE [DW_FamilyFinance];
GO

/***************************************************************************************************
View Name    : rpt.vw_ExpenseValidationSummary
Author       : Behailu Tessema
Created Date : 07/03/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Provides summary reconciliation between STG expense records and fact.FactExpense.

Expected Result:
    MissingRecordCount should equal 0.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
07/03/2026   Behailu Tessema     Initial expense validation summary view.
***************************************************************************************************/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER VIEW [rpt].[vw_ExpenseValidationSummary]
AS
SELECT
    COUNT(*) AS STG_RecordCount,

    SUM(CASE WHEN ExpenseFactKey IS NOT NULL THEN 1 ELSE 0 END) AS DW_RecordCount,

    SUM(CASE WHEN ExpenseFactKey IS NULL THEN 1 ELSE 0 END) AS MissingRecordCount,

    CASE
        WHEN SUM(CASE WHEN ExpenseFactKey IS NULL THEN 1 ELSE 0 END) = 0
            THEN 'PASS'
        ELSE 'FAIL'
    END AS ValidationStatus
FROM rpt.vw_ExpenseValidation;
GO