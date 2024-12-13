# bin/bash

IOCfile="$2"
accesslog="$1"

cat "$accesslog" | egrep -i -f "$IOCfile" | cut -d " " -f 1,4,7 | tr -d '[' > report.txt
