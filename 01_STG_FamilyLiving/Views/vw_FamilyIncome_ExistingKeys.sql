USE STG_FamilyLiving;
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

/****************************************************************************************
 Object Name    : dbo.vw_FamilyIncome_ExistingKeys
 Object Type    : View
 Database       : STG_FamilyLiving
 Project        : DW_FamilyFinance
 Author         : Behailu Tessema
 Created Date   : 2026-09-03
 Version        : 1.0

 Purpose:
     Provides the distinct paycheck business keys already loaded into
     dbo.Family_Income.

     This view is used by the SSIS Lookup transformation in
     IncomeLoad_GoogleSheet.dtsx to support incremental loading.

 Business Rules:
     1. One paycheck is identified using:
          - Period_Bginning
          - Period_Ending
          - Pay_Day
          - Work_Place
          - Employee_FullName

     2. DISTINCT removes duplicate business keys from the Lookup reference data.

     3. Records containing NULL business-key values are excluded.

     4. Work_Place and Employee_FullName are returned as NVARCHAR(255)
        to match the Unicode SSIS input columns.

 Used By:
     SSIS Package   : IncomeLoad_GoogleSheet.dtsx
     Transformation : LKP - Existing Family Income

 Change History:
     Version 1.0 - 2026-09-03 - Initial creation.
****************************************************************************************/

-- Purpose: Create the reusable incremental-load Lookup view.
CREATE OR ALTER VIEW dbo.vw_FamilyIncome_ExistingKeys
AS
    SELECT DISTINCT
        CAST(Period_Bginning AS DATE)              AS Period_Bginning,
        CAST(Period_Ending AS DATE)                AS Period_Ending,
        CAST(Pay_Day AS DATE)                      AS Pay_Day,
        CAST(Work_Place AS NVARCHAR(255))          AS Work_Place,
        CAST(Employee_FullName AS NVARCHAR(255))   AS Employee_FullName
    FROM dbo.Family_Income
    WHERE Period_Bginning IS NOT NULL
      AND Period_Ending IS NOT NULL
      AND Pay_Day IS NOT NULL
      AND Work_Place IS NOT NULL
      AND Employee_FullName IS NOT NULL;
GO

-- Purpose: Verify that the view returns existing distinct paycheck keys.
SELECT *
FROM dbo.vw_FamilyIncome_ExistingKeys;
GO