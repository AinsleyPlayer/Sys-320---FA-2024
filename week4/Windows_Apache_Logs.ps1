
# Q 1 - all apache logs
 Get-Content C:\xampp\apache\logs\access.log

# Q 2 - last 5 logs
 Get-Content C:\xampp\apache\logs\access.log -Tail 5


# Q 3

Get-Content C:\xampp\apache\logs\access.log | Select-String '404' , '400'



# Q 4

Get-Content C:\xampp\apache\logs\access.log | Select-String '200' -NotMatch



#Q 5

$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'
$A[5..-1]



# Q 6

$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String '404'

$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

$ipsUnorganized = $regex.Matches($notfounds)

$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{"IP" = $ipsUnorganized[$i].Value;}
    }
# $ips | Where-Object {$_.IP -ilike "10.*"}

# Q 8

$ipsoftens = $ips | Where-Object {$_.IP -ilike "10.*" }
$counts = $ipsoftens | Group IP


$counts | Select-Object Count, Name





