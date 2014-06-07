
###################################################################################
###################################################################################
###################################################################################
#### Explore LHE intel data


#Identify OS and set working directory
choose.OS <- function(x) 
    return(
        if(x=="Windows") drive <- "C:/Users/899159/Documents/110. BD - Health/LHE Intel Model/Data" 
        else if(x=="Darwin") drive <- "/Users/Tom/Documents/Coursera R/Rworkspace/LHE_Intel_Model/Data"
    )

drive <- choose.OS(Sys.info()["sysname"])

setwd(drive)
getwd()

###################################################################################
#### Pull in data

path <- file.path(drive, "workingFiles")
setwd(path)
load("HES_activity.RData")

###################################################################################
#### exploratory analysis

d <- HES_activity

head(d, 10)

summary(d)








    