/***************************************************************************************************
Script Name   : Create Dimensional Schema
Author        : Behailu Tessema
Created Date  : 06/04/2026
Database      : DW_FamilyFinance
Schema        : dim

Purpose:
    Creates the dimensional schema (dim) used to store dimension tables
    within the DW_FamilyFinance Data Warehouse.

Business Rules:
    1. Verify whether the dim schema already exists.
    2. Create the schema only when it does not exist.
    3. Prevent duplicate schema creation errors.
    4. Support repeatable and idempotent deployment executions.

Objects Stored in Schema:
    - dim.DimDate
    - dim.DimBank
    - dim.DimDescription
    - dim.DimIncomeSource
    - Additional dimension tables as required

Notes:
    The dim schema contains descriptive business entities that provide
    context for fact tables and support Star Schema design principles.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial version.
------------------------------------------------------------------------------------------------***/
USE DW_FamilyFinance;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = 'dim'
)
BEGIN
    EXEC ('CREATE SCHEMA dim');
END;
GO