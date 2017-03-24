setwd("D:/machine learning/adhoc webscrapping/")

library(stringr)
library(rvest)
library(dplyr)
library(reshape2)
library(googleVis)
library(gtools)
k=1
url <- "https://villageinfo.in/andhra-pradesh/east-godavari.html"
tryCatch(html <- paste(readLines(url), collapse="\n"))
matched1 <- as.data.frame(str_match_all(html, "<a href=\"(.*?)\""))
matched1$X1 = NULL
url1 = substr(url,1,nchar(url)-5)
url1 = paste0(url1,"/")
matched1 <- as.data.frame(matched1[grep(url1, matched1$X2, perl=TRUE), ])
colnames(matched1) = "X2"
matched1$X2 = as.character(matched1$X2)
rownames(matched1) <- 1:nrow(matched1)
for(i in 1:nrow(matched1)){
  tryCatch(html <- paste(readLines(matched1[i,]), collapse="\n"))
  try(matched2 <- as.data.frame(str_match_all(html, "<a href=\"(.*?)\"")))
  matched2$X1 = NULL
  matched2$X2 = as.character(matched2$X2)
  
  #4,46
  try(matched2 <- as.data.frame(matched2[grep(url1, matched2$X2, perl=TRUE), ]))
  colnames(matched2) = 'X2'
  matched2$X2 = as.character(matched2$X2)
  url2 = matched2[1,]
  url3 = substr(url2,1,nchar(url2)-5)
  url3 = paste0(url3,"/")
  try(matched2 <- as.data.frame(matched2[grep(url3, matched2$X2, perl=TRUE), ]))
  colnames(matched2) = 'X2'
  matched2$X2 = as.character(matched2$X2)
  if(dim(matched2)[1]==0){ next}
  rownames(matched2) <- 1:nrow(matched2)
  for(j in 1:nrow(matched2))
  {
    
    tryCatch(webpage <- read_html(matched2[j,]))
    if((i!=5 && j!=3)&&(i!=19 && j!=1)&&(i!=31 && j!=33)&&(i!=37 && j!=14)&&(i!=40 && j!=2)&&(i!=44 && j!=63)&&(i!=52 && j!=5))
    {
      
      tryCatch(
        {data <- webpage %>%
          html_nodes("table") %>%
          .[[1]] %>%
          html_table()
        })  
    }
    n <- data$X1
    t1 <- as.data.frame(t(data[,-1]))
    colnames(t1) <- n
    colnames(t1)[1]<-"Gram Panchayat"
    if(k==1)
    {
      value = t1
    }
    else
    {
      value = smartbind(value, t1)
    }
    k=k+1
    rownames(value) <- 1:nrow(value)
    
  }
  
}
write.csv(value,file = "east_godavari_2s.csv")
