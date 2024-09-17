. (Join-Path $PWD.Path 'week3funcs.ps1')
clear

$loginoutsTable = Get-LogInOuts(15)
$loginoutsTable

$shutdownsTable = Get-StartShuts(25)
$shutdownsTable
