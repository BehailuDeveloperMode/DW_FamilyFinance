/***************************************************************************************************
Table Name    : dim.DimDescription
Author        : Behailu Tessema
Created Date  : 06/04/2026
Database      : DW_FamilyFinance
Schema        : dim

Purpose:
    Stores standardized transaction descriptions and business classifications
    used to categorize expense transactions within the DW_FamilyFinance
    Data Warehouse.

Grain:
    One row per unique transaction description.

Primary Key:
    DescriptionKey

Business Key:
    DescriptionName

Business Rules:
    1. Each DescriptionName must be unique.
    2. DescriptionKey is a surrogate key generated using an IDENTITY column.
    3. Transaction descriptions are mapped to business categories,
       subcategories, and expense types.
    4. Description classifications are maintained through the lookup
       process originating from STG_Description_LookUp.
    5. A description record must exist before related expense transactions
       can be loaded into fact.FactExpense.
    6. SourceSystem identifies the originating source of the description.

Source Table:
    - STG_FamilyLiving.dbo.STG_Description_LookUp

Used By:
    - fact.FactExpense
    - rpt.vw_ExpenseDetail
    - rpt.vw_MonthlyFinancialSummary
    - Power BI Semantic Model

Business Classification Examples:
    DescriptionName : Costco Annual Membership Renewal
    Category        : Household
    SubCategory     : Membership
    ExpenseType     : Recurring Expense

    DescriptionName : Google Workspace_develope
    Category        : Technology
    SubCategory     : Software Subscription
    ExpenseType     : Business Expense

Notes:
    This dimension serves as the primary business classification dimension
    for expense reporting. It converts raw bank transaction descriptions
    into meaningful business categories, subcategories, and expense types
    for financial analysis and dashboard reporting.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial version.
------------------------------------------------------------------------------------------------***/
USE DW_FamilyFinance;
GO

IF OBJECT_ID('dim.DimDescription', 'U') IS NULL
BEGIN
    CREATE TABLE dim.DimDescription
    (
        DescriptionKey     INT IDENTITY(1,1) NOT NULL,
        DescriptionName    VARCHAR(255) NOT NULL,
        [Description]      VARCHAR(500) NULL,
        Category           VARCHAR(200) NULL,
        SubCategory        VARCHAR(200) NULL,
        ExpenseType        VARCHAR(200) NULL,
        SourceSystem       VARCHAR(100) NOT NULL,
        CreatedDate        DATETIME2(0) NOT NULL
            CONSTRAINT DF_DimDescription_CreatedDate DEFAULT SYSDATETIME(),
        ModifiedDate       DATETIME2(0) NULL,

        CONSTRAINT PK_DimDescription PRIMARY KEY CLUSTERED (DescriptionKey),
        CONSTRAINT UQ_DimDescription_DescriptionName UNIQUE (DescriptionName)
    );
END;
GO