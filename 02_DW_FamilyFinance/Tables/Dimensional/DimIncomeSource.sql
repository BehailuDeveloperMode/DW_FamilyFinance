/***************************************************************************************************
Table Name    : dim.DimIncomeSource
Author        : Behailu Tessema
Created Date  : 06/04/2026
Database      : DW_FamilyFinance
Schema        : dim

Purpose:
    Stores employee and workplace information associated with income
    transactions within the DW_FamilyFinance Data Warehouse.

Grain:
    One row per unique Employee and Workplace combination.

Primary Key:
    IncomeSourceKey

Business Key:
    WorkPlace + EmployeeFullName

Business Rules:
    1. Each Employee and Workplace combination must be unique.
    2. IncomeSourceKey is a surrogate key generated using an IDENTITY column.
    3. An employee may work at multiple workplaces.
    4. A workplace may have multiple employees.
    5. SourceSystem identifies the originating payroll or income source.
    6. An Income Source record must exist before related income transactions
       can be loaded into fact.FactIncome.
    7. Supports referential integrity between income dimensions and fact data.

Source Table:
    - STG_FamilyLiving.dbo.Family_Income

Used By:
    - fact.FactIncome
    - rpt.vw_IncomeDetail
    - rpt.vw_MonthlyFinancialSummary
    - Power BI Semantic Model

Expected Values:

    WorkPlace:
        - Casa Coloma
        - Windsor El Camino
        - CITIGUARD INC

    EmployeeFullName:
        - Behailu Tessema
        - Mignote Tumoro

Notes:
    This dimension centralizes income source information and provides
    consistent employee and workplace references across all income-related
    reporting and analytics. It enables reporting by employer, employee,
    and income source while reducing redundancy within fact tables.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial version.
------------------------------------------------------------------------------------------------***/
USE DW_FamilyFinance;


GO
IF OBJECT_ID('dim.DimIncomeSource', 'U') IS NULL
    BEGIN
        CREATE TABLE dim.DimIncomeSource (
            IncomeSourceKey  INT           IDENTITY (1, 1) NOT NULL,
            WorkPlace        VARCHAR (150) NOT NULL,
            EmployeeFullName VARCHAR (150) NOT NULL,
            SourceSystem     VARCHAR (100) NOT NULL,
            CreatedDate      DATETIME2 (0) CONSTRAINT DF_DimIncomeSource_CreatedDate DEFAULT SYSDATETIME() NOT NULL,
            ModifiedDate     DATETIME2 (0) NULL,
            CONSTRAINT PK_DimIncomeSource PRIMARY KEY CLUSTERED (IncomeSourceKey),
            CONSTRAINT UQ_DimIncomeSource_WorkPlace_Employee UNIQUE (WorkPlace, EmployeeFullName)
        );
    END