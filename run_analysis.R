## --- Course Project - Getting and Cleaning Data
## --- Script Name: run_analysis.R

## --- 1.Merges the training and the test sets to create one data set
## --- 2.Extracts only the measurements on the mean and standard deviation for each measurement
## --- 3.Uses descriptive activity names to name the activities in the data set
## --- 4.Appropriately labels the data set with descriptive variable names
## --- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity 
## ----   and each subject


## --- Download the zip file and unzip the file in UCI HAR Dataset directory
library(RCurl)
url <-
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
downloadDir <-
        "C:\\temp1\\Coursera\\Getting and Cleaning Data\\Week3\\Project"
path <- function(...) {
        paste(..., sep = "/")
}
zipFile <- path(downloadDir, "UCI-HAR-dataset.zip")
if (!file.exists(zipFile)) {
        download.file(url, zipFile)
}
dataDir <- path(downloadDir, "UCI HAR Dataset")
if (!file.exists(dataDir)) {
        unzip(zipFile, exdir = downloadDir)
}


## --- 1.Merges the training and the test sets to create one data set
## --- Training/Test measurements are read into different variables
## --- Merging of both sets using rbind
read <- function(path) {
        read.table(path(dataDir, path))
}

if (!exists("XTrain")) {
        XTrain <- read("train/X_train.txt")
}
if (!exists("XTest"))  {
        XTest  <- read("test/X_test.txt")
}
merged <- rbind(XTrain, XTest)

featureNames <- read("features.txt")[, 2]
names(merged) <- featureNames


## --- 2.Extracts only the measurements on the mean and standard deviation for each measurement.
## --- Features are filtered using grep containing "mean" or "std"
matches <- grep("(mean|std)\\(\\)", names(merged))
limited <- merged[, matches]


## --- 3.Uses descriptive activity names to name the activities in the data set
## --- Get the activity data and map to appropriate names
yTrain <- read("train/y_train.txt")
yTest  <- read("test/y_test.txt")
yMerged <- rbind(yTrain, yTest)[, 1]
activityNames <-
        c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
activities <- activityNames[yMerged]


## --- 4.Appropriately labels the data set with descriptive variable names
## --- Change t to Time, f to Frequency, mean() to Mean and std() to StdDev
## --- Remove extra dashes and other naming error from original feature names
names(limited) <- gsub("^t", "Time", names(limited))
names(limited) <- gsub("^f", "Frequency", names(limited))
names(limited) <- gsub("-mean\\(\\)", "Mean", names(limited))
names(limited) <- gsub("-std\\(\\)", "StdDev", names(limited))
names(limited) <- gsub("-", "", names(limited))
names(limited) <- gsub("BodyBody", "Body", names(limited))

## --- Add activities and subject with appropriate names
subjectTrain <- read("train/subject_train.txt")
subjectTest  <- read("test/subject_test.txt")
subjects <- rbind(subjectTrain, subjectTest)[, 1]
tidy <- cbind(Subject = subjects, Activity = activities, limited)


## --- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
## --- Column means for all but the subject and activity columns
library(plyr)
limitedColMeans <- function(data) {
        colMeans(data[,-c(1,2)])
}
tidyMeans <- ddply(tidy, .(Subject, Activity), limitedColMeans)
names(tidyMeans)[-c(1,2)] <-
        paste0("Mean", names(tidyMeans)[-c(1,2)])


## --- Write output to a file
library(data.table) 
write.table(tidyMeans, "tidyMeansdata.txt", row.names = FALSE)
tidyMeansCheck <- read.table("tidyMeansdata.txt", header = TRUE)
