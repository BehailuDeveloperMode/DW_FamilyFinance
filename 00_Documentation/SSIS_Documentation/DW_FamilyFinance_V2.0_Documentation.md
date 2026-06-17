DW\_FamilyFinance – Data Warehouse Documentation

Project Information



Project Name: DW\_FamilyFinance



Version: 1.0



Author: Behailu Tessema



Technology Stack:



SQL Server 2022

SSIS

Power BI

Visual Studio 2022

Git \& GitHub

Project Overview



DW\_FamilyFinance is an enterprise-style SQL Server Data Warehouse designed to centralize, organize, and analyze family income and expense data.



The solution follows a layered architecture consisting of:



Source Files

&#x20;     │

&#x20;     ▼

STG\_FamilyLiving

&#x20;     │

&#x20;     ▼

DW\_FamilyFinance

&#x20;     │

&#x20;     ▼

Power BI



The system automates data ingestion, transformation, dimensional modeling, auditing, and reporting.



Data Warehouse Architecture

Database

DW\_FamilyFinance

Schemas

Dimension Schema

dim



Contains descriptive business entities used for reporting and analysis.



Fact Schema

fact



Contains measurable business transactions.



ETL Schema

etl



Contains data warehouse loading procedures.



Reporting Schema

rpt



Contains reporting and analytical views.



Dimension Tables

dim.DimDate

Purpose



Provides calendar and time intelligence support for reporting and analytics.



Key Columns

Column	Description

DateKey	YYYYMMDD surrogate key

Date	Calendar date

Year	Calendar year

Month	Month number

Day	Day of month

YearMonthNumber	YYYYMM

YearMonthName	Month and Year

Current Row Count

7,671



Date Range:



2020-01-01 through 2040-12-31

dim.DimBank

Purpose



Stores financial institutions associated with expense transactions.



Current Row Count

3



Examples:



Citi Bank

Wells Fargo

Unknown

dim.DimDescription

Purpose



Stores standardized expense descriptions and classification rules.



Current Row Count

941



Key Columns:



DescriptionKey

LookUp\_Description\_Name

LookUp\_Description

LookUp\_SubCategory

LookUp\_ExpenseType

LookUp\_Category

dim.DimIncomeSource

Purpose



Stores employer and income source information.



Current Row Count

5



Examples:



Casa Coloma

Windsor El Camino

CITIGUARD INC

Fact Tables

fact.FactExpense

Purpose



Stores individual expense transactions.



Grain



One row per source expense transaction.



Current Row Count

5,887

Key Columns

Column	Description

ExpenseFactKey	Surrogate Key

SourceExpenseID	Source Transaction Identifier

TransactionDateKey	Date Dimension Key

BankKey	Bank Dimension Key

DescriptionKey	Description Dimension Key

ExpenseAmount	Transaction Amount

LoadDate	DW Load Date

fact.FactIncome

Purpose



Stores payroll and income transactions.



Grain



One row per paycheck.



Current Row Count

230

Key Columns

Column	Description

IncomeFactKey	Surrogate Key

SourceIncomeID	Source Identifier

PayDateKey	Date Dimension Key

IncomeSourceKey	Employer Key

GrossPayment	Gross Income

EmployerNetPay	Net Income

TotalTax	Total Taxes

Work\_Place	Employer

Employee\_FullName	Employee Name

ETL Procedures

Dimension Loads

etl.usp\_Load\_DimDate

etl.usp\_Load\_DimBank

etl.usp\_Load\_DimDescription

etl.usp\_Load\_DimIncomeSource

Purpose



Load and maintain dimension tables.



Fact Loads

etl.usp\_Load\_FactExpense

etl.usp\_Load\_FactIncome

Purpose



Load transactional data from staging into fact tables.



Data Sources

Expense Sources

Citi Bank

Wells Fargo

Income Sources

Payroll Excel Files

Google Sheet Exports

Description Source

Expense Classification Lookup Spreadsheet

Data Flow

Expense Files

&#x20;     │

&#x20;     ▼

STG\_FamilySourceData

&#x20;     │

&#x20;     ▼

DimBank

DimDescription

DimDate

&#x20;     │

&#x20;     ▼

FactExpense

Income File

&#x20;     │

&#x20;     ▼

Family\_Income

&#x20;     │

&#x20;     ▼

DimIncomeSource

DimDate

&#x20;     │

&#x20;     ▼

FactIncome

Reporting Layer

Available Views

rpt.vw\_ExpenseDetail



Detailed expense transactions.



rpt.vw\_IncomeDetail



Detailed income transactions.



rpt.vw\_MonthlyFinancialSummary



Monthly financial summary including:



Total Income

Total Expense

Net Savings

Validation Results

Table	Rows

DimDate	7,671

DimBank	3

DimDescription	941

DimIncomeSource	5

FactExpense	5,887

FactIncome	230



Validation Status:



PASS



No orphan records detected.



No duplicate fact records detected.



Project Status

DW\_FamilyFinance Version 1.0

Completed

Staging Layer

Incremental Loading Framework

Audit Framework

Dimension Tables

Fact Tables

ETL Procedures

Reporting Views

SSIS Automation

Power BI Integration Ready

Next Phase

Power BI Dashboard Development

KPI Reporting

Financial Trend Analysis

Budget vs Actual Reporting

Author



Behailu Tessema



Data Engineer | BI Developer | SQL Server Developer



GitHub:

https://github.com/BehailuDeveloperMode



Website:

https://www.developermode.dev

