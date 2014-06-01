###################

# Plan is to create an interactive web app that allows the user to explore 
# the LOSA modeling dataset
# It should include maps of small areas or the UK
# It should inlcude regression results calculated on the fly depending 
# on the variables chosen
# It should inlcude simple data point comparison tools such as:
#   compare LSOA X to the rest across various metrics
# 



#load GP list size data
setwd("/Users/Tom/Documents/Coursera R/rawData")
getwd()
x <- read.csv("GPs/gp-reg-patients-01-2014.csv")

#use head() to see first few rows and check data
head(x,n=10)

#remove troublesome NAs
use <- complete.cases(x)
x <- x[use,]


#experimenting with lapply, sapply, apply etc...
# 
# working with apply: using 1, preserves the first dimension (rows), using 2 preserves
# the second dimension (cols). Syntax is apply(data,dimension to preserve, funciton, 
#                                              functions arguments)


nums <- sapply(x, is.numeric)

y <- apply(x[nums],2,mean)

y <- colSums(x[nums])
y


# #tapply  is used to do bysort: egen style calculaitons
#  tapply can be used to calculate something like the average for certain groups
# you need a index variable (like a factor variable or logical) to subcategorise the 
# varible or data you want to apply the function to.
# 
# tapply (data, index, function, function arguments, simplify?)
# 

#eg. find the average list size for each CCG

use <- x$CCG_CODE

avCCGlist <- tapply(x$TOTAL_ALL, x$CCG_CODE, is.na, simplify = FALSE )
avCCGlist


### using split
# split is an easy way to breakup at dataset or matrix by a factor varibale
# or by a comination of factor variables
# split(dataset, factor varible to split by, drop = TRUE (to remove
#                                                         empty factors when 
#                                                         using interactions))
# 
# 
# use interaction(f1,f2) to create a combined factor variable

z <- split(x, x$NHSE_REGION_CODE)

head(z[[2]],10)




