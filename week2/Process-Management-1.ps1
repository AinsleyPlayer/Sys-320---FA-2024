# Q 1
Get-Process -ProcessName C*| Where-Object Name -ilike 'C*'

# Q 2

Get-Process | Where-Object {$_.Path -notlike 'system32*'}

# Q 3


$stopped = Get-Service | Where-Object {$_.Status -eq 'Stopped'} 
$sort = $stopped | Sort-Object -Property Name
$sort | Select-Object Status, Name, DisplayName | Export-Csv -Path "C:\Users\champuser\Sys-320---FA-2024\week2\Process.csv" -NoTypeInformation

# Q 4

$chrome = Get-Process | Where-Object {$_.name -ilike "Chrome"}
if($chrome -eq $null) {
 Start-Process -FilePath chrome.exe 'https://champlain.edu'
 }
else {
Stop-Process -name chrome

}
