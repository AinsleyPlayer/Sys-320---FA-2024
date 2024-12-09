<#Challenge 1

function GetIOC {

$webpage = Invoke-WebRequest -TimeoutSec 5 -Uri http://10.0.17.6/IOC.html

$trs=$webpage.ParsedHtml.body.getElementsByTagName("tr")

$completeTable = @()

for ($i=0; $i -lt $trs.length; $i++){
    $tds = $trs[$i].getElementsByTagName("td")
    $completeTable += [pscustomobject]@{
    "Pattern" = $tds[0].innerText.Trim()
    "Explanation" = $tds[1].innerText.Trim()
    }
}

return $completeTable

}

$completeTable = GetIOC
$completeTable | Format-Table -Autosize -Wrap


#>


#Challenge 3

function Challenge3 (){
$logsNotformatted = Get-Content C:\Users\champuser\Downloads\access.log
$tableRecords = @()

for ($i=0; $i -lt $logsNotformatted.Count; $i++){

$words = $logsNotformatted[$i].Split(" ");

$tableRecords += [pscustomobject]@{ "IP" = $words[0];
                                    "Time" = $words[3].Trim('[');
                                    "Method" = $words[5].Trim('"');
                                    "Page" = $words[6];
                                    "Protocol" = $words[7];
                                    "Response" = $words[8];
                                    "Referrer" = $words[10];
                                    "Client" = $words[11..($words.LongLength)]; }
            }
return $tableRecords | Where-Object {$_.IP -ilike "10.*" -and $_.Response -eq "200"}
}
$tableRecords = Challenge3
$tableRecords | Format-Table -AutoSize -Wrap





#Challenge 3

