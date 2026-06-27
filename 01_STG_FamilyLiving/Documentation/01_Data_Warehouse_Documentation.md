# Data_Warehouse_Documentation

# DW_FamilyFinance Enterprise Data Warehouse

## Overview

The **DW_FamilyFinance** data warehouse is designed using a dimensional modeling approach to support financial reporting, business intelligence, historical analysis, and executive dashboards.

The warehouse consolidates family income and expense data from multiple source systems into a centralized repository optimized for analytics.

The design follows Kimball dimensional modeling principles and consists of a staging database, an enterprise data warehouse, and a Power BI semantic model.

---

# Data Warehouse Objectives

The primary objectives of the data warehouse are:

* Centralize family financial data
* Support historical reporting
* Improve data quality
* Enable business intelligence reporting
* Simplify financial analysis
* Support Power BI semantic modeling
* Provide scalable ETL processing

---

# Overall Architecture

```text
                 Source Files
        (Excel / Payroll / Banking)
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
          Executive Dashboards
```

---

# Database Design

The solution is divided into two databases.

## 1. STG_FamilyLiving

Purpose:

Acts as the landing area for raw source data.

Responsibilities:

* Import source files
* Validate incoming records
* Store audit information
* Track file metadata
* Prepare data for warehouse loading

---

## 2. DW_FamilyFinance

Purpose:

Stores cleansed and modeled data optimized for analytics.

Responsibilities:

* Historical reporting
* Financial analytics
* Power BI reporting
* Star Schema storage
* KPI calculations

---

# Star Schema

The warehouse uses a Star Schema architecture.

## Dimension Tables

### DimDate

Purpose:

Stores calendar attributes used for filtering, grouping, and time intelligence.

Examples:

* Date
* Month
* Quarter
* Year
* Week
* Month Name
* Year Month

---

### DimBank

Purpose:

Stores banking institutions associated with expense transactions.

Examples:

* Wells Fargo
* Citi Bank

---

### DimDescription

Purpose:

Stores expense descriptions and business classifications.

Attributes include:

* Description
* Category
* SubCategory
* Expense Type

---

### DimIncomeSource

Purpose:

Stores payroll and income source information.

Attributes include:

* Workplace
* Employee Name

Examples:

* Casa Coloma
* Windsor El Camino
* CITIGUARD INC
* ClipBoard
* Family Tax

---

# Fact Tables

## FactExpense

Grain:

One record per financial expense transaction.

Key Measures:

* Expense Amount

Relationships:

* DimDate
* DimBank
* DimDescription

---

## FactIncome

Grain:

One record per payroll transaction.

Key Measures:

* Gross Payment
* Employer Net Pay
* Federal Tax
* Social Security Tax
* Medicare Tax
* CA State Tax
* CA SDI Tax
* Deductions

Relationships:

* DimDate
* DimIncomeSource

---

# Data Flow

The ETL process follows this sequence.

```text
Source Files
      │
      ▼
Staging Tables
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

# Reporting Layer

The warehouse provides curated reporting views used by Power BI.

Examples:

* Expense Detail
* Income Detail
* Monthly Financial Summary
* Financial Reconciliation
* Expense Record Count

---

# Design Principles

The warehouse follows these design principles:

* Star Schema Architecture
* Dimensional Modeling
* Incremental Loading
* Historical Data Preservation
* Data Quality Validation
* Reusable Business Logic
* Enterprise Naming Standards
* Optimized Query Performance

---

# Benefits

The warehouse provides:

* Faster analytical queries
* Simplified Power BI development
* Consistent business definitions
* Reliable historical reporting
* Scalable ETL processing
* Centralized financial analytics

---

# Integration with Power BI

The Power BI semantic model connects directly to the warehouse.

Features include:

* Star Schema relationships
* Enterprise DAX library
* Executive dashboards
* Time intelligence
* Dynamic filtering
* KPI calculations
* Interactive analytics

---

# Future Enhancements

Planned improvements include:

* Azure SQL Database
* Microsoft Fabric
* Data Lake integration
* Power BI Service deployment
* Row-Level Security (RLS)
* Automated data quality monitoring
* Advanced financial forecasting

---

# Conclusion

DW_FamilyFinance demonstrates the implementation of a modern enterprise data warehouse using SQL Server, SSIS, dimensional modeling, and Power BI.

The solution integrates raw financial data into a centralized analytical platform that supports executive reporting, business intelligence, and long-term financial analysis while following industry best practices for data warehousing and semantic modeling.
