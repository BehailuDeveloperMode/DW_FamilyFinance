# DW_FamilyFinance

# Enterprise SQL Server Data Warehouse for Family Financial Analytics

## Project Overview

**DW_FamilyFinance** is an end-to-end Business Intelligence (BI) and Data Warehouse solution designed to automate the collection, transformation, storage, and analysis of family financial data.

The project consolidates banking transactions, payroll records, and expense classification data into a centralized SQL Server Data Warehouse that supports executive reporting, budgeting, expense tracking, payroll analysis, and long-term financial planning.

The solution follows enterprise data warehousing best practices, including:

* Staging and Data Warehouse architecture
* Star Schema dimensional modeling
* Incremental ETL processing
* Audit logging and data validation
* SQL Server stored procedures
* SSIS package automation
* Power BI Semantic Model
* Enterprise DAX Measure Library
* Executive dashboard reporting

---

# Solution Architecture

```text
                Source Files
      (Excel / Google Sheets / Payroll)
                    │
                    ▼
             STG_FamilyLiving
             (Staging Database)
                    │
                    ▼
            DW_FamilyFinance
       (Enterprise Data Warehouse)
                    │
                    ▼
         Power BI Semantic Model
                    │
                    ▼
        Executive Analytics Dashboards
```

---

# Technology Stack

## Database

* SQL Server 2022

## ETL

* SQL Server Integration Services (SSIS)

## Reporting & Analytics

* Power BI Desktop
* DAX (Data Analysis Expressions)

## Development Tools

* Visual Studio 2022
* SQL Server Management Studio (SSMS)
* Git
* GitHub

---

# Database Architecture

## Staging Layer — STG_FamilyLiving

The staging database is responsible for collecting, validating, and preparing source data before loading it into the enterprise data warehouse.

### Core Tables

* STG_FamilySourceData
* Family_Income
* STG_Description_LookUp

### Audit Tables

* STG_FileLoadAudit
* STG_IncomeLoadAudit
* STG_DescriptionLoadAudit

### Key Features

* Incremental loading
* Audit logging
* Dynamic file processing
* Metadata tracking
* Data validation
* Duplicate prevention
* Row count verification

---

## Data Warehouse Layer — DW_FamilyFinance

The enterprise data warehouse follows a Star Schema design to provide high-performance analytics and reporting.

### Dimension Tables

* DimDate
* DimBank
* DimDescription
* DimIncomeSource

### Fact Tables

* FactExpense
* FactIncome

### Reporting Views

* Expense Detail
* Income Detail
* Monthly Financial Summary
* Financial Reconciliation Reports

---

# SSIS ETL Framework

The ETL framework automates data movement from the staging environment into the enterprise data warehouse.

## STG_LoadExpenseData

Features

* Dynamic file processing
* OneDrive integration
* Metadata extraction
* Incremental loading using File Modified Date
* Audit tracking
* Automatic reload of updated files

---

## STG_LoadIncomeData

Features

* Incremental loading using Pay Day
* Maximum date tracking
* Audit logging
* Row count validation

---

## STG_LoadDescriptionData

Features

* Incremental lookup loading
* Duplicate prevention
* Row count verification
* Audit logging

---

## STG_Master_Incremental

Master ETL package responsible for orchestrating all staging processes.

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

# Power BI Solution

The reporting layer is built using Power BI and follows enterprise semantic modeling best practices.

## Dashboard Pages

* Executive Summary
* Expense Analysis
* Income Analysis
* Savings Analysis
* Data Validation

## Power BI Features

* Star Schema Semantic Model
* Enterprise DAX Measure Library
* Executive KPI Dashboard
* Dynamic Titles
* Time Intelligence
* Conditional Formatting
* Interactive Slicers
* Financial Analytics
* Payroll Analytics

---

# Key Skills Demonstrated

* SQL Server Development
* Data Warehousing
* Star Schema Design
* ETL Development
* SSIS Package Development
* Incremental Loading Strategies
* Data Modeling
* SQL Stored Procedures
* Power BI Development
* DAX Development
* Power BI Semantic Modeling
* Data Validation
* Audit Framework Design
* Financial Analytics
* Business Intelligence
* Git Version Control

---

# Business Value

DW_FamilyFinance demonstrates how enterprise data engineering and business intelligence techniques can be applied to financial analytics.

The solution automates data collection, improves data quality, centralizes financial information, and enables interactive reporting for income analysis, expense tracking, payroll monitoring, budgeting, and long-term financial planning.

The project showcases a complete end-to-end BI solution, from raw data ingestion to executive dashboards, following enterprise development standards.

---

# Privacy Notice

The original Power BI (.pbix) file and source datasets are intentionally excluded from this repository because they contain personal financial and payroll information.

This repository focuses on the solution architecture, SQL Server implementation, ETL framework, semantic model, DAX measure library, and dashboard design while protecting sensitive personal data.

---

# Future Enhancements

* Microsoft Fabric Integration
* Azure SQL Database Deployment
* Power BI Service Deployment
* Row-Level Security (RLS)
* Calculation Groups
* Budget Forecasting
* Financial Trend Forecasting
* Automated Data Quality Monitoring

---

# Author

## Behailu Tessema

**Data Engineer | Business Intelligence Developer | SQL Server Developer**

### Connect with Me

**GitHub**

https://github.com/BehailuDeveloperMode

**Portfolio**

https://www.developermode.dev
