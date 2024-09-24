function Get-Ips {
    param (
        $page,
        $httpcode,
        $name
    )


    $logs = Get-Content -Path C:\xampp\apache\logs\* -Filter *.log | Where-Object {($_ -match $page) -and ($_ -match $httpcode) -and ($_ -match $name)}
    $regex = [regex] "((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}"
    $logsMatch = $regex.Matches($logs)
    $res = @()
    for($i = 0; $i -lt $logsMatch.Count; $i++){
        $res += [pscustomobject]@{"IP" = $logsMatch[$i].Value;}
    }

    return ($res | Group-Object -Property IP) | Select-Object Count, Name
}