USE [STG_FamilyLiving];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

/***************************************************************************************************
Table Name   : dbo.STG_Description_LookUp
Author       : Behailu Tessema
Created Date : 06/05/2026
Database     : STG_FamilyLiving
Schema       : dbo
Project      : DW_FamilyFinance Data Platform

Purpose:
Stores description mappings used to standardize expense transactions
before loading data into DW_FamilyFinance.

Business Rules:
1. LookUp_Description_Name must be unique.
2. One description can only have one active mapping.
3. LoadDate defaults to the current date when a record is inserted.
4. Description mappings support DimDescription loading.
5. Duplicate description names are not allowed.

Used By:
- SSIS lookup maintenance process
- DW_FamilyFinance.etl.usp_Load_DimDescription
- Expense categorization process

Example:
SELECT *
FROM dbo.STG_Description_LookUp;

## Modification History:

## Date         Author              Description

06/05/2026   Behailu Tessema     Initial table creation script.
***************************************************************************************************/

IF OBJECT_ID(N'dbo.STG_Description_LookUp', N'U') IS NULL
BEGIN
CREATE TABLE dbo.STG_Description_LookUp
(
LookUp_Description_Name NVARCHAR(255) NOT NULL,
LookUp_Description NVARCHAR(255) NULL,
LookUp_SubCategory NVARCHAR(255) NULL,
LookUp_ExpenseType NVARCHAR(255) NULL,
LookUp_Category NVARCHAR(255) NULL,


    LoadDate DATE NOT NULL
        CONSTRAINT DF_STG_Description_LookUp_LoadDate
        DEFAULT (GETDATE()),

    CONSTRAINT UQ_STG_Description_LookUp_DescriptionName
        UNIQUE (LookUp_Description_Name)
);


END;
GO

