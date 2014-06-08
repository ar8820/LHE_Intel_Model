
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


#load data into memory
load("LHE_Intel.RData")

#summarise
summary(LHE_Intel)


#histogram explore
hAE <- hist(subset(LHE_Intel$AE_1213, LHE_Intel$AE_1213<10000), 100, col = "BLUE")
hOP <- hist(subset(LHE_Intel$OP_1213, LHE_Intel$OP_1213<10000), 100, col = "BLUE")
hAPC <- hist(subset(LHE_Intel$APC_1213, LHE_Intel$APC_1213<10000), 100, col = "BLUE")

plot( hAE, col=rgb(0,0,1,1/4), xlim=c(10,8000), ylim=c(0,8000))  
plot( hOP, col=rgb(1,0,0,1/4), xlim=c(10,8000), ylim=c(0,8000), add=T)
plot( hAPC, col=rgb(0,1,0,1/4), xlim=c(10,8000), ylim=c(0,8000), add=T)


boxplot(subset(LHE_Intel$AE_1213, LHE_Intel$AE_1213<10000))



    