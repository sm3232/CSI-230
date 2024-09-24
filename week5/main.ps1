. (Join-Path $PWD.Path 'Apache-Logs.ps1')
$ips = Get-Ips -page 'index.html' -httpcode 200 -name 'Chrome'
$ips