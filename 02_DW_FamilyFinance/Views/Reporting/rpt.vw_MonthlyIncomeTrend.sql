/*************************************************************************************************
Object Name: rpt.vw_MonthlyIncomeTrend
Created By : Behailu Tessema
Project    : DW_FamilyFinance
Purpose    : Provides monthly income trends for payroll and financial reporting.

Description:
    - Summarizes income by month and year.
    - Uses DimDate for calendar attributes.
    - Returns gross income, net income, taxes, and paycheck counts.
    - Supports income trend analysis and Power BI reporting.

Source Tables:
    - fact.FactIncome
    - dim.DimDate

Business Rules:
    - TotalGrossIncome is calculated from GrossPayment.
    - TotalNetIncome is calculated from EmployerNetPay.
    - TotalTax is calculated from TotalTax.
    - PaycheckCount represents the number of income records.
    - Data is grouped by Year and YearMonthNumber.

Example Usage:
    SELECT *
    FROM rpt.vw_MonthlyIncomeTrend
    ORDER BY Year, YearMonthNumber;

*************************************************************************************************/
USE DW_FamilyFinance;
GO

CREATE OR ALTER VIEW rpt.vw_MonthlyIncomeTrend
AS
SELECT
      d.Year
    , d.YearMonthNumber
    , d.YearMonthName
    , SUM(f.GrossPayment) AS TotalGrossIncome
    , SUM(f.EmployerNetPay) AS TotalNetIncome
    , SUM(f.TotalTax) AS TotalTax
    , COUNT(*) AS PaycheckCount
FROM fact.FactIncome AS f
INNER JOIN dim.DimDate AS d
    ON f.PayDateKey = d.DateKey
GROUP BY
      d.Year
    , d.YearMonthNumber
    , d.YearMonthName;
GO