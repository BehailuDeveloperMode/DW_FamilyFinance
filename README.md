# DW_FamilyFinance

## Enterprise SQL Server Data Warehouse for Family Financial Analytics

DW_FamilyFinance is an end-to-end Data Warehouse and Business Intelligence solution designed to automate the collection, transformation, storage, and analysis of personal and family financial data.

The project integrates banking transactions, payroll records, and expense classification rules into a centralized SQL Server Data Warehouse that supports reporting, budgeting, expense tracking, and long-term financial planning. The solution follows enterprise data warehousing principles, including staging, dimensional modeling, ETL automation, audit tracking, and reporting.

---

## Project Architecture

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

## Technology Stack

### Database

* SQL Server 2022

### ETL

* SQL Server Integration Services (SSIS)

### Reporting & Analytics

* Power BI

### Development Tools

* Visual Studio 2022
* SQL Server Management Studio (SSMS)
* Git & GitHub

---

## Database Architecture

### Staging Layer – STG_FamilyLiving

The staging environment is responsible for collecting and validating source data before it is loaded into the data warehouse.

#### Core Tables

* STG_FamilySourceData
* Family_Income
* STG_Description_LookUp

#### Audit Tables

* STG_FileLoadAudit
* STG_IncomeLoadAudit
* STG_DescriptionLoadAudit

#### Key Features

* Incremental loading
* Audit logging
* Dynamic file processing
* Metadata tracking
* Data validation
* Duplicate prevention

---

### Data Warehouse Layer – DW_FamilyFinance

The data warehouse uses a Star Schema design to support efficient analytics and reporting.

#### Dimension Tables

* DimDate
* DimBank
* DimDescription
* DimIncomeSource

#### Fact Tables

* FactExpense
* FactIncome

#### Reporting Views

* Expense Detail
* Income Detail
* Monthly Financial Summary
* Financial Reconciliation Reports

---

## SSIS ETL Framework

### STG_LoadExpenseData

Features:

* Dynamic file processing
* OneDrive integration
* Metadata extraction
* Incremental loading using File Modified Date
* Audit tracking
* Automated reload of updated files

### STG_LoadIncomeData

Features:

* Incremental loading using Pay_Day
* Max date tracking
* Audit logging
* Row count validation

### STG_LoadDescriptionData

Features:

* Incremental lookup loading
* Duplicate prevention
* Row count tracking
* Audit logging

### STG_Master_Incremental

Master package responsible for orchestrating all staging processes:

```text
STG_LoadDescriptionData
        ↓
STG_LoadIncomeData
        ↓
STG_LoadExpenseData
```

---

## Key Skills Demonstrated

* SQL Server Development
* Data Warehousing
* Star Schema Design
* ETL Development
* SSIS Package Development
* Incremental Loading Strategies
* Data Modeling
* Data Validation
* Audit Framework Design
* Power BI Data Modeling
* Git Version Control

---

## Business Value

This solution provides a centralized platform for managing family income and expenses while demonstrating real-world enterprise data engineering concepts. The project automates data collection, improves data quality, enables historical analysis, and supports data-driven financial decision-making.

---

## Author

### Behailu Tessema

Data Engineer | BI Developer | SQL Server Developer

GitHub: https://github.com/BehailuDeveloperMode

Website: https://www.developermode.dev
