    function parsing (){
    $logsNotformatted = Get-Content C:\xampp\apache\logs\access.log
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
    return $tableRecords | Where-Object {$_.IP -ilike "10.*"} | select -first 10 | format-table -AutoSize -Wrap
}


function chrome{

    $chrome = Get-Process | Where-Object {$_.name -ilike "Chrome"}
    if($chrome -eq $null) {
        Start-Process -FilePath chrome.exe 'https://champlain.edu'
     }
    else {
        Stop-Process -name chrome

    }
}

function getFailedLogins($timeBack){
  
  $failedlogins = Get-EventLog security -After (Get-Date).AddDays("-"+"$timeBack") | Where { $_.InstanceID -eq "4625" }

  $failedloginsTable = @()
  for($i=0; $i -lt $failedlogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                                       "Id" = $failedlogins[$i].InstanceId; `
                                    "Event" = "Failed"; `
                                     "User" = $user;
                                     }

    }

    return $failedloginsTable
    }

function failten {
        $allLogs = getFailedLogins 10
        Write-Host ($allLogs | format-table | out-string)
        }

function atRiskUsers(){
        $days = Read-Host -Prompt "How many days would you like to see failed logins?"
        $failedLogins = getFailedLogins $days
        Write-Host ($failedLogins | Group-Object -Property user | Where-Object {$_.count -ge 10} | Format-Table -Property count, name | out-string)
    }
