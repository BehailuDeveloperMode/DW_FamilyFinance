USE [DW_FamilyFinance];
GO

/***************************************************************************************************
View Name    : rpt.vw_ExpenseValidation
Author       : Behailu Tessema
Created Date : 07/03/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Validates that every staging expense record has successfully loaded into fact.FactExpense.

Expected Result:
    SELECT *
    FROM rpt.vw_ExpenseValidation
    WHERE ValidationStatus = 'Missing in DW';
    -- Should return zero rows.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
07/03/2026   Behailu Tessema     Initial expense STG-to-DW validation view.
***************************************************************************************************/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER VIEW [rpt].[vw_ExpenseValidation]
AS
SELECT
    s.ExpenseSourceID,
    s.Transaction_ID,
    s.[Date] AS TransactionDate,
    s.Description,
    s.Debit,
    s.Credit,
    s.Category,
    s.SourceName,
    s.FileName,
    s.FileYear,
    s.LoadDate AS STGLoadDate,

    f.ExpenseFactKey,
    f.SourceExpenseID,
    f.LoadDate AS DWLoadDate,

    CASE
        WHEN f.SourceExpenseID IS NULL THEN 'Missing in DW'
        ELSE 'Loaded'
    END AS ValidationStatus
FROM STG_FamilyLiving.dbo.STG_FamilySourceData AS s
LEFT JOIN DW_FamilyFinance.fact.FactExpense AS f
    ON s.ExpenseSourceID = f.SourceExpenseID;
GO