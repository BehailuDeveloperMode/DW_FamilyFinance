# SSIS Variable Standards

## Overview

This document defines the variable standards used in the **Load_Bank_Transactions.dtsx** SSIS package for the **DW_FamilyFinance** project.

The package uses variables to avoid hard-coded file paths, file names, worksheet names, and incremental loading values.

---

# Naming Standard

Variables follow this pattern:

```text
<Source>_<Purpose>
```

Examples:

```text
Citi_SourceFileName
Citi_SourceFilePath
Citi_DestinationSheetName
WellsFargo_SourceFileName
```

Shared variables do not include a bank name.

Examples:

```text
SourceFolderPath
DestinationFolderPath
```

---

# Folder Path Variables

| Variable              | Data Type | Purpose                                                                         |
| --------------------- | --------- | ------------------------------------------------------------------------------- |
| SourceFolderPath      | String    | Stores the folder path where manually downloaded bank source files are located. |
| DestinationFolderPath | String    | Stores the folder path where standardized ETL source files are saved.           |

---

# File Name Variables

| Variable                       | Data Type | Purpose                                                |
| ------------------------------ | --------- | ------------------------------------------------------ |
| Citi_SourceFileName            | String    | Stores the Citi source workbook file name.             |
| WellsFargo_SourceFileName      | String    | Stores the Wells Fargo source workbook file name.      |
| Citi_DestinationFileName       | String    | Stores the Citi destination workbook file name.        |
| WellsFargo_DestinationFileName | String    | Stores the Wells Fargo destination workbook file name. |

---

# Dynamic File Path Variables

These variables use expressions to combine folder paths and file names.

| Variable                       | Data Type | Expression                                                                 |
| ------------------------------ | --------- | -------------------------------------------------------------------------- |
| Citi_SourceFilePath            | String    | `@[User::SourceFolderPath] + @[User::Citi_SourceFileName]`                 |
| WellsFargo_SourceFilePath      | String    | `@[User::SourceFolderPath] + @[User::WellsFargo_SourceFileName]`           |
| Citi_DestinationFilePath       | String    | `@[User::DestinationFolderPath] + @[User::Citi_DestinationFileName]`       |
| WellsFargo_DestinationFilePath | String    | `@[User::DestinationFolderPath] + @[User::WellsFargo_DestinationFileName]` |

---

# Worksheet Name Variables

| Variable                        | Data Type | Purpose                                                           |
| ------------------------------- | --------- | ----------------------------------------------------------------- |
| Citi_SourceSheetName            | String    | Stores the Citi source worksheet or Excel table name.             |
| Citi_DestinationSheetName       | String    | Stores the Citi destination worksheet or Excel table name.        |
| WellsFargo_SourceSheetName      | String    | Stores the Wells Fargo source worksheet or Excel table name.      |
| WellsFargo_DestinationSheetName | String    | Stores the Wells Fargo destination worksheet or Excel table name. |

---

# Incremental Load Variables

| Variable               | Data Type | Purpose                                                                 |
| ---------------------- | --------- | ----------------------------------------------------------------------- |
| Citi_MaxDate_Obj       | Object    | Stores the full result set returned by the Citi MAX(Date) query.        |
| Citi_MaxDate_Str       | String    | Stores the converted Citi maximum transaction date.                     |
| WellsFargo_MaxDate_Obj | Object    | Stores the full result set returned by the Wells Fargo MAX(Date) query. |
| WellsFargo_MaxDate_Str | String    | Stores the converted Wells Fargo maximum transaction date.              |

---

# Expression Rule

Any variable that builds a dynamic value must use:

```text
EvaluateAsExpression = True
```

Examples:

```text
Citi_SourceFilePath
Citi_DestinationFilePath
WellsFargo_SourceFilePath
WellsFargo_DestinationFilePath
```

---

# Design Standard

The package should avoid hard-coded values whenever possible.

Dynamic values should be controlled through variables for:

* Source folders
* Destination folders
* Source file names
* Destination file names
* Source worksheet names
* Destination worksheet names
* Incremental load dates

---

# Summary

The variable design in **Load_Bank_Transactions.dtsx** supports dynamic configuration, maintainability, and incremental loading. This approach allows the package to process new files and worksheet names without modifying the SSIS package logic.

