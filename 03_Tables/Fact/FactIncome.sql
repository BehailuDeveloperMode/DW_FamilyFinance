/***************************************************************************************************
Table Name    : fact.FactIncome
Author        : Behailu Tessema
Created Date  : 06/04/2026
Database      : DW_FamilyFinance
Schema        : fact

Purpose:
    Stores payroll and income transaction facts for employees and workplaces
    within the DW_FamilyFinance Data Warehouse. This table captures gross pay,
    taxes, net pay, source income identifiers, and payroll validation metrics
    for financial reporting and income analysis.

Grain:
    One row per employee paycheck.

Primary Key:
    IncomeFactKey

Business Key:
    SourceIncomeID

Foreign Keys:
    IncomeSourceKey         -> dim.DimIncomeSource.IncomeSourceKey
    PeriodBeginningDateKey  -> dim.DimDate.DateKey
    PeriodEndingDateKey     -> dim.DimDate.DateKey
    PayDateKey              -> dim.DimDate.DateKey

Business Rules:
    1. Each row represents a single paycheck transaction.
    2. Each SourceIncomeID must be unique.
    3. IncomeFactKey is a surrogate key generated using an IDENTITY column.
    4. SourceIncomeID stores the original income record identifier from staging.
    5. IncomeSourceKey must exist in dim.DimIncomeSource.
    6. PeriodBeginningDateKey must exist in dim.DimDate.
    7. PeriodEndingDateKey must exist in dim.DimDate.
    8. PayDateKey must exist in dim.DimDate.
    9. GrossPayment stores total earnings before taxes and deductions.
   10. EmployerNetPay stores the actual net payment received.
   11. TotalTax stores the combined tax amount deducted from payroll.
   12. PaymentValidation indicates whether payroll calculations passed
       validation checks.
   13. SourceSystem identifies the originating payroll provider or source.

Source Table:
    - STG_FamilyLiving.dbo.Family_Income

Measures:
    - GrossPayment
    - FederalTax
    - SSTax
    - MedicareTax
    - CAStateTax
    - CASDITax
    - EmployerNetPay
    - TotalTax

Used By:
    - rpt.vw_IncomeDetail
    - rpt.vw_MonthlyFinancialSummary
    - Power BI Semantic Model
    - Income and Tax Analysis Reports

Payroll Validation Rule:
    GrossPayment = EmployerNetPay + TotalTax

Example:
    SourceIncomeID : 1001
    Employee       : Behailu Tessema
    WorkPlace      : CITIGUARD INC
    GrossPayment   : 1,965.23
    TotalTax       : 243.44
    EmployerNetPay : 1,721.79
    Validation     : PASS

Notes:
    This fact table serves as the central repository for income and payroll
    transactions. It supports analysis by employee, workplace, pay period,
    tax type, payment date, and source income record. SourceIncomeID improves
    ETL auditing, duplicate prevention, reconciliation, and source-to-warehouse
    traceability.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial version with SourceIncomeID business key.
------------------------------------------------------------------------------------------------***/
USE DW_FamilyFinance;


GO
IF OBJECT_ID('fact.FactIncome', 'U') IS NULL
    BEGIN
        CREATE TABLE fact.FactIncome (
            IncomeFactKey          BIGINT          IDENTITY (1, 1) NOT NULL,
            SourceIncomeID         BIGINT          NOT NULL,
            IncomeSourceKey        INT             NOT NULL,
            PeriodBeginningDateKey INT             NOT NULL,
            PeriodEndingDateKey    INT             NOT NULL,
            PayDateKey             INT             NOT NULL,
            GrossPayment           DECIMAL (18, 2) NOT NULL,
            FederalTax             DECIMAL (18, 2) NOT NULL,
            SSTax                  DECIMAL (18, 2) NOT NULL,
            MedicareTax            DECIMAL (18, 2) NOT NULL,
            CAStateTax             DECIMAL (18, 2) NOT NULL,
            CASDITax               DECIMAL (18, 2) NOT NULL,
            EmployerNetPay         DECIMAL (18, 2) NOT NULL,
            TotalTax               DECIMAL (18, 2) NOT NULL,
            PaymentValidation      BIT             NOT NULL,
            SourceSystem           VARCHAR (100)   NOT NULL,
            CreatedDate            DATETIME2 (0)   CONSTRAINT DF_FactIncome_CreatedDate DEFAULT SYSDATETIME() NOT NULL,
            ModifiedDate           DATETIME2 (0)   NULL,
            CONSTRAINT PK_FactIncome PRIMARY KEY CLUSTERED (IncomeFactKey),
            CONSTRAINT UQ_FactIncome_SourceIncomeID UNIQUE (SourceIncomeID),
            CONSTRAINT FK_FactIncome_DimIncomeSource FOREIGN KEY (IncomeSourceKey) REFERENCES dim.DimIncomeSource (IncomeSourceKey),
            CONSTRAINT FK_FactIncome_PeriodBeginningDate FOREIGN KEY (PeriodBeginningDateKey) REFERENCES dim.DimDate (DateKey),
            CONSTRAINT FK_FactIncome_PeriodEndingDate FOREIGN KEY (PeriodEndingDateKey) REFERENCES dim.DimDate (DateKey),
            CONSTRAINT FK_FactIncome_PayDate FOREIGN KEY (PayDateKey) REFERENCES dim.DimDate (DateKey)
        );
    END