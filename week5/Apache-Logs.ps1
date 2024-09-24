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

function Get-Logs {
    $logsUnformatted = Get-Content -Path C:\xampp\apache\logs\access.log
    $records = @()
    for($i = 0; $i -lt $logsUnformatted.Count; $i++){
        $words = $logsUnformatted[$i].Split(' ')
        $records += [pscustomobject]@{"IP"=$words[0]; `
        "Time" = $words[3].Trim('[').Trim(']'); `
        "Method" = $words[5].Trim('"'); `
        "Page" = $words[6]; `
        "Protocol" = $words[7]; `
        "Response" = $words[8]; `
        "Referrer" = $words[2]; `
        "Client" = $words[11..($words.Count)];}
    }
    return $records | Where-Object {$_.IP -ilike "184.*"}
}
$records = Get-Logs
$records | Format-Table -AutoSize -Wrap