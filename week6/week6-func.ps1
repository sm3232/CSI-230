function gatherClasses(){
    $page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses.html
    $rows = $page.ParsedHtml.body.getElementsByTagName("tr")
    $table = @()
    for($i = 0; $i -lt $rows.length; $i++){
        $cols = $rows[$i].getElementsByTagName("td")
        if($cols.length){
            $times = $cols[5].innerText.Split('-')
            $table += [pscustomobject]@{"Class Code" = $cols[0].innerText; `
                                        "Title" = $cols[1].innerText; `
                                        "Days" = $cols[4].innerText; `
                                        "Time Start" = $times[0]; `
                                        "Time End" = $times[1]; `
                                        "Instructor" = $cols[6].innerText; `
                                        "Location" = $cols[9].innerText;}
        }
    }
    return $table
}

function daysTranslator($table){
    for($i = 0; $i -lt $table.Length; $i++){
        $Days = @()

        if($table[$i].Days -ilike "M"){$Days += "Monday"}
        
        if($table[$i].Days -ilike "*T[TWF]*"){$Days += "Tuesday"}
        ElseIf($table[$i].Days -ilike "T"){$Days += "Tuesday"}

        if($table[$i].Days -ilike "W"){$Days += "Wednesday"}

        if($table[$i].Days -ilike "TH"){$Days += "Thursday"}

        if($table[$i].Days -ilike "F"){$Days += "Friday"}

        $table[$i].Days = $Days

    }
    return $table


}