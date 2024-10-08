$scripts = Resolve-Path (Join-Path $PSScriptRoot ..\)
. (Join-Path $scripts "week5\Apache-Logs.ps1")
. (Join-Path $scripts "userManage\Event-Logs.ps1")
clear

$Prompt = "`nSelect one:`n"
$Prompt += "1 - Show last 10 Apache Logs.`n"
$Prompt += "2 - Show last 10 failed logins.`n"
$Prompt += "3 - Show at risk users.`n"
$Prompt += "4 - Go to champlain.edu.`n"
$Prompt += "5 - Exit.`n"

$choice = 0
while($choice -ne 5){
    Write-Host $Prompt | Out-String
    $choice = Read-Host
    
    if($choice -eq 1){
        $logs = Get-Logs
        Write-Host($logs | Sort-Object -Property Time | Out-String)
    } elseif($choice -eq 2){
        $fails = getFailedLogins 365
        $counts = ($fails | Group-Object -Property User)
        Write-Host ($counts | Format-Table | Out-String)
    } elseif($choice -eq 3){
        $fails = getFailedLogins 365
        $counts = ($fails | Group-Object -Property User | Where-Object {$_.Count -gt 9})
        Write-Host ($counts | Format-Table | Out-String)
    } elseif($choice -eq 4){
        $chromeProc = Get-Process -Name chrome -ErrorAction SilentlyContinue
        if(-not $chromeProc){
            Start-Process chrome -ArgumentList "https://champlain.edu"
        } else {
            Stop-Process -Name chrome
        }
    } elseif($choice -eq 5){
        Write-Host "Bye" | Out-String
        exit
    } else {
        Write-Host ("Please select a valid option." | Out-String)
    }
}