library(XML)
url <- "https://villageinfo.in/telangana/adilabad/adilabad/ankapoor.html"
table1 = readHTMLTable(url, header=F, which=1,stringsAsFactors=F)