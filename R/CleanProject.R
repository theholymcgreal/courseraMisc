library(plyr)

rm(list=ls())
# check if project directory exists and download data
if(!file.exists("./project")){dir.create("./project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./project/dataset.zip")

# unzip to directory
unzip(zipfile = "./project/dataset.zip", exdir="./project")

# merging training and test sets into one data set
# read training tables
x_train <- read.table("./project/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./project/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./project/UCI HAR Dataset/train/subject_train.txt")

# read testing tables
x_test <- read.table("./project/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./project/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./project/UCI HAR Dataset/test/subject_test.txt")

# reading feature vector
features <- read.table("./project/UCI HAR Dataset/features.txt")

# reading activity labels
activityLabels <- read.table("./project/UCI HAR Dataset/activity_labels.txt")

#colnames
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId', 'activityType')

# merge data sets
train <- cbind(x_train, y_train, subject_train)
test <- cbind(x_test, y_test, subject_test)
allData <- rbind(train, test)

# read column names
colNames <- colnames(allData)

# defining ID
mean_and_std <- (grepl("activityId", colNames) |
                grepl("subjectId", colNames) |
                grepl("mean..", colNames) |
                grepl("std..", colNames)
                )
# subsetting
setMeanAndStd <- allData[,mean_and_std == T]

# use descriptive names
setActivityNames <- merge(setMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=T)
# create second data set
tidyData <- aggregate(. ~subjectId + activityId, setActivityNames, mean)
tidyData <- tidyData[order(tidyData$subjectId, tidyData$activityId),]

write.table(tidyData, "tidyData.txt", row.name=F)
















