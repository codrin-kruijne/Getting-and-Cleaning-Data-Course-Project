dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

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
## 3) Uses descriptive activity names to name the activities in the data set
## 4) Appropriately labels the data set with descriptive variable names.
## 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.