clear
# Q 1 
# (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0"}).IPAddress

# Q 2

# (Get-NetIPAddress -AddressFamily  IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0"}).PrefixLength

# Q 3 & 4

# Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object

# Q 5 & 6

# Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer | Format-Table -HideTableHeaders

# Q 7

# (Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).ServerAddresses[0]

# Q 8 

#cd $PSScriptRoot

#$files=(Get-ChildItem)
#$files
#for ($j=0; $j -le $files.length; $j++){
#   if ($files[$j].Name -ilike "*ps1"){
#        Write-Host $files[$j].Name
#   }
#}

# Q 9

#$folderpath="PSScriptRoot\outfolder"
#if (Test-Path $folderpath){
#    Write-Host "Folder Already Exists"
#}
#else{
#    New-Item -ItemType "directory" -Path $folderpath
#}

# Q 10


# cd $PSScriptRoot
# $files=(Get-ChildItem)

# $folderpath= "$PSScriptRoot/outfolder/"
# $filePath = Join-Path $folderPath "out.csv"

# $files | Where-Object {$files[$j].Name -ilike "*.ps1" } | Export-Csv -Path $filePath

# Q 11

$files=Get-ChildItem -Recurse -File -Filter *.csv
$files | Rename-Item -NewName { $_.name -Replace  '\.csv', '.log' }
Get-ChildItem -Recurse -File -Filter *._log
