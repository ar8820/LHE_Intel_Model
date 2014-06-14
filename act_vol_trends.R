
###################################################################################
###################################################################################
###################################################################################
#### Explore trends in activity volumes over time

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
#### prep data

#load data into memory
load("workingFiles/LHE_Intel.RData")

#summarise
summary(LHE_Intel)

#subset to just activity variables
act_vars <- c( "lsoa01cd","AE_1011","AE_1112","AE_1213","AE_1314","APC_1011",
               "APC_1112","APC_1213","APC_1314","OP_1011","OP_1112","OP_1213","OP_1314", "pop_all")
LHE_Act <- LHE_Intel[act_vars]


###################################################################################
#### calc volume per person










