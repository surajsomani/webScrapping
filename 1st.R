setwd("D:/machine learning/adhoc webscrapping/")

library(stringr)
library(rvest)
library(dplyr)
library(reshape2)
library(googleVis)
library(gtools)
url <- "https://villageinfo.in/telangana/adilabad.html"
html <- paste(readLines(url), collapse="\n")
matched <- as.data.frame(str_match_all(html, "<a href=\"(.*?)\""))
matched1 = matched[-c(1, 2, 3,4,nrow(matched),(nrow(matched)-1),(nrow(matched)-2)), ] 
matched1$X1 = NULL
rm(matched)
rm(html)
rm(url)

rownames(matched1) <- 1:nrow(matched1)

for(i in 5:nrow(matched1)-3){
  matched1$X2 = as.character(matched1$X2)
  html <- paste(readLines(matched1[1,]), collapse="\n")
  matched <- as.data.frame(str_match_all(html, "<a href=\"(.*?)\""))
  #4,46
  matched2 = matched[-c(1, 2, 3,4,c((nrow(matched)-19):nrow(matched))), ] 
  matched2$X1 = NULL
  rownames(matched2) <- 1:nrow(matched2)
  matched2$X2 = as.character(matched2$X2)
  rm(matched)
  rm(html)
  rm(url)
  #matched1 = as.matrix(matched1)
  for(j in 1:nrow(matched2))
  {
    webpage <- read_html(matched2[1,])
    data <- webpage %>%
      html_nodes("table") %>%
      .[[1]] %>%
      html_table()
    
    n <- data$X1
    t1 <- as.data.frame(t(data[,-1]))
    colnames(t1) <- n
    t1 = t1[,-1]
    if(i<2 && j<2)
    {
      value = t1
    }
    else
    {
    value = smartbind(value, t1)
    }
    rm(data)
    rm(matched2)  
    rm(t1)
    rm(n)
    rm(webpage)
  }
}

