#9 
$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://localhost/scrapeme.html
#$scraped_page

#10
#$scraped_page.Links

#11
#$scraped_page.Links | Select-Object -Property href,outerText

#12
$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object -Property outerText
#$h2s

#13
$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | `
    Where-Object {$_.IHTMLElement_className -eq "div-1"} | `
        Select-Object -Property innerText
$divs1