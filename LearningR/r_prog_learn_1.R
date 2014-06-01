setwd("/Users/Tom/Documents/Coursera R/rawData")
getwd()

x <- read.csv("GPs/gp-reg-patients-01-2014.csv")

setwd("/Users/Tom/Documents/Coursera R/Rworkspace/test1")


head(x,n=10)
tail(x,n=10)

summary(x)

str(x)

quantile(x["FEMALE_0.4"],na.rm = TRUE)

table(x["POSTCODE"], useNA="ifany")

sum(is.na(x["POSTCODE"]))
sum(is.na(x$POSTCODE))

colSums(is.na(x))

x[x$POSTCODE %in% c("WS9 8AJ"),"GP_PRACTICE_CODE"]

x[x$POSTCODE %in% c("WS9 8AJ"),c("GP_PRACTICE_CODE","POSTCODE","MALE_0.4")]

summary(x[10])

xt <- xtabs(Freq ~ MALE_0.4 + FEMALE_0.4, data=x)

#challenge: comparison of population pyramids for different GPs, Regions, CCGs etc...

summary(x$male_0.4)
