USE [STG_FamilyLiving];


GO
SET ANSI_NULLS ON;


GO
SET QUOTED_IDENTIFIER ON;


GO
/***************************************************************************************************
View Name    : dbo.vw_FamilyIncomeValidation
Author       : Behailu Tessema
Created Date : 06/05/2026
Database     : STG_FamilyLiving
Schema       : dbo
Project      : DW_FamilyFinance Data Platform

Purpose:
    Validates payroll income rows loaded into dbo.Family_Income by SSIS
    before the records are loaded into DW_FamilyFinance.

Source Tables:
    - STG_FamilyLiving.dbo.Family_Income

Target Tables:
    - DW_FamilyFinance.fact.FactIncome

Validation Rules:
    1. Gross payment must be greater than 0.
    2. Tax amounts cannot be negative.
    3. Total tax should equal the sum of all tax components.
    4. Employer net pay should equal Gross Payment minus Total Tax.
    5. Payment_Validation should equal 1 when source validation passed.

Expected Result:
    ValidationStatus = PASS

Used By:
    - SSIS payroll load validation
    - STG data quality review
    - DW_FamilyFinance income ETL validation
    - Payroll troubleshooting

Example:
    SELECT *
    FROM dbo.vw_FamilyIncomeValidation
    WHERE ValidationStatus <> 'PASS';

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/05/2026   Behailu Tessema     Initial payroll validation view.
***************************************************************************************************/
CREATE OR ALTER VIEW dbo.vw_FamilyIncomeValidation
AS
SELECT Period_Bginning,
       Period_Ending,
       Pay_Day,
       Work_Place,
       Employee_FullName,
       Gross_Payment,
       Federal_Tax,
       SS_Tax,
       Medical_Tax,
       CA_State_Tax,
       CA_SDI_Tax,
       Employer_NetPay,
       Total_Tax,
       Payment_Validation,
       CAST (ISNULL(Federal_Tax, 0.00) + ISNULL(SS_Tax, 0.00) + ISNULL(Medical_Tax, 0.00) + ISNULL(CA_State_Tax, 0.00) + ISNULL(CA_SDI_Tax, 0.00) AS DECIMAL (18, 2)) AS Recalculated_Total_Tax,
       CAST (ISNULL(Gross_Payment, 0.00) - (ISNULL(Federal_Tax, 0.00) + ISNULL(SS_Tax, 0.00) + ISNULL(Medical_Tax, 0.00) + ISNULL(CA_State_Tax, 0.00) + ISNULL(CA_SDI_Tax, 0.00)) AS DECIMAL (18, 2)) AS Recalculated_NetPay,
       CAST (ABS(ISNULL(Total_Tax, 0.00) - (ISNULL(Federal_Tax, 0.00) + ISNULL(SS_Tax, 0.00) + ISNULL(Medical_Tax, 0.00) + ISNULL(CA_State_Tax, 0.00) + ISNULL(CA_SDI_Tax, 0.00))) AS DECIMAL (18, 2)) AS TotalTax_Difference,
       CAST (ABS(ISNULL(Employer_NetPay, 0.00) - (ISNULL(Gross_Payment, 0.00) - (ISNULL(Federal_Tax, 0.00) + ISNULL(SS_Tax, 0.00) + ISNULL(Medical_Tax, 0.00) + ISNULL(CA_State_Tax, 0.00) + ISNULL(CA_SDI_Tax, 0.00)))) AS DECIMAL (18, 2)) AS NetPay_Difference,
       CASE WHEN ISNULL(Gross_Payment, 0.00) <= 0 THEN 'Invalid Gross Payment' WHEN ISNULL(Federal_Tax, 0.00) < 0
                                                                                    OR ISNULL(SS_Tax, 0.00) < 0
                                                                                    OR ISNULL(Medical_Tax, 0.00) < 0
                                                                                    OR ISNULL(CA_State_Tax, 0.00) < 0
                                                                                    OR ISNULL(CA_SDI_Tax, 0.00) < 0 THEN 'Negative Tax Amount' WHEN ABS(ISNULL(Total_Tax, 0.00) - (ISNULL(Federal_Tax, 0.00) + ISNULL(SS_Tax, 0.00) + ISNULL(Medical_Tax, 0.00) + ISNULL(CA_State_Tax, 0.00) + ISNULL(CA_SDI_Tax, 0.00))) > 0.01 THEN 'Total Tax Mismatch' WHEN ABS(ISNULL(Employer_NetPay, 0.00) - (ISNULL(Gross_Payment, 0.00) - (ISNULL(Federal_Tax, 0.00) + ISNULL(SS_Tax, 0.00) + ISNULL(Medical_Tax, 0.00) + ISNULL(CA_State_Tax, 0.00) + ISNULL(CA_SDI_Tax, 0.00)))) > 0.01 THEN 'Net Pay Mismatch' WHEN ISNULL(Payment_Validation, 0) <> 1 THEN 'Payment Validation Flag Not Passed' ELSE 'PASS' END AS ValidationStatus
FROM   dbo.Family_Income;