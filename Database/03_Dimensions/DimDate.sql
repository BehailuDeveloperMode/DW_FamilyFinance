/***************************************************************************************************
Table Name    : dim.DimDate
Author        : Behailu Tessema
Created Date  : 06/04/2026
Database      : DW_FamilyFinance
Schema        : dim

Purpose:
    Stores a single record for each calendar date and provides standard
    date attributes used for reporting, analysis, filtering, grouping,
    and time intelligence calculations throughout the DW_FamilyFinance
    Data Warehouse.

Grain:
    One row per calendar date.

Primary Key:
    DateKey (YYYYMMDD format)

Business Rules:
    1. Each calendar date must be unique.
    2. DateKey is stored as an integer in YYYYMMDD format.
    3. FullDate must be unique.
    4. Supports Year, Quarter, Month, Week, and Day level reporting.
    5. IsWeekend identifies Saturday and Sunday dates.
    6. Used as a conformed dimension by all fact tables.

Used By:
    - fact.FactExpense
    - fact.FactIncome
    - Power BI Semantic Model
    - Reporting Views

Example:
    DateKey         : 20260604
    FullDate        : 2026-06-04
    Year            : 2026
    QuarterNumber   : 2
    MonthNumber     : 6
    MonthName       : June

Notes:
    This dimension serves as the enterprise calendar table for the
    DW_FamilyFinance Data Warehouse and supports Power BI time
    intelligence functions such as YTD, MTD, QTD, and Prior Year analysis.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial version.
------------------------------------------------------------------------------------------------***/
USE DW_FamilyFinance;
GO

IF OBJECT_ID('dim.DimDate', 'U') IS NULL
BEGIN
    CREATE TABLE dim.DimDate
    (
        DateKey             INT          NOT NULL,
        FullDate            DATE         NOT NULL,
        [Year]              INT          NOT NULL,
        QuarterNumber       INT          NOT NULL,
        MonthNumber         INT          NOT NULL,
        MonthName           VARCHAR(20)  NOT NULL,
        MonthShortName      VARCHAR(3)   NOT NULL,
        YearMonthNumber     INT          NOT NULL,
        YearMonthName       VARCHAR(20)  NOT NULL,
        DayOfMonth          INT          NOT NULL,
        DayOfWeekNumber     INT          NOT NULL,
        DayOfWeekName       VARCHAR(20)  NOT NULL,
        WeekOfYear          INT          NOT NULL,
        IsWeekend           BIT          NOT NULL,
        CreatedDate         DATETIME2(0) NOT NULL
            CONSTRAINT DF_DimDate_CreatedDate DEFAULT SYSDATETIME(),
        ModifiedDate        DATETIME2(0) NULL,

        CONSTRAINT PK_DimDate PRIMARY KEY CLUSTERED (DateKey),
        CONSTRAINT UQ_DimDate_FullDate UNIQUE (FullDate)
    );
END;
GO