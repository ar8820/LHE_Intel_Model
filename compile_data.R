
###################################################################################
###################################################################################
#### Complie and save HES activity by LSOA data

library("stringr")

#vector for list of filenames
addfile <- dir("HES")


#Initialize dataframe with all LSOAs
HES_activity <- read.table("LSOA/LSOA_code_all.csv", header = TRUE, sep = ",")


#loop over each file, process and add to the new dataframe
path <- file.path(drive, "HES")
setwd(path)

for (i in 1:length(addfile)){
    
    
    #add file to tempframe t
    t <- read.table(addfile[i], header = TRUE, sep = ",")
    
    #replace missing LSOAs with MISS id
    levels(t$SOAL)[t$SOAL == ""] <- "MISS"
    
    #find year and activity type
    year <- t[[1,1]]
    acttype <- str_extract(addfile[i],"OP|APC|AE")
    
    #change column names and types
    names(t)[names(t)=="X_FREQ_"] <- paste(acttype, year, sep = "_")
    names(t)[names(t)=="SOAL"] <- "LSOA_code"
    
    
    #drop year column
    t$fiscal_year <- NULL
    
    #merge to activity data frame
    HES_activity <- merge(HES_activity, t, all = TRUE)
    
}    

# save as .Rda
path <- file.path(drive, "workingFiles")
setwd(path)
save(HES_activity, file = "HES_activity.RData")


