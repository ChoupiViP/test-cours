# infos.ps1
$info = @{
    "Nom utilisateur" = $env:USERNAME
    "Nom du PC" = $env:COMPUTERNAME
    "IP" = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notlike "Loopback*"} | Select-Object -First 1 -ExpandProperty IPAddress)
    "MAC" = (Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1 -ExpandProperty MacAddress)
}
$info | ConvertTo-Json | Out-File "$env:TEMP\infos.json"
Start-Process "notepad.exe" "$env:TEMP\infos.json"
