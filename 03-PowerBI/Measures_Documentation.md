# DW_FamilyFinance – Enterprise DAX Measures Documentation

**Project:** DW_FamilyFinance
**Author:** Behailu Tessema
**Version:** 2.0
**Technology:** Power BI Desktop, DAX, SQL Server 2022
**Last Updated:** June 2026

---

# Overview

The **DW_FamilyFinance Enterprise DAX Library** contains all business measures used by the Power BI Semantic Model. The measures support executive dashboards, financial reporting, payroll analysis, expense tracking, KPI monitoring, and time intelligence.

The library follows enterprise Business Intelligence development practices by organizing measures into logical business domains, documenting business purpose, and promoting reusable calculations throughout the Power BI model.

---

# Design Principles

The DAX library was developed using the following principles:

* Single source of truth for business calculations
* Reusable measures across multiple reports
* Business-friendly naming conventions
* Performance-oriented DAX expressions
* Consistent documentation standards
* Enterprise-ready code organization

---

# Measure Categories

## 1. Core Financial Measures

Purpose:

Provides the primary financial metrics used throughout the semantic model.

Examples:

* Gross Payment
* Net Salary
* Net Income
* Total Expense
* Net Savings
* Count of Pay Days
* Daily Expense
* Fixed Expense
* Fixed Salary

Business Questions:

* How much income was earned?
* How much money was spent?
* How much money was saved?
* How many payroll periods exist?

---

## 2. Tax Measures

Purpose:

Calculates payroll tax amounts for income analysis and tax reporting.

Examples:

* Total Tax
* Total Federal Tax
* Total SS Tax
* Total Medicare Tax
* Total CA State Tax
* Total CA SDI Tax

Business Questions:

* How much tax was paid?
* Which tax category contributes the most?

---

## 3. Budget Status & Conditional Formatting

Purpose:

Supports KPI indicators and conditional formatting by evaluating financial performance.

Examples:

* Salary Color Code
* Expense Color Code
* Expense Status
* Expense Color (Hex)
* Net Savings Status
* Net Savings Color
* Net Savings Color Hex

Business Questions:

* Is the household under budget?
* Is spending exceeding income?
* Should KPI cards display green, yellow, or red?

---

## 4. KPI Measures

Purpose:

Provides executive-level indicators and formatted business metrics.

Examples:

* Net Income KPI (Amount)
* Budget Delta
* Budget Over/Under %
* Category Contribution %
* SubCategory Contribution %
* Description Contribution %
* Salary Pie Value
* Salary Pie % of Gross

Business Questions:

* Are finances in surplus or deficit?
* What percentage does each category contribute?
* What portion of gross income becomes take-home pay?

---

## 5. Time Intelligence

Purpose:

Supports historical comparisons, rolling periods, averages, and trend analysis.

Examples:

* Previous Month Expense
* Monthly Expense
* Monthly Expense Trend
* Rolling 3 Full Months Expense
* Rolling 6 Full Months Expense
* Rolling 12 Full Months Expense
* YTD Expense
* Current Year Expense
* Current Year Income
* YoY Change
* YoY %
* Average Expense per Month
* Average Income per Month

Business Questions:

* How has spending changed over time?
* What is the year-over-year growth?
* What is the average monthly expense?
* What are recent spending trends?

---

## 6. Dynamic Titles & User Context

Purpose:

Creates dynamic report titles and user-friendly labels that respond to slicer selections.

Examples:

* Selected Year
* Selected Month
* Selected Date Range
* Selected Month Range
* Chart Title
* Dashboard Title
* Expense Analysis Title
* Income Analysis Title
* Savings Analysis Title

Business Questions:

* Which reporting period is currently selected?
* Which category or month is being analyzed?

---

## 7. Calculated Columns

Purpose:

Adds reusable business attributes to dimension and fact tables.

Examples:

### DimDate

* MonthCode
* YearWeek
* ISO Week
* ISO Year
* QuarterName

### DimIncomeSource

* Address
* First_Name

### FactFamilyIncome

* Work Period

### DimLocation

* Color Code

Business Purpose:

Improves filtering, grouping, sorting, reporting, and map visualizations.

---

## 8. Calculated Tables

Purpose:

Provides supporting lookup tables and disconnected tables used by the semantic model.

Examples:

* DimLocation
* Salary Pie Category

Business Purpose:

Supports map visuals, disconnected slicers, and custom visual calculations.

---

# Dashboard Usage

The DAX library powers the following report pages:

* Executive Summary
* Expense Analysis
* Income Analysis
* Savings Analysis
* Validation Dashboard

---

# Documentation Standard

Each enterprise measure follows a standardized documentation format.

```text
Measure Name
Folder
Author
Project
Version

Purpose
Business Question
Used In
Dependencies
Returns
```

This documentation approach improves maintainability, readability, and collaboration while following enterprise Business Intelligence development practices.

---

# Best Practices Applied

* Star Schema design
* Reusable measures
* Centralized business logic
* Time Intelligence
* KPI standardization
* Conditional formatting
* Dynamic reporting
* Performance optimization
* Documentation-first development

---

# Project Highlights

* SQL Server Data Warehouse
* SSIS Incremental ETL Framework
* Enterprise Star Schema
* Power BI Semantic Model
* Enterprise DAX Measure Library
* Business KPI Framework
* Executive Dashboard Design
* Financial Analytics
* Payroll Analytics
* Data Validation Framework

---

# Future Enhancements

* Calculation Groups using Tabular Editor
* Dynamic Currency Formatting
* Advanced Financial Forecasting
* Budget vs Actual Analysis
* What-If Parameters
* Row-Level Security (RLS)
* XMLA Endpoint Deployment
* Fabric / Azure Integration

---

# Conclusion

The DW_FamilyFinance Enterprise DAX Library centralizes all business calculations required by the Power BI Semantic Model. By organizing measures into logical business domains and documenting their purpose, the solution provides a scalable, maintainable, and enterprise-ready analytics platform that supports executive reporting, financial analysis, and business intelligence best practices.

---

# Privacy Notice:

The original Power BI (.pbix) file and source datasets are intentionally excluded from this repository because they contain personal financial and payroll information. This repository focuses on the solution architecture, SQL Server data warehouse design, ETL framework, DAX measure library, and dashboard implementation while protecting sensitive data.
