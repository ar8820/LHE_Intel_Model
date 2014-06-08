###################################################################################
###################################################################################
#### Compile and save


path <- file.path(drive, "workingFiles")
setwd(path)


#load data into memory
load("HES_activity.RData")
load("full_LSOA_healthset.RData")

#merge data 
LHE_Intel <- merge(HES_activity, full_LSOA_healthset, by = "lsoa01cd", all = TRUE)

#save as .RData in workingFiles
path <- file.path(drive, "workingFiles")
setwd(path)
save(LHE_Intel, file = "LHE_Intel.RData")






