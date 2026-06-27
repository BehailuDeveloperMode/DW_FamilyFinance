using System.IO;
using System.Text;
using System.Linq;

var sb = new StringBuilder();

// 1. Get all Measures
sb.AppendLine("--- MEASURES ---");
foreach (var m in Model.AllMeasures)
{
    sb.AppendLine("// Table: " + m.Table.Name + "\n[" + m.Name + "] =\n" + m.Expression + "\n");
}

// 2. Get all Calculated Columns
sb.AppendLine("\n--- CALCULATED COLUMNS ---");
foreach (var c in Model.AllColumns.OfType<CalculatedColumn>())
{
    sb.AppendLine("// Table: " + c.Table.Name + "\n" + c.Table.Name + "[" + c.Name + "] =\n" + c.Expression + "\n");
}

// 3. Get all Calculated Tables
sb.AppendLine("\n--- CALCULATED TABLES ---");
foreach (var t in Model.Tables.OfType<CalculatedTable>())
{
    sb.AppendLine(t.Name + " =\n" + t.Expression + "\n");
}

// Save to your desktop
string desktopPath = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
string filePath = Path.Combine(desktopPath, "PowerBI_DAX_Export.txt");
File.WriteAllText(filePath, sb.ToString());

Output("DAX successfully exported to: " + filePath);