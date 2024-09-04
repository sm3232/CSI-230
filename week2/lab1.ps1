#1
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet"}).IpAddress

#2
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet"}).PrefixLength

#3/4
Get-WmiObject -List | Where-Object {$_.Name -ilike "Win32_Net*"} | Sort-Object

#5/6
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer | Format-Table -HideTableHeaders

#7
(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet"}).ServerAddresses[0]

#8

$files=(ls -Name)
for ($j=0; $j -lt $files.Length; $j++){
    if($files[$j].PSChildName -ilike "*.ps1"){
        Write-Host $files[$j]
    }
}

#9
$outfolderPath = "outfolder"
if(Test-Path -Path $outfolderPath){
    Write-Host "Folder Already Exists"
} else {
    New-Item -ItemType Directory -Path $outfolderPath
}

#10
$files=(Get-ChildItem -Path C:\Users -Filter *.ps1 -File -ErrorAction SilentlyContinue -Recurse)
$files | Export-Csv -Path $outfolderPath/out.csv

#11
ls *.csv -Recurse | Rename-Item -NewName {$_.Name -Replace '\.csv','.log'}
Get-ChildItem -Path "./" -Filter *.log -File -Recurse