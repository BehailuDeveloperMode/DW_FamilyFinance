USE [DW_FamilyFinance]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************
View Name    : rpt.vw_ExpenseAudit
Author       : Behailu Tessema
Created Date : 06/04/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Identifies source expense records that fail required dimension matching
    before or after loading into fact.FactExpense.

Source Table:
    - STG_FamilyLiving.dbo.STG_FamilySourceData

Dimension Checks:
    - dim.DimBank
    - dim.DimDescription

Business Rules:
    1. SourceName must match dim.DimBank.BankName.
    2. Source Description must match dim.DimDescription.DescriptionName.
    3. Records with missing bank or description matches are returned.
    4. Expected result is zero rows.
    5. Rows returned by this view require correction before the warehouse
       should be considered fully reconciled.

Audit Status Columns:
    BankAuditStatus:
        - Missing Bank
        - Matched

    DescriptionAuditStatus:
        - Missing Description
        - Matched

Recommended Fix:
    Missing Bank:
        EXEC etl.usp_Load_DimBank;

    Missing Description:
        1. Add or correct the description mapping in:
           STG_FamilyLiving.dbo.STG_Description_LookUp

        2. Run:
           EXEC etl.usp_Load_DimDescription;

        3. Re-run:
           EXEC etl.usp_Load_DW_FamilyFinance;

Used By:
    - Data quality checks
    - ETL validation
    - Reconciliation process
    - Optional Power BI admin page

Expected Result:
    SELECT * FROM rpt.vw_ExpenseAudit;
    -- Should return zero rows.

Notes:
    This view should not be used as a primary business reporting view.
    It is intended for ETL audit, troubleshooting, and source-to-dimension
    matching validation.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial audit view for expense dimension matching.
------------------------------------------------------------------------------------------------***/
CREATE OR ALTER VIEW [rpt].[vw_ExpenseAudit]
AS
SELECT
    s.ExpenseSourceID,
    s.Transaction_ID,
    s.[Date] AS TransactionDate,
    s.[Description],
    s.SourceName AS BankName,
    s.Debit,
    s.Credit,
    s.LoadDate,
    CASE
        WHEN b.BankKey IS NULL THEN 'Missing Bank'
        ELSE 'Matched'
    END AS BankAuditStatus,
    CASE
        WHEN d.DescriptionKey IS NULL THEN 'Missing Description'
        ELSE 'Matched'
    END AS DescriptionAuditStatus
FROM STG_FamilyLiving.dbo.STG_FamilySourceData s
LEFT JOIN dim.DimBank b
    ON b.BankName = LTRIM(RTRIM(s.SourceName))
LEFT JOIN dim.DimDescription d
    ON d.DescriptionName = LTRIM(RTRIM(s.[Description]))
WHERE b.BankKey IS NULL
   OR d.DescriptionKey IS NULL;
GO