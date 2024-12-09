<# Q1
$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://localhost/ToBeScraped.html
$scraped_page.Links.Count


# Q2
$scraped_page.Links


# Q 3

$scraped_page.Links | Select outerText, href



# Q 4

$h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText
$h2s
#>

# Q 5

$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | 
where { $_.getAttributeNode("class").nodeValue -ilike "div-1"} | select innerText

$divs1
