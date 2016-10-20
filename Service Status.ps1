$pcs = Get-Content C:\scripts\list.txt
$servers = Get-Content C:\scripts\servers.txt

foreach ($pc in $pcs){
    if (Test-Connection $pc -Count 1 -ErrorAction SilentlyContinue){
        Write-Host "online: $pc" -ForegroundColor Green}
    else{
        Write-Host "OFFLINE: $pc" -ForegroundColor Red}
}

foreach ($server in $servers){
    if((Invoke-WebRequest $server).StatusCode -eq '200'){
        Write-Host "online: $server" -ForegroundColor Green}
    else{
        Write-Host "OFFLINE: $server" -ForegroundColor Red}
}
Read-Host -prompt "Press Enter to close"
