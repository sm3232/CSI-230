# 1, 2, 3, 4
function Get-LogInOuts {
    param (
        $days
    )
    $loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)
    $loginoutsTable = @()
    for($i = 0; $i -lt $loginouts.Count; $i++){
        $event = ""
        if($loginouts[$i].InstanceId -eq 7001) {$event = "Logon"}
        if($loginouts[$i].InstanceId -eq 7002) {$event = "Logoff"}
        $user = $loginouts[$i].ReplacementStrings[1]
        $sid = New-Object System.Security.Principal.SecurityIdentifier($user)
        $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                             "Id" = $loginouts[$i].EventID; `
                                             "Event" = $event; `
                                             "User" = $sid.Translate([System.Security.Principal.NTAccount]).Value
                                             }
    }
    return $loginoutsTable
}

function Get-StartShuts {
    $startshuts = Get-WinEvent -LogName System | Where-Object {($_.Id -eq 6006) -or ($_.Id -eq 6005)}
    $startshutsTable = @()
    for($i = 0; $i -lt $startshuts.Count; $i++){
        $startshutsTable += [pscustomobject]@{"Time" = $startshuts[$i].TimeGenerated; `
                                              "Id" = $startshuts[$i].Id; `
                                              "Event" = If ($startshuts[$i].Id -eq 6006) {"Shutdown"} Else {"Startup"}; `
                                              "User" = "System";
                                             }
    }
    return $startshutsTable
}
