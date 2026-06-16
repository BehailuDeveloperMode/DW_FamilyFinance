/***************************************************************************************************
Script Name   : Create Fact Schema
Author        : Behailu Tessema
Created Date  : 06/04/2026
Database      : DW_FamilyFinance
Schema        : fact

Purpose:
    Creates the fact schema used to store transactional and measurable
    business data within the DW_FamilyFinance Data Warehouse.

Business Rules:
    1. Verify whether the fact schema already exists.
    2. Create the schema only when it does not exist.
    3. Prevent duplicate schema creation errors.
    4. Support repeatable and idempotent deployment executions.

Objects Stored in Schema:
    - fact.FactExpense
    - fact.FactIncome
    - Additional fact tables as required

Notes:
    The fact schema contains quantitative business measures and foreign
    keys that link to dimension tables. These tables serve as the primary
    source for analytical reporting, dashboards, and Power BI models.

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
    WHERE name = 'fact'
)
BEGIN
    EXEC ('CREATE SCHEMA fact');
END;
GO