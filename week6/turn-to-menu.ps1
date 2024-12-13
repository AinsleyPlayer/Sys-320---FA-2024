.(Join-Path $PSScriptRoot List_Of_Functions.ps1*)

clear

$Prompt = " Please select an option:"
$Prompt += " 1: Display last 10 Apache Logs"
$Prompt += " 2: Display last 10 failed logins for all users"
$Prompt += " 3: Display at risk users"
$Prompt += " 4: Start Chrome and go to champlain,edu"
$Prompt += " 5: Exit"

While($true){
    Write-Host $Prompt
    $choice = Read-Host


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        }

    elseif($choice -eq 1){
        parsing
        }

    elseif($choice -eq 2){
        failten
        }


    elseif($choice -eq 3){
        $days = Read-Host "Enter the number of days you want to look at."
        atRiskUsers $days
        }

    elseif($choice -eq 4){
        chrome
        }
    }

