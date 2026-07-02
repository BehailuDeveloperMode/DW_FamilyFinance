# SSIS Script Tasks Documentation

## Overview

The **Load_Bank_Transactions.dtsx** package uses Script Tasks to process the result returned from the Execute SQL Task. The Execute SQL Task retrieves the latest transaction date from the destination Excel workbook as a **Full Result Set**. The Script Task extracts this value and stores it in a string variable for use during the incremental load process.

---

# Script Task Summary

| Script Task | Purpose |
|------------|---------|
| SCR_ConvertMaxDate_Citi | Converts the Citi maximum transaction date from an Object variable to a String variable. |
| SCR_ConvertMaxDate_WellsFargo | Converts the Wells Fargo maximum transaction date from an Object variable to a String variable. |

---

# Why a Script Task Is Required

The Execute SQL Task queries the destination Excel workbook using:

```sql
SELECT CSTR(MAX([Date])) AS MaxDate
FROM [Sheet$]
```

Although the query returns a single value, the Excel provider returns the result as a **Full Result Set**. The Script Task extracts the first row and first column from the result and stores it in a String variable.

Without the Script Task, the Conditional Split cannot easily compare source transaction dates against the latest transaction date already loaded.

---

# Control Flow

```text
EST_GetMaxDate_Citi
        │
        ▼
SCR_ConvertMaxDate_Citi
        │
        ▼
DFT_LoadTransactions_Citi
```

```text
EST_GetMaxDate_WellsFargo
        │
        ▼
SCR_ConvertMaxDate_WellsFargo
        │
        ▼
DFT_LoadTransactions_WellsFargo
```

---

# Citi Script Task

## Name

```text
SCR_ConvertMaxDate_Citi
```

### ReadOnly Variables

| Variable |
|----------|
| User::Citi_MaxDate_Obj |

### ReadWrite Variables

| Variable |
|----------|
| User::Citi_MaxDate_Str |

### Processing Logic

1. Read the Full Result Set stored in `Citi_MaxDate_Obj`.
2. Load the result into a DataTable.
3. Retrieve the first row and first column.
4. Convert the value to a string.
5. Store the value in `Citi_MaxDate_Str`.
6. If no records exist, use the default value `1900-01-01`.

---

# Wells Fargo Script Task

## Name

```text
SCR_ConvertMaxDate_WellsFargo
```

### ReadOnly Variables

| Variable |
|----------|
| User::WellsFargo_MaxDate_Obj |

### ReadWrite Variables

| Variable |
|----------|
| User::WellsFargo_MaxDate_Str |

### Processing Logic

1. Read the Full Result Set stored in `WellsFargo_MaxDate_Obj`.
2. Load the result into a DataTable.
3. Retrieve the first row and first column.
4. Convert the value to a string.
5. Store the value in `WellsFargo_MaxDate_Str`.
6. If no records exist, use the default value `1900-01-01`.

---

# Business Purpose

The Script Tasks support the incremental loading framework by converting the latest transaction date into a format that can be used by the Conditional Split transformation.

This ensures that only new bank transactions are loaded into the destination workbook, preventing duplicate records while improving performance.

---

# Benefits

| Benefit | Description |
|---------|-------------|
| Incremental Loading | Loads only new transactions. |
| Duplicate Prevention | Prevents loading transactions already processed. |
| Performance | Reduces unnecessary data processing. |
| Automation | Eliminates manual tracking of the latest transaction date. |
| Maintainability | Uses SSIS variables instead of hard-coded values. |

---

# Related Components

| Component | Purpose |
|-----------|---------|
| EST_GetMaxDate_Citi | Retrieves the latest Citi transaction date. |
| EST_GetMaxDate_WellsFargo | Retrieves the latest Wells Fargo transaction date. |
| DFT_LoadTransactions_Citi | Loads new Citi transactions. |
| DFT_LoadTransactions_WellsFargo | Loads new Wells Fargo transactions. |

---

# Summary

The Script Tasks provide a reusable mechanism for converting the maximum transaction date retrieved from Excel into a string variable used by the incremental loading process. They play a key role in ensuring accurate, efficient, and automated ETL execution within the **Load_Bank_Transactions.dtsx** package.