# Script to grab the following system information:
## Computer Name
## Most recent user
## BIOS Version
## Service Tag/Serial Number
## Manufacturer
## Model
## Processor
## Number of Cores
## OS
## Memory
## Hard drive size
## MAC Address
## IP Address
# and spits it out into a .CSV file on the C:\ drive

## This section looks for the computer information on the local machine
$CPUinfo = Get-WmiObject win32_processor
$username = Get-ChildItem "C:\Users\" | Sort-Object LastWriteTime -Descending | Select-Object Name, LastWriteTime
$BIOS = Get-WmiObject win32_bios
$Hardware = Get-WmiObject win32_computersystem
$OSinfo = Get-WmiObject win32_operatingsystem
$PhysicalMemory = Get-WmiObject cim_physicalmemory | Measure-Object -Property capacity -Sum | % { [Math]::Round(($_.sum / 1GB), 2) }
$HardDrive = Get-WmiObject win32_volume -Filter 'drivetype = 3' | Where-Object {$_.driveletter -match 'C:'}
$HDsize = [math]::Round($HardDrive.Capacity /1GB, 2)
$Network = Get-WmiObject win32_networkadapterconfiguration | Where-Object {$_.IPEnabled}
$MACaddress = $Network.MACAddress
$IPaddress = $Network.IpAddress


## This takes the functions from above and grabs the specific parts
$infoObject = New-Object PSObject
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'Computer Name' -Value $CPUinfo.SystemName
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'User' -Value $username.Name[0]
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'BIOS Version' -Value $BIOS.SMBIOSBIOSVersion
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'Service Tag' -Value $BIOS.SerialNumber
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'Manufacturer' -Value $Hardware.Manufacturer
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'Model' -Value $Hardware.Model
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'Processor' -Value $CPUinfo.Name
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'Number of Cores' -Value $CPUinfo.NumberOfCores
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'Operating System' -Value $OSinfo.Caption
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'Memory (GB)' -Value $PhysicalMemory
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'Hard Drive Size (GB)' -Value $HDsize
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'MAC Address' -Value $MACaddress
Add-Member -InputObject $infoObject -MemberType NoteProperty -Name 'IP Address' -Value $IPaddress
$infoObject ## Visually displays the information for confirmation ##

$infoObject | Export-Csv -Path "C:\ComputerSpecs_$((Get-Date).ToString('MM-dd-yyyy')).csv" -NoTypeInformation
