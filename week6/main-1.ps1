﻿. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 9){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        # TODO: Create a function called checkUser in Users that: 
        #              - Checks if user a exists. 
        #              - If user exists, returns true, else returns false
        
        # TODO: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user

        if (checkUser $name){
            Write-Host "The user $name exists."
            continue
            }
            
        # TODO: Create a function called checkPassword in String-Helper that:
        #              - Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true
        # TODO: Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function

        else{
                if (checkPassword $password){
                    Write-Host "Password is secure"
                    $securePass = ConvertTo-SecureString -String $password -AsPlainText -Force
                }
                else {
                    Write-Host "Password is not secure"
                    continue
        }
        }





        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # TODO: Check the given username with the checkUser function.
        if (checkUser $name){

            removeAUser $name

            Write-Host "User: $name Removed." | Out-String
        }
        else {
            Write-Host "User: $name doesn't exist"
            continue
             
    }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO: Check the given username with the checkUser function.
        if (checkUser $name){
            enableAUser $name

            Write-Host "User: $name Enabled." | Out-String
        }
        else{
            Write-Host "User: $name does not exist"
            continue 

        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO: Check the given username with the checkUser function.

        if(checkUser $name){
            disableAUser $name

            Write-Host "User: $name Disabled." | Out-String
        }
        else {
            Write-Host "User: $name does not exist"
            continue
    }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.
        if (checkUser $name){
            $days = Read-Host "How many days do you want to be seen?"
            $userLogins = getLogInAndOffs $days
        }
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        else {
            Write-Host "User: $name does not exist"
            continue 
            }
            
            
        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

      
        # TODO: Check the given username with the checkUser function.
        if (checkUser $name){
             $days = Read-Host "How many days do you want to be seen?"
             $userLogins = getFailedLogins $days
             }
        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)

        # TODO: Change the above line in a way that, the days 90 should be taken from the user
        else {
            Write-Host "User: $name does not exist"
            continue 
            }

       
    }





    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers


    elseif($choice -eq 9){
        $days = Read-Host -Prompt "How many days would you like to see failed logins?"
        $failedLogins = getFailedLogins $days
        Write-Host ($failedLogins | Group-Object -Property user | Where-Object {$_.count -ge 10} | Format-Table -Property count, name | out-string)
    }

    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    
    else{
     Write-Host "Error, answer not accepted."
     continue
     }
}



