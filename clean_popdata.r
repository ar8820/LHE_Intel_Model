###################################################################################
###################################################################################
###################################################################################
#### Clean population data  - properly

###Actions: add population data, convert robustly to LSOA01CD, calculate activity per person,
    #investigate trends over time and space




###################################################################################
###################################################################################
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
###################################################################################
#Initialize dataframe with all LSOAs
pop <- read.csv("LSOA/LSOA01_to_LSOA11.csv")


###################################################################################
###################################################################################
#merge in popultion data

path <- file.path(drive, "ONS/csvs")
setwd(path)


addfile <- dir()

years <- c(1011,1112,1213)
    
for (i in 1:length(years)){
        
    #raw data
    t <- read.csv(addfile[i])
    
    #set year
    year = years[i]
    
    #change colnames
        for (i in 2:length(names(t))){
            
            names(t)[i] <- paste(names(t)[i], year, sep = "_")
          
        }
        
    #merge to population data frame
    pop <- merge(pop, t, , by = "LSOA11CD", all = TRUE)

    #clean up (remove t)
    rm(t)
}

#remove entries with NA values for LSOA01CD - these are LSOA11CD codes that do not match to LSOA01CDs. Nothing I can
# do about them.

pop <- pop[complete.cases(pop),]


###################################################################################
###################################################################################
#convert to LSOA01CD

# need to write a script that loops over each numeric variable and replaces values if CNGIND
# is an S or an M, according to the logic below. All other values should be left as is.
# I think this is an lapply job or something similar
# not sure of the right way to do the conditional replacement
# shouldn't be too tricky, but it is!


pop1 <- pop[1:6]

pop1$all_ages_1011_S <- ave(pop1$all_ages_1011, pop1$LSOA01CD, FUN = sum)    
pop1$all_ages_1011_M <- pop1$all_ages_1011/ave(pop1$all_ages_1011, pop1$LSOA11CD, FUN = length)

pop1$all_ages_1011_N <- pop1$all_ages_1011
pop1$all_ages_1011_N[pop1$CHGIND == "S"] <- pop1$all_ages_1011_S[pop1$CHGIND == "S"]
pop1$all_ages_1011_N[pop1$CHGIND == "M"] <- pop1$all_ages_1011_M[pop1$CHGIND == "M"]

tname <- names(pop1)[6]

subset(pop1,pop1$CHGIND == "S", tname)


# loop over all numeric variables

for (i in 6:length(names(pop))){
    
    #generate new values
    S <- ave(subset(pop, select = names(pop)[i]), pop1$LSOA01CD, FUN = sum) 
    M <- subset(pop, select = names(pop)[i])/ave(subset(pop, select = names(pop)[i]), pop$LSOA11CD, FUN = length)
    #replace LSOA11CD values with LSOA01CD values
    
    
    
    
}









    
#if S, then 2011 values need to be added together to make 2001 values. So find the sum of all
# values where the LSOA01CD code repeats (because the same LSOA01CD split into multiple LSOA11CD)
pop1$all_ages_1011_S <- ave(pop1$all_ages_1011, pop1$LSOA01CD, FUN = sum)    


#if m, the 2011 values need to be divided by the number of repeats to get 2001 values. So divide
# values by number of repeated LSOA11CDs because the same LSOA11CD comes from multiple LSOA01CD
pop1$all_ages_1011_M <- pop1$all_ages_1011/ave(pop1$all_ages_1011, pop1$LSOA11CD, FUN = length)






