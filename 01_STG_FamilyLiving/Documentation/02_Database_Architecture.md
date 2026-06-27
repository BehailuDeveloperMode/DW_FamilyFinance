# Database_Architecture

# DW_FamilyFinance Database Architecture

## Overview

The **DW_FamilyFinance** solution is built using a layered database architecture that separates data ingestion, transformation, storage, and reporting. This design improves maintainability, scalability, and performance while following enterprise data warehousing best practices.

The solution consists of two SQL Server databases:

* **STG_FamilyLiving** – Staging Database
* **DW_FamilyFinance** – Enterprise Data Warehouse

Each database has a specific responsibility within the overall ETL and reporting process.

---

# Database Architecture

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
           Executive Analytics Reports
```

---

# STG_FamilyLiving

## Purpose

The staging database acts as the landing area for all incoming source data.

Its primary responsibility is to receive raw data, perform initial validation, and prepare records for loading into the enterprise data warehouse.

---

## Responsibilities

* Import source files
* Store raw financial data
* Validate incoming records
* Track file metadata
* Prevent duplicate data
* Maintain audit history
* Prepare data for ETL processing

---

## Core Tables

| Table                  | Description                              |
| ---------------------- | ---------------------------------------- |
| STG_FamilySourceData   | Stores imported expense transactions     |
| Family_Income          | Stores imported payroll data             |
| STG_Description_LookUp | Stores standardized expense descriptions |

---

## Audit Tables

| Table                    | Description                   |
| ------------------------ | ----------------------------- |
| STG_FileLoadAudit        | Tracks imported expense files |
| STG_IncomeLoadAudit      | Tracks payroll imports        |
| STG_DescriptionLoadAudit | Tracks lookup table updates   |

---

# DW_FamilyFinance

## Purpose

The enterprise data warehouse stores cleansed, validated, and business-ready data optimized for analytics and reporting.

The warehouse follows a Star Schema design to support Power BI reporting and executive dashboards.

---

## Responsibilities

* Store historical financial data
* Support business intelligence reporting
* Maintain dimensional models
* Provide reporting views
* Centralize business calculations
* Improve reporting performance

---

# Database Schemas

The warehouse is organized into multiple schemas to separate responsibilities.

## dim

Contains all dimension tables.

Examples:

* DimDate
* DimBank
* DimDescription
* DimIncomeSource

---

## fact

Contains business transaction tables.

Examples:

* FactExpense
* FactIncome

---

## etl

Contains ETL stored procedures responsible for loading dimensions and facts.

Examples:

* usp_Load_DimDate
* usp_Load_DimBank
* usp_Load_FactExpense
* usp_Load_FactIncome
* usp_Load_DW_FamilyFinance

---

## rpt

Contains reporting views used by Power BI.

Examples:

* Expense Detail
* Income Detail
* Monthly Financial Summary
* Monthly Expense Trend
* Monthly Income Trend

---

# Data Flow

The warehouse processes data using the following workflow.

```text
Source Files
      │
      ▼
STG_FamilyLiving
      │
      ▼
Validation
      │
      ▼
Dimension Tables
      │
      ▼
Fact Tables
      │
      ▼
Reporting Views
      │
      ▼
Power BI
```

---

# Design Principles

The database architecture follows these principles:

* Layered architecture
* Separation of responsibilities
* Star Schema design
* Incremental ETL processing
* Historical data preservation
* Data quality validation
* Centralized business logic
* Scalable reporting model

---

# Benefits

This architecture provides:

* Simplified maintenance
* Faster analytical queries
* Reliable historical reporting
* Improved data quality
* Better ETL performance
* Reusable reporting structures
* Efficient Power BI integration

---

# Integration with Power BI

The Power BI semantic model connects directly to the reporting layer of the data warehouse.

The model uses:

* Dimension tables
* Fact tables
* Reporting views
* Enterprise DAX measures
* Time intelligence
* Interactive filtering

This architecture enables efficient and scalable financial analytics while maintaining a clean separation between data storage, business logic, and visualization.

---

# Summary

The DW_FamilyFinance database architecture follows enterprise data warehousing practices by separating staging, storage, transformation, and reporting into clearly defined layers.

This approach provides a scalable foundation for ETL processing, historical reporting, Power BI analytics, and future enhancements while maintaining high data quality and performance.
