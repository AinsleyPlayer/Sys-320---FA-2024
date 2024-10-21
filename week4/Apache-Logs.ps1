
Function ApacheLogs ($page , $code , $name){

$getinputs = Get-Content C:\xampp\apache\logs\access.log
$matching = $getinputs | Select-String "$page" | Select-String "$code" | Select-String "$name"

$ipsUnorganized = $regex.Matches($matching)
$table = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
$table += [pscustomobject] @{"IP" = $ipsUnorganized[$i].Value;
                                "Page" = $page;
                                 "Code Returned" = $code;
                                 "Browser Name" = $name;
                                 }
                }

$table
}

ApacheLogs "index.html" "200" "Chrome"