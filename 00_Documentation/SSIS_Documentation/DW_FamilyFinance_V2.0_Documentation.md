# DW_FamilyFinance – Enterprise Data Warehouse & Business Intelligence Platform

## Project Information

**Project Name:** DW_FamilyFinance

**Current Version:** 2.0

**Author:** Behailu Tessema

**Website:** https://www.developermode.dev

**GitHub:** https://github.com/BehailuDeveloperMode

---

# Project Overview

DW_FamilyFinance is an enterprise-style SQL Server Data Warehouse and Business Intelligence solution designed to centralize, organize, analyze, and visualize family income and expense data.

The project automates the collection of financial transactions from multiple sources, applies data quality and transformation rules, loads data into a dimensional warehouse model, and provides analytical reporting through Power BI dashboards.

The solution demonstrates real-world Data Engineering, ETL Development, Data Warehousing, SQL Server Development, Business Intelligence, and Data Modeling practices.

---

# Solution Architecture

```text
Source Files (Excel / Google Sheets)
                │
                ▼
       STG_FamilyLiving
                │
                ▼
       DW_FamilyFinance
                │
                ▼
           Power BI
```

---

# Technology Stack

### Database

* SQL Server 2022

### ETL

* SQL Server Integration Services (SSIS)

### Reporting & Analytics

* Power BI

### Development Tools

* Visual Studio 2022
* SQL Server Management Studio (SSMS)
* Git
* GitHub

---

# Project Versions

## Version 1.0 – Data Warehouse Foundation

### Completed Components

* Staging Environment
* Incremental ETL Framework
* Audit Framework
* Dimension Tables
* Fact Tables
* ETL Stored Procedures
* SSIS Automation
* Validation Framework
* Maintenance Framework

### Deliverables

* STG_FamilyLiving
* DW_FamilyFinance
* ETL Procedures
* SSIS Packages
* Maintenance Scripts
* Data Validation Scripts

---

## Version 2.0 – Reporting & Business Intelligence

### Completed Components

* Reporting Views
* Power BI Semantic Model
* KPI Development
* Dashboard Design Framework
* Portfolio Documentation
* GitHub Documentation

### Deliverables

* Reporting Views
* Power BI Data Model
* Executive Dashboard
* Financial Analytics
* Portfolio Assets

---

# Database Architecture

## Database

```text
DW_FamilyFinance
```

## Schemas

### dim

Contains descriptive business entities used for reporting and analytics.

### fact

Contains measurable business transactions.

### etl

Contains warehouse loading procedures.

### rpt

Contains reporting and analytical views.

---

# Dimension Tables

## dim.DimDate

### Purpose

Provides calendar and time intelligence support for reporting and analytics.

### Date Range

```text
2020-01-01 through 2040-12-31
```

### Current Row Count

```text
7,671
```

### Key Columns

* DateKey
* FullDate
* Year
* QuarterNumber
* MonthNumber
* MonthName
* YearMonthNumber
* YearMonthName
* DayOfMonth
* DayOfWeekName
* WeekOfYear

---

## dim.DimBank

### Purpose

Stores financial institutions associated with expense transactions.

### Current Row Count

```text
2
```

### Values

* Citi Bank
* Wells Fargo Bank

---

## dim.DimDescription

### Purpose

Stores standardized expense classifications.

### Current Row Count

```text
941
```

### Key Columns

* DescriptionKey
* DescriptionName
* Description
* Category
* SubCategory
* ExpenseType

---

## dim.DimIncomeSource

### Purpose

Stores employer and employee information.

### Current Row Count

```text
5
```

### Examples

* Casa Coloma
* Windsor El Camino
* CITIGUARD INC

---

# Fact Tables

## fact.FactExpense

### Purpose

Stores individual expense transactions.

### Grain

One row per expense transaction.

### Current Row Count

```text
5,887
```

### Key Columns

* ExpenseFactKey
* SourceExpenseID
* TransactionDateKey
* BankKey
* DescriptionKey
* ExpenseAmount

---

## fact.FactIncome

### Purpose

Stores payroll and income transactions.

### Grain

One row per paycheck.

### Current Row Count

```text
230
```

### Key Columns

* IncomeFactKey
* SourceIncomeID
* IncomeSourceKey
* PayDateKey
* GrossPayment
* EmployerNetPay
* TotalTax

---

# Staging Environment

## Database

```text
STG_FamilyLiving
```

### Core Tables

* STG_FamilySourceData
* Family_Income
* STG_Description_LookUp

### Audit Tables

* STG_FileLoadAudit
* STG_IncomeLoadAudit
* STG_DescriptionLoadAudit

### Features

* Incremental Loading
* Audit Logging
* Dynamic File Processing
* File Metadata Tracking
* Data Validation
* Duplicate Prevention

---

# SSIS Framework

## STG_LoadDescriptionData

Features:

* Incremental Description Loading
* Duplicate Prevention
* Audit Tracking

## STG_LoadIncomeData

Features:

* Incremental Pay_Day Loading
* Max Date Tracking
* Audit Logging

## STG_LoadExpenseData

Features:

* Dynamic File Processing
* FileModifiedDate Incremental Logic
* Metadata Extraction
* Audit Tracking

## STG_Master_Incremental

Execution Order:

```text
STG_LoadDescriptionData
        ↓
STG_LoadIncomeData
        ↓
STG_LoadExpenseData
```

## DW_Initial_Setup

Purpose:

```text
DimDate One-Time Load
```

## DW_Load_FamilyFinance

Execution Order:

```text
DimBank
        ↓
DimDescription
        ↓
DimIncomeSource
        ↓
FactExpense
        ↓
FactIncome
```

---

# ETL Procedures

## Dimension Loads

```sql
etl.usp_Load_DimDate
etl.usp_Load_DimBank
etl.usp_Load_DimDescription
etl.usp_Load_DimIncomeSource
```

## Fact Loads

```sql
etl.usp_Load_FactExpense
etl.usp_Load_FactIncome
```

## DW Wrapper Procedure

```sql
etl.usp_Load_DW_FamilyFinance
```

---

# Reporting Layer

## Detail Views

```sql
rpt.vw_ExpenseDetail
rpt.vw_IncomeDetail
```

## Summary Views

```sql
rpt.vw_MonthlyFinancialSummary
rpt.vw_ExpenseByCategory
rpt.vw_ExpenseByBank
rpt.vw_MonthlyExpenseTrend
rpt.vw_MonthlyIncomeTrend
```

---

# Data Quality & Governance

### Audit Framework

Tracks:

* File Loads
* Income Loads
* Description Loads

### Validation Framework

Checks:

* Duplicate Records
* Orphan Records
* Missing Date Keys
* Row Count Reconciliation
* Fact-to-Dimension Integrity

### Maintenance Framework

```text
Maintenance/
└── Clean_DW_Data_And_Reload.sql
```

Supports:

* Fact Cleanup
* Dimension Cleanup
* Identity Reseeding
* Full Warehouse Reload
* Validation Testing

---

# Power BI Semantic Model

### Dimensions

* DimDate
* DimBank
* DimDescription
* DimIncomeSource

### Facts

* FactExpense
* FactIncome

### Relationships

```text
DimDate
    ├── FactExpense
    └── FactIncome

DimBank
    └── FactExpense

DimDescription
    └── FactExpense

DimIncomeSource
    └── FactIncome
```

---

# Key Performance Indicators (KPIs)

* Total Income
* Total Expense
* Net Savings
* Expense Transactions
* Income Transactions
* Monthly Income Trend
* Monthly Expense Trend
* Expense by Category
* Expense by Bank

---

# Power BI Dashboard Roadmap

### Executive Summary

* Total Income
* Total Expense
* Net Savings
* Transaction Count

### Expense Analysis

* Expense by Category
* Expense by SubCategory
* Expense by Bank
* Top Expenses

### Income Analysis

* Income by Employer
* Gross Income Trend
* Net Income Trend
* Tax Analysis

### Savings Analysis

* Monthly Savings
* Income vs Expense
* Savings Trend

---

# Project Achievements

### Data Engineering

* ETL Development
* Incremental Loading
* Data Validation
* Metadata Management

### Data Warehousing

* Star Schema Design
* Fact and Dimension Modeling
* Surrogate Keys
* Reporting Layer

### Business Intelligence

* Power BI Semantic Modeling
* KPI Development
* Dashboard Design

### Software Development

* SQL Server Development
* SSIS Package Development
* Git Version Control
* Technical Documentation

---

# Current Project Status

## DW_FamilyFinance Version 2.0

### Completed

* Staging Layer
* Data Warehouse Layer
* ETL Framework
* Audit Framework
* Validation Framework
* Reporting Layer
* Power BI Semantic Model Design
* Documentation
* Maintenance Framework

### Next Enhancements

* Power BI Dashboard Development
* Budget vs Actual Reporting
* Financial Forecasting
* SQL Server Agent Scheduling
* Azure Data Factory Integration
* Cloud Data Warehouse Migration

---

# Author

**Behailu Tessema**

Data Engineer | BI Developer | SQL Server Developer

GitHub: https://github.com/BehailuDeveloperMode

Website: https://www.developermode.dev
