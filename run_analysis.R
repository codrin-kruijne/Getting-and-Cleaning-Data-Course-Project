dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
library(dplyr)

## 1) Merges the training and the test sets to create one data set.

## Reading in the data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
## Reading in the features
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
names(X_train) <- features[,2]
names(X_test) <- features[,2]
names(subject_train) <- "subject"
names(subject_test) <- "subject"
names(y_train) <- "activity_label"
names(y_test) <- "activity_label"
## Merging data
train_subject_activity <- cbind(subject_train, y_train)
test_subject_activity <- cbind(subject_test, y_test)
merged_train <- cbind(train_subject_activity, X_train)
merged_test <- cbind(test_subject_activity, X_test)
merged_train["dataset"] <- "train"
merged_test["dataset"] <- "test"
merged_data <- rbind(merged_train, merged_test)

## 2) Extracts only the measurements on the mean and standard deviation for each measurement.
selected_data <- select(merged_data, subject, activity_label, ends_with("mean()"), ends_with("std()"))
### Rearranging rows by subject
selected_data <- arrange(selected_data, subject)

## 3) Uses descriptive activity names to name the activities in the data set
selected_data$activity_label <- factor(selected_data$activity_label, levels = activity_labels$V1, labels = activity_labels$V2)

## 4) Appropriately labels the data set with descriptive variable names.
colnames(selected_data) <- gsub("Body", "Body ", colnames(selected_data))
colnames(selected_data) <- gsub("Gravity", "Gravity ", colnames(selected_data))
colnames(selected_data) <- gsub("Jerk", "jerk ", colnames(selected_data))
colnames(selected_data) <- gsub("Acc", "accelerometer ", colnames(selected_data))
colnames(selected_data) <- gsub("Gyro", "gyroscope ", colnames(selected_data))
colnames(selected_data) <- gsub("Mag", "magnitude ", colnames(selected_data))
colnames(selected_data) <- gsub("std()", "standard deviation ", colnames(selected_data))
colnames(selected_data) <- gsub("mean()", "mean value ", colnames(selected_data))
colnames(selected_data) <- gsub(" \\(\\)$", "", colnames(selected_data))

### a function to check for the leading t and f and append a readable version
time_freq_rename <- function(column_name){
### if the column names starts with a "t", replace the word and apend readable version
    if(grepl("^t", column_name)){
      column_name <- paste(substring(column_name,2), "of time")
    }
### if the column names starts with a "f", replace the word and apend readable version
    else if(grepl("^f", column_name)){
      column_name <- paste(substring(column_name,2), "of frequency domain signal")
    }
  else {column_name}
}
colnames(selected_data) <- lapply(colnames(selected_data), time_freq_rename)

## 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
### After a lot of searching and trying I felt I had to group the data.frame1 and aaply a mean to all, which wass possible using dplyr pipe functions!
summarized <- selected_data %>% group_by(subject, activity_label) %>% summarize_all(mean)