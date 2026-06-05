/***************************************************************************************************
Script Name   : Create ETL Schema
Author        : Behailu Tessema
Created Date  : 06/04/2026
Database      : DW_FamilyFinance
Schema        : etl

Purpose:
    Creates the ETL schema used to store Extract, Transform, and Load (ETL)
    stored procedures responsible for populating and maintaining the
    DW_FamilyFinance Data Warehouse.

Business Rules:
    1. Verify whether the etl schema already exists.
    2. Create the schema only when it does not exist.
    3. Prevent duplicate schema creation errors.
    4. Support repeatable and idempotent deployment executions.

Objects Stored in Schema:
    - etl.usp_Load_DimDate
    - etl.usp_Load_DimBank
    - etl.usp_Load_DimDescription
    - etl.usp_Load_DimIncomeSource
    - etl.usp_Load_FactExpense
    - etl.usp_Load_FactIncome
    - etl.usp_Load_DW_FamilyFinance
    - Additional ETL procedures as required

Notes:
    The etl schema contains all data loading, transformation, validation,
    and orchestration procedures used to move data from staging sources
    into dimension and fact tables within the DW_FamilyFinance Data Warehouse.

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
    WHERE name = 'etl'
)
BEGIN
    EXEC ('CREATE SCHEMA etl');
END;
GO