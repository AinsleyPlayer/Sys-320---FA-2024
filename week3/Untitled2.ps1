
#clear
#1
# Get-EventLog system -source Microsoft-Windows-winlogon

#2
<# $loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)
$loginouts
$loginoutsTable = @()
for($i=0; $i -lt $loginouts.count; $i++){

$event = ""
if($loginouts[$i].InstanceID -eq "7001") {$event="Logon"}
if($loginouts[$i].InstanceID -eq "7002") {$event="Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]
$user
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                        "Id" = $loginouts[$i].InstanceID;
                                         "Event" = $event;
                                            "User" = $user;
                        }


}

$loginoutsTable
#>

# Q 3
<#
$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-20)
$loginoutsTable = @()
for($i=0; $i -lt $loginouts.count; $i++){

$event = ""
if($loginouts[$i].InstanceID -eq "7001") {$event="Logon"}
if($loginouts[$i].InstanceID -eq "7002") {$event="Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]
$SecurityIdentifier = New-Object System.Security.Principal.SecurityIdentifier $user
$user = $SecurityIdentifier.Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                        "Id" = $loginouts[$i].InstanceID;
                                         "Event" = $event;
                                            "User" = $user;
                        }


}

$loginoutsTable
#>

# Q 4
# working on 

<#
$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-20)
$loginoutsTable = @()
for($i=0; $i -lt $loginouts.count; $i++){

$event = ""
if($loginouts[$i].InstanceID -eq "7001") {$event="Logon"}
if($loginouts[$i].InstanceID -eq "7002") {$event="Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]
$SecurityIdentifier = New-Object System.Security.Principal.SecurityIdentifier $user
$user = $SecurityIdentifier.Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                        "Id" = $loginouts[$i].EventID;
                                         "Event" = $event;
                                            "User" = $user;
                        }


}

$loginoutsTable

#>