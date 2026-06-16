USE [DW_FamilyFinance];


GO
SET ANSI_NULLS ON;


GO
SET QUOTED_IDENTIFIER ON;


GO
/***************************************************************************************************
View Name    : rpt.vw_IncomeDetail
Author       : Behailu Tessema
Created Date : 06/04/2026
Database     : DW_FamilyFinance
Schema       : rpt
Project      : DW_FamilyFinance Data Warehouse

Purpose:
    Provides detailed, business-readable payroll income information by joining
    fact.FactIncome with income source and date dimensions.

Source Objects:
    - fact.FactIncome
    - dim.DimIncomeSource
    - dim.DimDate

Grain:
    One row represents one paycheck issued to one employee from one workplace.

Business Rules:
    1. SourceIncomeID supports source-to-warehouse traceability.
    2. EmployeeFullName and WorkPlace come from dim.DimIncomeSource.
    3. PeriodBeginningDate represents the payroll period start date.
    4. PeriodEndingDate represents the payroll period end date.
    5. PayDate represents the actual paycheck date.
    6. PayDate is the primary reporting date for income reporting.
    7. GrossPayment stores total gross earnings before taxes.
    8. TotalTax stores total payroll tax amount.
    9. EmployerNetPay stores final take-home pay received.
   10. PaymentValidation stores the payroll validation result from staging.

Date Roles:
    - PeriodBeginningDateKey -> dim.DimDate
    - PeriodEndingDateKey    -> dim.DimDate
    - PayDateKey             -> dim.DimDate

Used By:
    - SQL reporting
    - Payroll validation
    - Income troubleshooting
    - Reconciliation review
    - Optional Power BI quick reporting

Power BI Recommendation:
    Enterprise Power BI models should use the underlying star schema
    tables directly. This view is intended primarily for SQL-based
    validation, payroll review, and troubleshooting.

Example:
    SELECT *
    FROM rpt.vw_IncomeDetail;

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/04/2026   Behailu Tessema     Initial income detail reporting view.
------------------------------------------------------------------------------------------------***/
CREATE OR ALTER VIEW [rpt].[vw_IncomeDetail]
AS
SELECT f.IncomeFactKey,
       f.SourceIncomeID,
       ds.EmployeeFullName,
       ds.WorkPlace,
       pb.FullDate AS PeriodBeginningDate,
       pe.FullDate AS PeriodEndingDate,
       pd.FullDate AS PayDate,
       pd.[Year],
       pd.YearMonthNumber,
       pd.YearMonthName,
       f.GrossPayment,
       f.FederalTax,
       f.SSTax,
       f.MedicareTax,
       f.CAStateTax,
       f.CASDITax,
       f.TotalTax,
       f.EmployerNetPay,
       f.PaymentValidation,
       f.SourceSystem,
       f.CreatedDate
FROM   fact.FactIncome AS f
       INNER JOIN
       dim.DimIncomeSource AS ds
       ON ds.IncomeSourceKey = f.IncomeSourceKey
       INNER JOIN
       dim.DimDate AS pb
       ON pb.DateKey = f.PeriodBeginningDateKey
       INNER JOIN
       dim.DimDate AS pe
       ON pe.DateKey = f.PeriodEndingDateKey
       INNER JOIN
       dim.DimDate AS pd
       ON pd.DateKey = f.PayDateKey;