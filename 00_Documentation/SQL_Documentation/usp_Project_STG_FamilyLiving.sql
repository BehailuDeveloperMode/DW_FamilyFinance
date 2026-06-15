USE [master];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

/***************************************************************************************************
Procedure Name : dbo.usp_Project_STG_FamilyLiving
Author         : Behailu Tessema
Created Date   : 06/05/2026
Database       : master
Schema         : dbo
Project        : DW_FamilyFinance Data Platform

Purpose:
Provides enterprise documentation for the STG_FamilyLiving staging layer.

Description:
This procedure documents the STG_FamilyLiving staging database, source flow,
staging tables, validation views, utility stored procedures, business rules,
relationship to DW_FamilyFinance, and repository structure.

Data Flow:
Source Files
↓
SSIS
↓
STG_FamilyLiving
↓
DW_FamilyFinance
↓
Power BI

## Modification History:

## Date         Author              Description

06/05/2026   Behailu Tessema     Updated STG documentation for new repository architecture.
***************************************************************************************************/

CREATE OR ALTER PROCEDURE dbo.usp_Project_STG_FamilyLiving
AS
BEGIN
SET NOCOUNT ON;


/* SECTION 1 - PROJECT OVERVIEW */
SELECT
    'SECTION 1 - PROJECT OVERVIEW' AS DocumentationSection,
    'STG_FamilyLiving' AS ProjectName,
    'Staging layer for DW_FamilyFinance Data Platform' AS ProjectDescription,
    'Version 1.0' AS VersionNo,
    'Behailu Tessema' AS ProjectOwner,
    'SQL Server 2022, SSIS, Git' AS Technologies,
    SYSDATETIME() AS DocumentationGeneratedDate;

/* SECTION 2 - SOURCE FLOW */
SELECT *
FROM
(
    VALUES
    ('Expense Data', 'Bank source files -> SSIS -> STG_FamilySourceData -> DW_FamilyFinance.fact.FactExpense'),
    ('Income Data', 'Google Form / Excel -> SSIS -> Family_Income -> DW_FamilyFinance.fact.FactIncome'),
    ('Lookup Data', 'Manual lookup maintenance -> STG_Description_LookUp -> DW_FamilyFinance.dim.DimDescription'),
    ('File Audit', 'SSIS file load process -> STG_FileLoadAudit')
) AS S(SourceArea, SourceFlow);

/* SECTION 3 - STAGING TABLES */
SELECT *
FROM
(
    VALUES
    ('dbo.STG_FamilySourceData', 'Stores staged expense transaction data from bank source files'),
    ('dbo.Family_Income', 'Stores staged payroll and income data'),
    ('dbo.STG_Description_LookUp', 'Stores controlled description, category, subcategory, and expense type mappings'),
    ('dbo.STG_FileLoadAudit', 'Tracks SSIS source file load activity and row counts')
) AS T(TableName, TablePurpose);

/* SECTION 4 - STAGING VIEWS */
SELECT *
FROM
(
    VALUES
    ('dbo.vw_FamilyIncomeValidation', 'Validates payroll tax totals, net pay, and payment validation status'),
    ('dbo.vw_Description_NoMatching', 'Identifies source descriptions missing from the lookup table')
) AS V(ViewName, ViewPurpose);

/* SECTION 5 - STAGING STORED PROCEDURES */
SELECT *
FROM
(
    VALUES
    ('dbo.usp_Create_STG_FamilyLiving', 'Creates STG_FamilyLiving database if it does not exist'),
    ('dbo.usp_IdentifyDuplicateLookupSubCategory', 'Identifies subcategories mapped to multiple categories or expense types'),
    ('dbo.usp_SearchSourceExpenseDescription', 'Searches source expense transactions by description text'),
    ('dbo.usp_SourceRecordCountByYearAndMonth', 'Displays source transaction counts by year, month, and source'),
    ('dbo.usp_UppercaseLookupColumns', 'Standardizes lookup columns to uppercase')
) AS P(ProcedureName, ProcedurePurpose);

/* SECTION 6 - BUSINESS RULES */
SELECT *
FROM
(
    VALUES
    ('Expense Staging Grain', 'One row in STG_FamilySourceData represents one source bank transaction'),
    ('Income Staging Grain', 'One row in Family_Income represents one paycheck for one employee from one workplace'),
    ('Lookup Rule', 'LookUp_Description_Name must be unique to prevent duplicate mappings'),
    ('LoadDate Rule', 'Expense LoadDate is calculated as the 3rd day of the following month'),
    ('Audit Rule', 'Each SSIS file load should be tracked in STG_FileLoadAudit'),
    ('Validation Rule', 'Income rows should pass vw_FamilyIncomeValidation before DW loading')
) AS B(RuleName, RuleDescription);

/* SECTION 7 - SOURCE TO TARGET MAPPING */
SELECT *
FROM
(
    VALUES
    ('STG_FamilyLiving.dbo.STG_FamilySourceData', 'DW_FamilyFinance.fact.FactExpense', 'Expense transactions'),
    ('STG_FamilyLiving.dbo.Family_Income', 'DW_FamilyFinance.fact.FactIncome', 'Payroll and income records'),
    ('STG_FamilyLiving.dbo.STG_Description_LookUp', 'DW_FamilyFinance.dim.DimDescription', 'Description and category mappings'),
    ('STG_FamilyLiving.dbo.STG_FamilySourceData.SourceName', 'DW_FamilyFinance.dim.DimBank', 'Bank/source mapping'),
    ('STG_FamilyLiving.dbo.Family_Income.Work_Place', 'DW_FamilyFinance.dim.DimIncomeSource', 'Employer/workplace mapping')
) AS M(SourceObject, TargetObject, MappingPurpose);

/* SECTION 8 - DATA QUALITY CONTROLS */
SELECT *
FROM
(
    VALUES
    ('Income Validation', 'Use dbo.vw_FamilyIncomeValidation to identify payroll calculation issues'),
    ('Unmatched Description Review', 'Use dbo.vw_Description_NoMatching to find source descriptions missing from lookup'),
    ('Duplicate Subcategory Review', 'Use dbo.usp_IdentifyDuplicateLookupSubCategory to find inconsistent lookup mappings'),
    ('Source Record Count Review', 'Use dbo.usp_SourceRecordCountByYearAndMonth to validate source load counts'),
    ('Lookup Standardization', 'Use dbo.usp_UppercaseLookupColumns before loading DimDescription')
) AS Q(ControlName, ControlDescription);

/* SECTION 9 - REPOSITORY STRUCTURE */
SELECT *
FROM
(
    VALUES
    ('STG_FamilyLiving\00_Documentation', 'STG project documentation procedures'),
    ('STG_FamilyLiving\01_Database', 'STG database creation scripts'),
    ('STG_FamilyLiving\02_Tables', 'STG table creation scripts'),
    ('STG_FamilyLiving\03_StoredProcedures', 'STG utility, audit, and cleanup procedures'),
    ('STG_FamilyLiving\04_Views', 'STG validation and data quality views'),
    ('STG_FamilyLiving\05_TestScripts', 'STG validation and test scripts')
) AS G(FolderPath, FolderPurpose);

/* SECTION 10 - DEPLOYMENT ORDER */
SELECT *
FROM
(
    VALUES
    (1, 'Create or verify STG_FamilyLiving database'),
    (2, 'Create STG tables'),
    (3, 'Create STG views'),
    (4, 'Create STG stored procedures'),
    (5, 'Deploy SSIS packages'),
    (6, 'Load source files into STG tables'),
    (7, 'Run STG validation views and procedures'),
    (8, 'Load DW_FamilyFinance from STG_FamilyLiving'),
    (9, 'Validate DW reconciliation'),
    (10, 'Refresh Power BI')
) AS D(StepNumber, DeploymentStep);


END;
GO

EXEC dbo.usp_Project_STG_FamilyLiving;
GO
