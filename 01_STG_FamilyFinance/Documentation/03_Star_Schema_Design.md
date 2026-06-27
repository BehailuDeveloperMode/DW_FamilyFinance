# Star_Schema_Design

# DW_FamilyFinance Star Schema Design

## Overview

The **DW_FamilyFinance** data warehouse is designed using a **Star Schema** architecture to support high-performance reporting, business intelligence, and financial analytics.

The Star Schema organizes business data into **Fact Tables** and **Dimension Tables**, providing a simple, scalable, and efficient model for Power BI and SQL Server reporting.

---

# Why Star Schema?

A Star Schema was selected because it provides:

* High query performance
* Simplified reporting
* Easy-to-understand relationships
* Optimized Power BI model
* Efficient aggregation
* Reusable business dimensions

---

# Star Schema Architecture

```text
                    DimDate
                       │
                       │
        ┌──────────────┼──────────────┐
        │                              │
        │                              │
   FactExpense                  FactIncome
        │                              │
   ┌────┴────┐                    ┌────┴────┐
   │         │                    │         │
DimBank  DimDescription      DimIncomeSource
```

---

# Fact Tables

Fact tables store measurable business events.

---

## FactExpense

### Purpose

Stores one record for each expense transaction.

### Grain

One row per expense transaction.

### Measures

* Expense Amount

### Foreign Keys

* DateKey
* BankKey
* DescriptionKey

### Business Purpose

Supports expense reporting, trend analysis, budgeting, and financial dashboards.

---

## FactIncome

### Purpose

Stores one record for each payroll or income transaction.

### Grain

One row per income transaction.

### Measures

* Gross Payment
* Employer Net Pay
* Federal Tax
* Social Security Tax
* Medicare Tax
* California State Tax
* California SDI Tax
* Deductions

### Foreign Keys

* PayDateKey
* IncomeSourceKey

### Business Purpose

Supports payroll reporting, tax analysis, income tracking, and executive reporting.

---

# Dimension Tables

Dimension tables describe business entities used to filter and analyze fact data.

---

## DimDate

### Purpose

Provides calendar attributes for reporting and time intelligence.

### Examples

* Full Date
* Day
* Month
* Quarter
* Year
* Week
* Month Name
* Year Month

Used for:

* Trends
* Year-over-Year analysis
* Rolling periods
* Monthly reporting

---

## DimBank

### Purpose

Stores banking institutions associated with expense transactions.

### Examples

* Wells Fargo
* Citi Bank

Used for:

* Bank analysis
* Transaction reporting

---

## DimDescription

### Purpose

Categorizes expense transactions into business-friendly classifications.

### Attributes

* Description
* Category
* SubCategory
* Expense Type

Used for:

* Expense analysis
* Category reporting
* Spending trends

---

## DimIncomeSource

### Purpose

Stores information about payroll and income sources.

### Attributes

* Workplace
* Employee Name

### Examples

* Casa Coloma
* Windsor El Camino
* CITIGUARD INC
* ClipBoard
* Family Tax

Used for:

* Payroll analysis
* Workplace reporting
* Employee income analysis

---

# Relationships

The warehouse uses **one-to-many** relationships between dimension and fact tables.

| Dimension Table | Fact Table  | Relationship |
| --------------- | ----------- | ------------ |
| DimDate         | FactExpense | One-to-Many  |
| DimBank         | FactExpense | One-to-Many  |
| DimDescription  | FactExpense | One-to-Many  |
| DimDate         | FactIncome  | One-to-Many  |
| DimIncomeSource | FactIncome  | One-to-Many  |

All relationships use **single-direction filtering**, following Power BI and dimensional modeling best practices.

---

# Surrogate Keys

Each dimension table uses a surrogate key as its primary key.

Examples:

* DateKey
* BankKey
* DescriptionKey
* IncomeSourceKey

Surrogate keys improve performance, simplify joins, and isolate the warehouse from changes in source system identifiers.

---

# Business Keys

Business keys uniquely identify records in the source systems.

Examples include:

* Transaction ID
* Pay Date
* Workplace
* Expense Description

Business keys are used during ETL processing to identify new or updated records before assigning surrogate keys.

---

# Reporting Benefits

The Star Schema provides several advantages:

* Simplified SQL queries
* Faster Power BI performance
* Consistent business definitions
* Efficient filtering
* Improved scalability
* Better user experience

---

# Power BI Integration

The Star Schema serves as the foundation of the Power BI semantic model.

It enables:

* Interactive slicers
* Time intelligence calculations
* Executive KPI reporting
* Drill-through analysis
* Cross-filtering between dimensions and facts
* Reusable DAX measures

---

# Design Best Practices

The DW_FamilyFinance Star Schema follows these best practices:

* Separate facts from dimensions
* Use surrogate keys
* Maintain a consistent grain
* Keep dimensions descriptive
* Avoid snowflake structures where unnecessary
* Use one-to-many relationships
* Centralize business logic in DAX measures

---

# Summary

The DW_FamilyFinance Star Schema provides a scalable and maintainable foundation for financial reporting and business intelligence.

By separating measurable transactions into fact tables and descriptive business attributes into dimension tables, the design delivers efficient querying, simplified reporting, and seamless integration with Power BI while following enterprise data warehousing standards.
