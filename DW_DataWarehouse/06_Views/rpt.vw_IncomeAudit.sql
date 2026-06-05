USE [DW_FamilyFinance]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************
View Name    : rpt.vw_IncomeAudit
Author       : Behailu Tessema
Created Date : 06/04/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Identifies income source records that fail required dimension matching
    before or after loading into fact.FactIncome.

Source Table:
    - STG_FamilyLiving.dbo.Family_Income

Dimension Check:
    - dim.DimIncomeSource

Business Rules:
    1. Work_Place + Employee_FullName must match dim.DimIncomeSource.
    2. One income source is defined as one employee at one workplace.
    3. Records with missing income source matches are returned.
    4. Expected result is zero rows.
    5. Rows returned by this view require correction before the warehouse
       should be considered fully reconciled.

Audit Status Column:
    IncomeSourceAuditStatus:
        - Missing Income Source
        - Matched

Recommended Fix:
    Missing Income Source:
        1. Run:
           EXEC etl.usp_Load_DimIncomeSource;

        2. Re-run:
           EXEC etl.usp_Load_DW_FamilyFinance;

Used By:
    - Data quality checks
    - ETL validation
    - Payroll reconciliation
    - Optional Power BI admin page

Expected Result:
    SELECT * FROM rpt.vw_IncomeAudit;
    -- Should return zero rows.

Notes:
    This view is intended for ETL audit, troubleshooting, and source-to-dimension
    matching validation. It should not be used as a primary business reporting view.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial audit view for income dimension matching.
------------------------------------------------------------------------------------------------***/
CREATE OR ALTER VIEW [rpt].[vw_IncomeAudit]
AS
SELECT
    s.IncomeSourceID AS SourceIncomeID,
    s.Period_Bginning,
    s.Period_Ending,
    s.Pay_Day,
    s.Work_Place,
    s.Employee_FullName,
    s.Gross_Payment,
    s.Employer_NetPay,
    CASE
        WHEN ds.IncomeSourceKey IS NULL THEN 'Missing Income Source'
        ELSE 'Matched'
    END AS IncomeSourceAuditStatus
FROM STG_FamilyLiving.dbo.Family_Income s
LEFT JOIN dim.DimIncomeSource ds
    ON ds.WorkPlace = LTRIM(RTRIM(s.Work_Place))
   AND ds.EmployeeFullName = LTRIM(RTRIM(s.Employee_FullName))
WHERE ds.IncomeSourceKey IS NULL;
GO