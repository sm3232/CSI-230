cd C:\xampp\apache\logs\
#3 
Get-Content access.log

#4
Get-Content access.log -Tail 5

#5
Get-Content access.log | Where-Object { $_ -match ' 400 | 404 ' }

#6
Get-Content access.log | Where-Object { $_ -notmatch ' 200 ' }

#7

$A = Get-Content -Path C:\xampp\apache\logs\* -Filter *.log | Where-Object {$_ -match 'error'}
$A[-5..-1]

#8
$notfounds = Get-Content access.log | Where-Object { $_ -match ' 404 ' }
$regex = [regex] "((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}"
$ipsUnorganized = $regex.Matches($notfounds)
$ips = @()
for($i = 0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{"IP" = $ipsUnorganized[$i].Value;}
}

#9
$count = ($ips | Group-Object -Property IP) | Select-Object Count, Name
$count