#This PS script will remove GroupName from all Computers listed in the CSV file.
#Whatever is listed for -Header will be used for -Members (preceeding $_.)

Import-Csv -Path drive:\Path\of\the\File.csv -Header ColumnNametobeImported | ForEach-Object {Remove-ADGroupMember -Identity GroupName -Members $_.ColumnNametobeImported}
