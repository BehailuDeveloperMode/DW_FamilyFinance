/***************************************************************************************************
Script Name   : Create Reporting Schema
Author        : Behailu Tessema
Created Date  : 06/04/2026
Database      : DW_FamilyFinance
Schema        : rpt

Purpose:
    Creates the reporting schema used to store reporting views that provide
    business-friendly access to data within the DW_FamilyFinance Data Warehouse.

Business Rules:
    1. Verify whether the rpt schema already exists.
    2. Create the schema only when it does not exist.
    3. Prevent duplicate schema creation errors.
    4. Support repeatable and idempotent deployment executions.

Objects Stored in Schema:
    - rpt.vw_ExpenseDetail
    - rpt.vw_IncomeDetail
    - rpt.vw_MonthlyFinancialSummary
    - rpt.vw_ExpenseRecordCountByYearBank
    - rpt.vw_ExpenseAudit
    - rpt.vw_ExpenseReconciliation
    - Additional reporting views as required

Notes:
    The rpt schema contains presentation-layer views designed for
    reporting, dashboards, ad hoc analysis, and Power BI consumption.
    These views simplify access to dimensional and fact data while
    applying business-friendly naming conventions and calculations.

Benefits:
    - Separates reporting logic from ETL processes.
    - Provides a stable interface for BI tools.
    - Simplifies report development and maintenance.
    - Supports enterprise reporting standards.

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
    WHERE name = 'rpt'
)
BEGIN
    EXEC ('CREATE SCHEMA rpt');
END;
GO