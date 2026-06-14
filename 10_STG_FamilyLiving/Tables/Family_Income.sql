USE [STG_FamilyLiving];


GO
SET ANSI_NULLS ON;


GO
SET QUOTED_IDENTIFIER ON;


GO
/***************************************************************************************************
Table Name   : dbo.Family_Income
Author       : Behailu Tessema
Created Date : 06/05/2026
Database     : STG_FamilyLiving
Schema       : dbo
Project      : DW_FamilyFinance Data Platform

Purpose:
    Stores staged family income and payroll records loaded from source files
    before transformation into DW_FamilyFinance.

Source:
    OneDrive\Family Finance\Income_Statement

Target:
    DW_FamilyFinance.fact.FactIncome

Business Rules:
    1. IncomeSourceID uniquely identifies each staged income record.
    2. One row represents one paycheck for one employee from one workplace.
    3. Period_Bginning, Period_Ending, and Pay_Day represent payroll dates.
    4. Work_Place identifies the employer or income source.
    5. Employee_FullName identifies the employee.
    6. Tax and payment fields use DECIMAL(18,2) for financial accuracy.
    7. Payment_Validation stores the validation result from the source process.

Used By:
    - SSIS income source file load process
    - DW_FamilyFinance.etl.usp_Load_DimIncomeSource
    - DW_FamilyFinance.etl.usp_Load_FactIncome
    - Income reconciliation and audit views

Example:
    SELECT *
    FROM dbo.Family_Income;

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/05/2026   Behailu Tessema     Initial table creation script.
***************************************************************************************************/
IF OBJECT_ID(N'dbo.Family_Income', N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Family_Income (
            IncomeSourceID     BIGINT          IDENTITY (1, 1) NOT NULL,
            Period_Bginning    DATE            NULL,
            Period_Ending      DATE            NULL,
            Pay_Day            DATE            NULL,
            Work_Place         NVARCHAR (255)  NULL,
            Employee_FullName  NVARCHAR (255)  NULL,
            Gross_Payment      DECIMAL (18, 2) NULL,
            Federal_Tax        DECIMAL (18, 2) NULL,
            SS_Tax             DECIMAL (18, 2) NULL,
            Medical_Tax        DECIMAL (18, 2) NULL,
            CA_State_Tax       DECIMAL (18, 2) NULL,
            CA_SDI_Tax         DECIMAL (18, 2) NULL,
            Employer_NetPay    DECIMAL (18, 2) NULL,
            Total_Tax          DECIMAL (18, 2) NULL,
            Payment_Validation DECIMAL (18, 2) NULL,
            CONSTRAINT PK_Family_Income PRIMARY KEY CLUSTERED (IncomeSourceID)
        );
    END