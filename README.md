# DW_FamilyFinance

## Overview

DW_FamilyFinance is an end-to-end SQL Server Data Warehouse project designed to automate the collection, transformation, storage, and analysis of personal and family financial data.

The solution integrates multiple financial data sources, including banking transactions, payroll records, and expense classification rules, into a centralized data warehouse that supports reporting, analytics, budgeting, and long-term financial planning.

This project demonstrates real-world Data Engineering, ETL Development, Data Warehousing, SQL Server Development, SSIS, and Power BI skills using industry-standard architecture and best practices.

---

## Project Architecture

```text
Source Files
    │
    ▼
STG_FamilyLiving
    │
    ▼
DW_FamilyFinance
    │
    ▼
Power BI Reporting
```

### Source Systems

* Citi Bank Transactions
* Wells Fargo Transactions
* Payroll Income Records
* Expense Classification Lookup Files

---

## Technology Stack

### Database

* SQL Server 2022 Developer Edition

### ETL

* SQL Server Integration Services (SSIS)

### Reporting

* Power BI

### Development Tools

* Visual Studio 2022
* SQL Server Management Studio (SSMS)
* Git
* GitHub

---

## Database Architecture

### Staging Database

**STG_FamilyLiving**

Purpose:

* Load raw source files
* Perform data validation
* Capture audit information
* Support incremental loading

Main Tables:

* STG_FamilySourceData
* Family_Income
* STG_Description_LookUp

Audit Tables:

* STG_FileLoadAudit
* STG_IncomeLoadAudit
* STG_DescriptionLoadAudit

---

### Data Warehouse Database

**DW_FamilyFinance**

Schemas:

#### Dimension Schema

* dim.DimDate
* dim.DimBank
* dim.DimDescription
* dim.DimIncomeSource

#### Fact Schema

* fact.FactExpense
* fact.FactIncome

#### ETL Schema

* etl.usp_Load_DimDate
* etl.usp_Load_DimBank
* etl.usp_Load_DimDescription
* etl.usp_Load_DimIncomeSource
* etl.usp_Load_FactExpense
* etl.usp_Load_FactIncome

#### Reporting Schema

* rpt.vw_ExpenseDetail
* rpt.vw_IncomeDetail
* rpt.vw_MonthlyFinancialSummary

---

## SSIS Solution

### STG_LoadDescriptionData

Features:

* Incremental lookup loading
* Duplicate prevention
* Row count tracking
* Audit logging

### STG_LoadIncomeData

Features:

* Incremental loading using Pay_Day
* Max date tracking
* Row count tracking
* Audit logging

### STG_LoadExpenseData

Features:

* Dynamic file processing
* OneDrive integration
* Metadata extraction
* File audit tracking
* Incremental loading using FileModifiedDate
* Automated reload of updated files

### STG_Master_Incremental

Master package that orchestrates all staging loads:

```text
STG_LoadDescriptionData
        ↓
STG_LoadIncomeData
        ↓
STG_LoadExpenseData
```

---

## Key Features

* Enterprise ETL Architecture
* Incremental Data Loading
* Dynamic File Processing
* Audit Framework
* Metadata Tracking
* Star Schema Design
* Fact and Dimension Modeling
* Data Validation
* Data Quality Controls
* Power BI Reporting Layer

---

## Future Enhancements

* SQL Server Agent Scheduling
* Automated Email Notifications
* Data Quality Dashboard
* Forecasting and Budget Analytics
* Azure Data Factory Integration
* Cloud Data Warehouse Migration

---

## Author

**Behailu Tessema**

Data Engineer | BI Developer | SQL Server Developer

GitHub:
https://github.com/BehailuDeveloperMode
