/***************************************************************************************************
Table Name    : fact.FactExpense
Author        : Behailu Tessema
Created Date  : 06/04/2026
Database      : DW_FamilyFinance
Schema        : fact

Purpose:
    Stores expense transaction facts loaded from family finance staging
    data. This table captures measurable expense amounts and connects each
    transaction to date, bank, and description dimensions for reporting.

Grain:
    One row per source expense transaction.

Primary Key:
    ExpenseFactKey

Business Key:
    SourceExpenseID

Foreign Keys:
    TransactionDateKey -> dim.DimDate.DateKey
    BankKey            -> dim.DimBank.BankKey
    DescriptionKey     -> dim.DimDescription.DescriptionKey

Business Rules:
    1. Each SourceExpenseID must be unique.
    2. ExpenseFactKey is a surrogate key generated using an IDENTITY column.
    3. TransactionDateKey must exist in dim.DimDate.
    4. BankKey must exist in dim.DimBank.
    5. DescriptionKey must exist in dim.DimDescription.
    6. ExpenseAmount stores the finalized expense amount used for reporting.
    7. LoadDate represents the reporting load date assigned from staging.
    8. SourceSystem identifies the originating bank or source system.
    9. TransactionID is optional and may be used for tracing or auditing.

Source Table:
    - STG_FamilyLiving.dbo.STG_FamilySourceData

Used By:
    - rpt.vw_ExpenseDetail
    - rpt.vw_MonthlyFinancialSummary
    - rpt.vw_ExpenseRecordCountByYearBank
    - rpt.vw_ExpenseAudit
    - rpt.vw_ExpenseReconciliation
    - Power BI Semantic Model

Notes:
    This fact table is the central expense transaction table for the
    DW_FamilyFinance Data Warehouse. It supports expense analysis by date,
    bank, category, subcategory, expense type, and source system.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial version.
------------------------------------------------------------------------------------------------***/
USE DW_FamilyFinance;
GO

IF OBJECT_ID('fact.FactExpense', 'U') IS NULL
BEGIN
    CREATE TABLE fact.FactExpense
    (
        ExpenseFactKey        BIGINT IDENTITY(1,1) NOT NULL,
        SourceExpenseID       BIGINT NOT NULL,
        TransactionID         VARCHAR(500) NULL,
        TransactionDateKey    INT NOT NULL,
        BankKey               INT NOT NULL,
        DescriptionKey        INT NOT NULL,
        ExpenseAmount         DECIMAL(18,2) NOT NULL,
        LoadDate              DATE NULL,
        SourceSystem          VARCHAR(100) NOT NULL,
        CreatedDate           DATETIME2(0) NOT NULL
            CONSTRAINT DF_FactExpense_CreatedDate DEFAULT SYSDATETIME(),
        ModifiedDate          DATETIME2(0) NULL,

        CONSTRAINT PK_FactExpense PRIMARY KEY CLUSTERED (ExpenseFactKey),
        CONSTRAINT UQ_FactExpense_SourceExpenseID UNIQUE (SourceExpenseID),

        CONSTRAINT FK_FactExpense_DimDate
            FOREIGN KEY (TransactionDateKey)
            REFERENCES dim.DimDate(DateKey),

        CONSTRAINT FK_FactExpense_DimBank
            FOREIGN KEY (BankKey)
            REFERENCES dim.DimBank(BankKey),

        CONSTRAINT FK_FactExpense_DimDescription
            FOREIGN KEY (DescriptionKey)
            REFERENCES dim.DimDescription(DescriptionKey)
    );
END;
GO