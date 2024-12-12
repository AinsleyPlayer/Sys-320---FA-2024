#bin/bash

url="10.0.17.6/IOC.html"

fullurlpage=$(curl -sL "$url")

output=$(echo "$fullurlpage" | \
xmlstarlet select --template --value-of \
"//html//body//table//tr")

echo "$output"
echo "$output" | sed 's/<\/tr>/\n/g' | sed -e 's/&amp;//g' | sed -e 's/<tr>//g' | sed -e 's/<td[^>]*>//g' | sed -e 's/<\/td>/;/g' | sed -e 's/<[/\]\{0,1\}a[^.]*>//g' | sed -e 's/<[/\]{0,1\}nobr>//g' \
>website.txt

sed -i '/^\s*$/d' website.txt | awk 'NR % 2 {print} !(NR % 2) && /pattern/ {print}' website.txt | sed 's/\t\t*//g' | sed '1d' > IOC.txt
