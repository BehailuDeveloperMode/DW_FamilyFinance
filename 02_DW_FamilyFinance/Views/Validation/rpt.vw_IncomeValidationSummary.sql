USE [DW_FamilyFinance];
GO

/***************************************************************************************************
View Name    : rpt.vw_IncomeValidation
Author       : Behailu Tessema
Created Date : 07/03/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Validates that every staging income record has successfully loaded into fact.FactIncome.

Expected Result:
    SELECT *
    FROM rpt.vw_IncomeValidation
    WHERE ValidationStatus = 'Missing in DW';
    -- Should return zero rows.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
07/03/2026   Behailu Tessema     Initial income STG-to-DW validation view.
***************************************************************************************************/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER VIEW [rpt].[vw_IncomeValidation]
AS
SELECT
    s.IncomeSourceID,
    s.[Period_Bginning] AS PeriodBeginning,
    s.[Period_Ending] AS PeriodEnding,
    s.Pay_Day AS PayDate,
    s.Work_Place,
    s.Employee_FullName,
    s.Gross_Payment,
    s.Employer_NetPay,
    s.Total_Tax,
    s.LoadDate AS STGLoadDate,

    f.IncomeFactKey,
    f.SourceIncomeID,
    f.LoadDate AS DWLoadDate,

    CASE
        WHEN f.SourceIncomeID IS NULL THEN 'Missing in DW'
        ELSE 'Loaded'
    END AS ValidationStatus
FROM STG_FamilyLiving.dbo.Family_Income AS s
LEFT JOIN DW_FamilyFinance.fact.FactIncome AS f
    ON s.IncomeSourceID = f.SourceIncomeID;
GO