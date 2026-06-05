USE [STG_FamilyLiving];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

/***************************************************************************************************
View Name    : dbo.vw_Description_NoMatching
Author       : Behailu Tessema
Created Date : 06/05/2026
Database     : STG_FamilyLiving
Schema       : dbo
Project      : DW_FamilyFinance Data Platform

Purpose:
    Identifies expense source descriptions that do not exist in the
    STG_Description_LookUp table.

Source Tables:
    - STG_FamilyLiving.dbo.STG_FamilySourceData
    - STG_FamilyLiving.dbo.STG_Description_LookUp

Business Rules:
    1. Source descriptions must be mapped in STG_Description_LookUp.
    2. Any source description missing from the lookup table is returned by this view.
    3. The result supports lookup maintenance before loading DW_FamilyFinance.
    4. One row is returned per unmatched source description and source name.

Used By:
    - SSIS unmatched description export package
    - Lookup maintenance process
    - Expense categorization review
    - DW data quality preparation

Example:
    SELECT *
    FROM dbo.vw_Description_NoMatching
    ORDER BY SourceName, DescriptionName;

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/05/2026   Behailu Tessema     Initial unmatched description validation view.
***************************************************************************************************/

CREATE OR ALTER VIEW dbo.vw_Description_NoMatching
AS
SELECT DISTINCT
    LTRIM(RTRIM(s.[Description])) AS DescriptionName,
    s.SourceName,
    COUNT_BIG(*) AS SourceRecordCount,
    MIN(s.[Date]) AS FirstTransactionDate,
    MAX(s.[Date]) AS LastTransactionDate
FROM dbo.STG_FamilySourceData s
LEFT JOIN dbo.STG_Description_LookUp l
    ON LTRIM(RTRIM(s.[Description])) = LTRIM(RTRIM(l.LookUp_Description_Name))
WHERE s.[Description] IS NOT NULL
  AND LTRIM(RTRIM(s.[Description])) <> ''
  AND l.LookUp_Description_Name IS NULL
GROUP BY
    LTRIM(RTRIM(s.[Description])),
    s.SourceName;
GO