#Script and notes for second flight of learning R prog

#review loading data
#review subsetting and understand properly
#test by subbing to get new dataframe for all data on 10,000+ GPs in East of England
#how do I match in prev data for subset of GPs?
#how do I match in CCG names?
#generate summary plots...
#do some clustering analysis?

setwd("/Users/Tom/Documents/Coursera R/rawData/ONS Census 2011 bulk/Economic Activity/KS601ew_2011_oa/")
getwd()
# big ONS datafile u <- read.csv("KS601EWDATA.csv")

#use dir() to fine contents of directory

#load GP list size data
setwd("/Users/Tom/Documents/Coursera R/rawData")
getwd()
x <- read.csv("GPs/gp-reg-patients-01-2014.csv")

#use head() to see first few rows and check data
head(x,n=10)


#summarise variables
summary(x)
summary(x["TOTAL_ALL"])

#dealing with NAs
goods <- complete.cases(x)
summary(goods)
x <- x[goods,]


#############################
#### experimenting with subsets

# selecting only specific observations of a vector
x["TOTAL_ALL"][1:6,]

# subseting a named element
x$TOTAL_ALL

#subset of all GPs with 10,000+ and in Region code Y54
size <- (x$TOTAL_ALL > 10000)
loc <- (x$NHSE_REGION_CODE == "Y54")
sl <- size & loc
z <- x[sl,]
summary(z)

#rows of a subset. use row,col referencing. so rows 1:5 and no colref for the element NHSE_REGION_CODE
z[1:5,]["NHSE_REGION_CODE"]

summary(z$TOTAL_ALL)

#write a function to return the subset of observations that has total pop > x, and falls into CCG y
findGPs <- function(GPdata,listsize,ccg){
  size <- (GPdata$TOTAL_ALL > listsize)
  loc <- (GPdata$CCG_CODE == ccg)
  goods <- size & loc
  GPdata[goods,]

  
}
summary(findGPs(x,1000,"99P"))

#write a function that pulls out the mean of each numeric column of the subset identified by findGPs()
findmeans <- function(data, removeNA = TRUE ){
  nc <- ncol(data)
  means <- numeric(nc)
  for(i in 1:nc){
    means[i] <- mean(data[,i])
  }
  fields <- names(data)
  out <- rbind(fields,means)
  out
}


findmeans(x, TRUE)
  














