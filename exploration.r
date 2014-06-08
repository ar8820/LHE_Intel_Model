
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
#### prep data

#load data into memory
load("LHE_Intel.RData")

#summarise
summary(LHE_Intel)

t_APC_incM = sum(LHE_Intel$APC_1213, na.rm = TRUE)
t_OP_incM = sum(LHE_Intel$OP_1213, na.rm = TRUE)
t_AE_incM = sum(LHE_Intel$AE_1213, na.rm = TRUE)

#drop MISSING LSOAs and all Scotish/Welsh LSOA codes (ie.keep only LSOAs starting with E)
    #this is step has important inplications. Total volumes of activity are not longer large enough
    #this is because a considerable volume of activity has no assigned LSOA.
    #the steps below detail the volume of activity that is lost - A&E is considerable!!!
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
#histogram to explore activity volumes

hAE <- hist(LHE_Intel$AE_1213, 100, col = "BLUE")
    #one v big outlier in the OP data, hence the 17000 limit
hOP <- hist(subset(LHE_Intel$OP_1213, LHE_Intel$OP_1213 < 17000) , 100, col = "BLUE")
hAPC <- hist(LHE_Intel$APC_1213, 100, col = "BLUE")

plot( hAE, col=rgb(0,0,1,1/4), xlim=c(0,8000) , ylim=c(0,6000))   
plot( hOP, col=rgb(1,0,0,1/4), add=T)
plot( hAPC, col=rgb(0,1,0,1/4), add=T)




###################################################################################
####boxplots by groups



#activity volume by rural/urban setting
    #set up plot
    par(mfrow = c(1,1))
    boxplot(LHE_Intel$OP_1213~LHE_Intel$ruc11, horizontal = TRUE, 
            names = levels(LHE_Intel$ruc11), las=2, 
            subset = LHE_Intel$OP_1213<16000,
            col=c("yellow","green","green","green","green","blue","blue","blue","blue"),
            par(mar=c(4,18,2,2)),
            at = c(1, 3,4,5,6, 8,9,10,11),
            varwidth= FALSE,
            outline=FALSE
    )


#activity volume by IMD decile
    #set up 3 cols
    par(mfrow = c(3,1))

    #OP volume by IMD decile
    boxplot(LHE_Intel$OP_1213~LHE_Intel$IMD_decile, horizontal = TRUE, las=2, 
            subset = LHE_Intel$OP_1213<16000,
            col = "green",
            par(mar=c(3,4,2,2)),
            notch = TRUE,
            #outline=FALSE,
            varwidth= FALSE,
            main = "Outpatient appointments",
            ylab = "IMD Decile"
            )

    #APC volume by IMD decile
    boxplot(LHE_Intel$APC_1213~LHE_Intel$IMD_decile, horizontal = TRUE, las=2, 
            subset = LHE_Intel$APC_1213<16000,
            col = "blue",
            par(mar=c(3,4,2,2)),
            notch = TRUE,
            #outline=FALSE,
            varwidth= FALSE,
            main = "Inpatient spells",
            ylab = "IMD Decile"
    )

    #AE volume by IMD decile
    boxplot(LHE_Intel$AE_1213~LHE_Intel$IMD_decile, horizontal = TRUE, las=2, 
            subset = LHE_Intel$AE_1213<16000,
            col = "yellow",
            par(mar=c(3,4,2,2)),
            notch = TRUE,
            #outline=FALSE,
            varwidth= FALSE,
            main = "A&E attendances",
            ylab = "IMD Decile"
    )
    

###################################################################################
####population density vs. activity

# High Density Scatterplot with Color Transparency and Hexbining of population density against activity

x <- subset(LHE_Intel$OP_1213, LHE_Intel$OP_1213<16000 )
y <- subset(LHE_Intel$pop_density, LHE_Intel$OP_1213<16000 )
#plot(x,y, col=rgb(0,100,0,50,maxColorValue=255), pch=16, main = "population density vs. OP activity")
bin<-hexbin(x, y, xbins=100) 
plot(bin, main = "population density vs. OP activity")

###################################################################################
####age strucutre vs. activity


x <- subset(LHE_Intel$OP_1213, LHE_Intel$OP_1213<16000 )
mean_age <- subset(LHE_Intel$age_mean, LHE_Intel$OP_1213<16000 )
med_age <- subset(LHE_Intel$age_median, LHE_Intel$OP_1213<16000 )
a65t74 <- subset(LHE_Intel$age_median, LHE_Intel$OP_1213<16000 )
a90up <- subset(LHE_Intel$age_90up_p, LHE_Intel$OP_1213<16000 )

#set up plot
par(mfrow = c(2,2))

plot(x,mean_age, col=rgb(0,100,0,40,maxColorValue=255), pch=16, main = "mean age vs. OP activity")
plot(x,med_age, col=rgb(100,0,0,40,maxColorValue=255), pch=16, main = "median age vs. OP activity")
plot(x, a65t74, col=rgb(0,0,100,40,maxColorValue=255), pch=16, main = "% 65 to 74 vs. OP activity")
plot(x, a90up, col=rgb(50,50,50,40,maxColorValue=255), pch=16, main = "% 90+ vs. OP activity")


###################################################################################
####experimental regressions

fit <- lm(OP_1213 ~ IMD_score_all + age_mean + (age_mean^2) + ru_flag + pop_density + lsoa , data = LHE_Intel)
summary(fit)
plot(fit)


