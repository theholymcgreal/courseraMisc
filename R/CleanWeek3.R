# subsetting
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X
# subset specific column 
X[,1]
# subset by column name
X[,"var1"]
# subset by rows and columns
X[1:2,"var2"]
# logicals ands and ors
X[(X$var1 <= 3 & X$var3 > 11),]
X[(X$var1 <= 3 | X$var3 > 15),]
# dealing with NAs
X[which(X$var2 > 8),]
# sorting 
sort(X$var1)
sort(X$var1, decreasing = T)
sort(X$var2, na.last=T)
# ordering 
X[order(X$var1),]
X[order(X$var1, X$var3),]
# ordering with plyr
library(plyr)
arrange(X, var1)
arrange(X, desc(var1))
# adding rows and columns
X$var4 <- rnorm(5)
X
Y <- cbind(X, rnorm(5))
Y


# summarizing data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaraunts.csv", method="curl")
restData <- read.csv("./data/restaraunts.csv")
# looking at data
head(restData, n=3)
tail(restData, n=3)
summary(restData)
str(restData)
# quantiles of quantitative variables
quantile(restData$councilDistrict, na.rm=T)
quantile(restData$councilDistrict, probs=c(0.5,0.75,0.9))
# make tables
table(restData$zipCode, useNA = "ifany") # useNa to see if any missing values
table(restData$councilDistrict, restData$zipCode)
# checking for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
# row and column sums
colSums(is.na(restData))
all(colSums(is.na(restData))==0)
# values with specific characteristics
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),]
# cross tabs
data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt
# flat tables
warpbreaks$replicate <- rep(1:9, len=54)
xt = xtabs(breaks ~., data=warpbreaks)
xt
ftable(xt)
# size of a data set
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units='Mb')


# creating new variables
# creating sequences
s1 <- seq(1, 10, by=2) ; s1
s2 <- seq(1, 10, length=3); s2
x<- c(1,3,8,25,100); seq(along = x)
# subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
# creating binary variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)
# creating categorical variables
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode)) # cut applied to quantitative var 
table(restData$zipGroups)                                                     # and break it up according to quantiles
table(restData$zipGroups, restData$zipCode)
# easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups)
# creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)
# levels of factor variables
yesno <- sample(c("yes", "no"), size=10, replace=T)
yesnofac = factor(yesno, levels=c("yes","no"))  # creates level in certain order
relevel(yesnofac, ref="yes")  # reference is yes

as.numeric(yesnofac)  # change back to numeric
# using mutate function
library(Hmisc); library(plyr)
restData2 = mutate(restData, zipGroups=cut2(zipCode, g=4)) # new data fram ewith zipGroups added
table(restData2$zipGroups)
# common transforms
abs, sqrt, ceiling, floor, round, signif
cos, sin, log, log2, log10, exp


# reshaping data
library(reshape2)
head(mtcars)
# melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars=c("mpg", "hp")) # identify id and measure variables
head(carMelt, n=3)
tail(carMelt, n=3)
# casting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData
cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData
# averaging values
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum) # apply to count, along index spray, the function sum
# another way - split
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns
# another way - apply
sprCount = lapply(spIns, sum)
sprCount
# another way - combine
unlist(sprCount)
sapply(spIns, sum)
# another way - plyr package
library(plyr)
ddply(InsectSprays, .(spray), summarize, sum=sum(count))
# creating a new variable
spraySums <- ddply(InsectSprays, .(spray), summarize, sum=ave(count, FUN= sum))
dim(spraySums)



# managing data frames with dplyr
library(dplyr)
chicago <- readRDS("chicago.rds")
head(chicago)
dim(chicago)
str(chicago)
names(chicago)
# select
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))
# filter
chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f, 10)
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)
# arrange
chicago <- arrange(chicago, date)
head(chicago)
tail(chicago)
chicago <- arrange(chicago, desc(date))
head(chicago)
# rename
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)
# mutate
chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25, na.rm = T))
head(select(chicago, pm25, pm25detrend))
# group by
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
hotcold
# summarize
summarize(hotcold, pm25 = mean(pm25), o3 = max(o3tmean2), no2 = median(no2tmean2))
summarize(hotcold, pm25 = mean(pm25, na.rm=T), o3 = max(o3tmean2), no2 = median(no2tmean2))
# summary by year
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = T), o3 = max(o3tmean2), no2 = median(no2tmean2))
# summary of pollutant variables by month
# pipeline operator
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25, na.rm=T), o3 = max(o3tmean2), no2 = median(no2tmean2))



# merging data
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile="./data/reviews.csv", method="curl")
download.file(fileUrl2, destfile="./data/solutions.csv", method="curl")
reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews, 2)
head(solutions, 2)
# merging data
names(reviews)
names(solutions)
mergedData = merge(reviews, solutions, by.x="solution_id", by.y="id", all = T)
head(mergedData)
# default merges all common colum names
intersect(names(solutions), names(reviews))
mergedData2 = merge(reviews, solutions, all = T)
head(mergedData2)
# join in plyr package
df1 = data.frame(id = sample(1:10), x=rnorm(10))
df2 = data.frame(id = sample(1:10), y=rnorm(10))
arrange(join(df1, df2), id)
# if there is multiple data frames
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),y=rnorm(10))
dfList = list(df1, df2, df3)
join_all(dfList)

