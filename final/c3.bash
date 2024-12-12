# bin/bash

fileused="report.txt"
outputhtml="/var/www/html/report.html"

echo "<html>" > $outputhtml | echo "<body>" >> $outputhtml | echo "<table border='1'>" >> $outputhtml

while IFS= read -r line; do
	echo "<tr><td>$line</td></tr>" >> $outputhtml
done < $fileused

echo "</table>" >> $outputhtml | echo "</body>" >> $outputhtml | echo "</html>" >> $outputhtml

mv $outputhtml /var/www/html/
