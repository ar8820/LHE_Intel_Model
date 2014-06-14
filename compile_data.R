###################################################################################
###################################################################################
#### Compile and save


path <- file.path(drive, "workingFiles")
setwd(path)

###################################################################################
#load data into memory
load("HES_activity.RData")
load("full_LSOA_healthset.RData")


###################################################################################
#merge data 
LHE_Intel <- merge(HES_activity, full_LSOA_healthset, by = "lsoa01cd", all = TRUE)

###################################################################################
#drop MISSING LSOAs and all Scotish/Welsh LSOA codes (ie.keep only LSOAs starting with E)
#this is step has important inplications. Total volumes of activity are not longer large enough
#this is because a considerable volume of activity has no assigned LSOA.
#the steps below detail the volume of activity that is lost - A&E is considerable!!!

t_APC_incM = sum(LHE_Intel$APC_1213, na.rm = TRUE)
t_OP_incM = sum(LHE_Intel$OP_1213, na.rm = TRUE)
t_AE_incM = sum(LHE_Intel$AE_1213, na.rm = TRUE)


LHE_Intel <- subset(LHE_Intel, substring(LHE_Intel$lsoa01cd,1,1) == "E")


t_APC = sum(LHE_Intel$APC_1213, na.rm = TRUE)
t_OP = sum(LHE_Intel$OP_1213, na.rm = TRUE)
t_AE = sum(LHE_Intel$AE_1213, na.rm = TRUE)

p_APC_miss = (t_APC_incM - t_APC)/t_APC_incM
p_OP_miss = (t_OP_incM - t_OP)/t_OP_incM
p_AE_miss = (t_AE_incM - t_AE)/t_AE_incM

p_APC_miss
p_OP_miss
p_AE_miss



###################################################################################
#add IMD_deciles

LHE_Intel$IMD_decile <- cut(LHE_Intel$IMD_score_all, 
                            breaks=quantile(LHE_Intel$IMD_score_all, probs= seq(0,1,by= 0.1)), labels = FALSE)


###################################################################################
#save as .RData in workingFiles
path <- file.path(drive, "workingFiles")
setwd(path)
save(LHE_Intel, file = "LHE_Intel.RData")






