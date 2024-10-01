. (Join-Path $PWD.Path 'week6-func.ps1')
#$table = daysTranslator(gatherClasses)
# i
#$table | Where-Object {$_.Instructor -match "Furkan Paligu"}

# ii
#$table  | Where-Object {($_.Location -match "JOYC 310") -and ($_.Days -contains "Monday")} | `
#    Sort-Object "Time Start" | `
#    Select-Object "Time Start", "Time End", "Class Code"

# iii
#$ITS = $table | Where-Object {$_."Class Code" -match ".*(SYS|NET|SEC|FOR|CSI|DAT)+.*"} | `
#    Sort-Object "Instructor" | Select-Object "Instructor" -Unique
#$ITS

# iv
$table | Where-Object {$_.Instructor -in $ITS.Instructor} | `
    Group-Object "Instructor" | Select-Object Count,Name | Sort-Object Count -Descending
