# DW_FamilyFinance Enterprise Data Warehouse & Business Intelligence Platform

## Project Information

**Project Name:** DW_FamilyFinance

**Current Version:** 2.0

**Author:** Behailu Tessema

**Website:** https://www.developermode.dev

**GitHub:** https://github.com/BehailuDeveloperMode

---

# Project Overview

DW_FamilyFinance is an enterprise-style SQL Server Data Warehouse and Business Intelligence solution designed to centralize, organize, analyze, and visualize family income and expense data.

The project automates the collection of financial transactions from multiple source systems, applies data quality and transformation rules, loads data into a dimensional data warehouse, and delivers analytical reporting through Power BI dashboards.

The solution demonstrates real-world practices in:

* Data Engineering
* ETL Development
* Data Warehousing
* SQL Server Development
* Business Intelligence
* Data Modeling

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

## Database

* SQL Server 2022

## ETL

* SQL Server Integration Services (SSIS)

## Reporting & Analytics

* Power BI

## Development Tools

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

---

## Version 2.0 – Reporting & Business Intelligence

### Completed Components

* Reporting Views
* Power BI Semantic Model
* KPI Framework
* Dashboard Design Framework
* Portfolio Documentation
* GitHub Documentation

---

# Database Architecture

## Database

DW_FamilyFinance

### Schemas

#### dim

Contains descriptive business entities used for reporting and analytics.

#### fact

Contains measurable business transactions.

#### etl

Contains warehouse loading stored procedures.

#### rpt

Contains reporting and analytical views.

---

# Dimension Tables

## dim.DimDate

### Purpose

Provides calendar and time intelligence support for reporting and analytics.

### Date Range

2020-01-01 through 2040-12-31

### Key Columns

* DateKey
* FullDate
* Year
* QuarterNumber
* MonthNumber
* MonthName
* MonthShortName
* YearMonthNumber
* YearMonthName
* DayOfMonth
* DayOfWeekName
* WeekOfYear

---

## dim.DimBank

### Purpose

Stores financial institutions associated with expense transactions.

### Example Values

* Citi Bank
* Wells Fargo Bank

---

## dim.DimDescription

### Purpose

Stores standardized expense classifications.

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

### Example Values

* Casa Coloma
* Windsor El Camino
* CITIGUARD INC
* ClipBoard
* Family Tax

---

# Fact Tables

## fact.FactExpense

### Purpose

Stores individual expense transactions.

### Grain

One row per expense transaction.

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

### Key Columns

* IncomeFactKey
* SourceIncomeID
* IncomeSourceKey
* PeriodBeginningDateKey
* PeriodEndingDateKey
* PayDateKey
* GrossPayment
* EmployerNetPay
* TotalTax

---

# Staging Environment

## Database

STG_FamilyLiving

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

### Features

* Incremental Description Loading
* Duplicate Prevention
* Audit Tracking

---

## STG_LoadIncomeData

### Features

* Incremental Pay Day Loading
* Maximum Date Tracking
* Audit Logging

---

## STG_LoadExpenseData

### Features

* Dynamic File Processing
* File Modified Date Incremental Logic
* Metadata Extraction
* Audit Tracking

---

## STG_Master_Incremental

### Execution Order

```text
STG_LoadDescriptionData
          │
          ▼
STG_LoadIncomeData
          │
          ▼
STG_LoadExpenseData
```

---

## DW_Initial_Setup

### Purpose

Performs the one-time initialization of the data warehouse, including the initial load of the Date dimension.

---

## DW_Load_FamilyFinance

### Execution Order

```text
DimBank
     │
     ▼
DimDescription
     │
     ▼
DimIncomeSource
     │
     ▼
FactExpense
     │
     ▼
FactIncome
```

---

# ETL Stored Procedures

## Dimension Loads

* etl.usp_Load_DimDate
* etl.usp_Load_DimBank
* etl.usp_Load_DimDescription
* etl.usp_Load_DimIncomeSource

## Fact Loads

* etl.usp_Load_FactExpense
* etl.usp_Load_FactIncome

## Master Procedure

* etl.usp_Load_DW_FamilyFinance

---

# Reporting Layer

## Detail Views

* rpt.vw_ExpenseDetail
* rpt.vw_IncomeDetail

## Summary Views

* rpt.vw_MonthlyFinancialSummary
* rpt.vw_ExpenseByCategory
* rpt.vw_ExpenseByBank
* rpt.vw_MonthlyExpenseTrend
* rpt.vw_MonthlyIncomeTrend

---

# Data Quality & Governance

## Audit Framework

Tracks:

* File Loads
* Income Loads
* Description Loads

---

## Validation Framework

Performs validation for:

* Duplicate Records
* Orphan Records
* Missing Date Keys
* Row Count Reconciliation
* Fact-to-Dimension Integrity

---

# Maintenance Framework

```text
Maintenance
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

## Dimension Tables

* DimDate
* DimBank
* DimDescription
* DimIncomeSource

## Fact Tables

* FactExpense
* FactIncome

## Relationships

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

## Executive Summary

* Total Income
* Total Expense
* Net Savings
* Transaction Count

## Expense Analysis

* Expense by Category
* Expense by SubCategory
* Expense by Bank
* Top Expenses

## Income Analysis

* Income by Employer
* Gross Income Trend
* Net Income Trend
* Tax Analysis

## Savings Analysis

* Monthly Savings
* Income vs. Expense
* Savings Trend

---

# Project Achievements

## Data Engineering

* ETL Development
* Incremental Loading
* Data Validation
* Metadata Management

## Data Warehousing

* Star Schema Design
* Fact and Dimension Modeling
* Surrogate Keys

## Business Intelligence

* Power BI Semantic Modeling
* KPI Development
* Dashboard Design

## Software Development

* SQL Server Development
* SSIS Package Development
* Git Version Control
* Technical Documentation

---

# Current Project Status

**DW_FamilyFinance Version 2.0**

Completed:

* Staging Layer
* Data Warehouse Layer
* ETL Framework
* Audit Framework
* Validation Framework
* Reporting Layer
* Power BI Semantic Model
* Documentation
* Maintenance Framework

---

# Planned Enhancements

* Complete Power BI Dashboard Development
* Budget vs. Actual Reporting
* Financial Forecasting
* SQL Server Agent Scheduling
* Azure Data Factory Integration
* Cloud Data Warehouse Migration

---

# Summary

DW_FamilyFinance Version 2.0 demonstrates a complete enterprise-style Business Intelligence solution built with SQL Server, SSIS, Power BI, and DAX.

The project follows modern data warehousing principles, including layered architecture, Star Schema design, incremental ETL processing, data validation, audit logging, semantic modeling, and executive dashboard reporting. It provides a scalable and maintainable foundation for financial analytics while showcasing end-to-end Data Engineering and Business Intelligence development practices.

---

# Author

## Behailu Tessema

**Data Engineer | Business Intelligence Developer | SQL Server Developer**

**GitHub**

https://github.com/BehailuDeveloperMode

**Portfolio**

https://www.developermode.dev
