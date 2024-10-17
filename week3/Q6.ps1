.(Join-Path $PSScriptRoot Functions_And_Event_Logs.ps1)

#clear


$loginoutsTable = GetLoginEvents -15
$loginoutsTable

$startorstopTable = StartStopEvents -25
$startorstopTable