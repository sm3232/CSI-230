# 1
Get-Process C*


# 2
Get-Process | Where-Object {$_.Path -match "system32"} | Format-Table *


# 3
Get-Service | Where-Object {$_.Status -eq "Stopped"} | Sort-Object -Property DisplayName | Export-Csv -Path "stopped.csv"


# 4
$chromeProcess = Get-Process -Name chrome -ErrorAction SilentlyContinue
if(-not $chromeProcess){
    Start-Process chrome -ArgumentList "https://champlain.edu"
} else {
    Stop-Process -Name chrome
}