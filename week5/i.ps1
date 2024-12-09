function gatherClasses() {
$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.10/Courses-1.html
$trs=$page.ParsedHtml.body.getElementsByTagName("tr")
$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){
     $tds = $trs[$i].getElementsByTagName("td")
     $Time = $tds[5].innerText.split("-")
     $FullTable += [pscustomobject]@{ "Class Code" = $tds[0].innerText;
                                        "Title"       = $tds[1].innerText;
                                        "Days"        = $tds[4].innerText;
                                        "Time Start"  = $Time[0];
                                        "Time End"    = $Time[1];
                                        "Instructor"  = $tds[6].innerText;
                                        "Location"    = $tds[9].innerText;
                                         }
                        }
return $FullTable
}


function daysTranslator($FullTable){
for($i=0; $i -lt $FullTable.length; $i++){
     $Days = @()
        if($FullTable[$i].Days -ilike "*M*"){$Days += "Monday"}
        if($FullTable[$i].Days -ilike "*T[T,W,F]*"){$Days += "Tuesday"}
        if($FullTable[$i].Days -ilike "*W*"){$Days += "Wednesday"}
        if($FullTable[$i].Days -ilike "*TH*"){$Days += "Thursday"}
        if($FullTable[$i].Days -ilike "*F*"){$Days += "Friday"}
        $FullTable[$i].Days = $Days
}

return $FullTable
}



#$result = gatherClasses
#$result

#$DayTable = daysTranslator $result
#$DayTable