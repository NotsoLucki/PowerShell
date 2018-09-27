Import-Csv -Path drive:\Path\of\the\File.csv -Header ColumnNametobeImported | ForEach-Object {Remove-ADGroupMember -Identity GroupName -Members $_.ColumnNametobeImported}
