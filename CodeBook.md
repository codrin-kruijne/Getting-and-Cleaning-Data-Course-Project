---
title: "CodeBook"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# My first CodeBook for Coursera Data Science course project Getting and Cleaning Data
Assignment description at  https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project
Downloaded data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on January 20th 2018

```download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "projectfiles.zip")
downloadData <- now()
```
We load dopler intro the library for easy selection of data.
```
library(dplyr)
```

# Data manipulation steps from assignments

##    Merges the training and the test sets to create one data set.
First we read the data from the files; I chose similar names as the files for clarity.

```
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
## Reading in the features
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
```
We now have data frames with corresponding names and compatible dimensions. From the data source README file and exploring these dataframes we can conclude the following.

1. We have a training and testing set with 7352 and 2947 observations, respectively (X_train and X_test).
2. Both have 561 variables that corresponds to the number of features (features).
3. Each have a file describing the activity type (y_train and y_test) as detailed in activity_labels for each observation. 
4. Finally, we can identify the test subjects using subject_test and subject_train. 

Now we have an understanding of the data we are dealing with we can devise a strategy for combining it all.

### Labeling columns
To start we will use the given feature list (second column) to name the columns with their original labels, to make sure we can identify columns correctly.
```
names(X_train) <- features[,2]
names(X_test) <- features[,2]
```
### Adding subject and activity information
Now, we add the subject and activity information as new columns to the measurement data sets. As these columns have the same names (V1) we will label them first with subject and activity respectively to avoid confusion when combining columns.
```
names(subject_train) <- "subject"
names(subject_test) <- "subject"
names(y_train) <- "activity_label"
names(y_test) <- "activity_label"
```

### Combining columns
Now we combine the loose subject and activity columns.
```
train_subject_activity <- cbind(subject_train, y_train)
test_subject_activity <- cbind(subject_test, y_test)
```
Then we add the resulting subject and actiity columns to the measurements.
```
merged_train <- cbind(train_subject_activity, X_train)
merged_test <- cbind(test_subject_activity, X_test)

We add columns to the train and test sets to identify the type of measurement group.
```
merged_train["dataset"] <- "train"
merged_test["dataset"] <- "test"
````
### Combining rows
Merging train rows with test rows and just checking whether it is all there.
```
merged_data <- rbind(merged_train, merged_test)
table(merged_data[564])
```
This gives us a merge_data data frame with 10299 the combination of rows from train and test sets) observations or measurements and 564 variables (the original 561 plus one subject column, one activity type column and one column identifying whether it was from the train or test data set).

## Extracts only the measurements on the mean and standard deviation for each measurement.

```
selected_data <- select(merged_data, subject, activity_label, ends_with("mean()"), ends_with("std()"))
selected_data <- arrange(selected_data, subject)
```

## Uses descriptive activity names to name the activities in the data set
```
selected_data$activity_label <- factor(selected_data$activity_label, levels = activity_labels$V1, labels = activity_labels$V2)
```

## Appropriately labels the data set with descriptive variable names.
Ok this is a bit of a puzzle. Basically, what we want to do is to replace the abbreviations with readable text. Body, Gravity and Jerk are already spelled out completely.
Going through the variable list of the selected_data and the features_info.txt file that accompanied the data, this is what we can distill out of it:
1. the starting t and f denote time and frequency domain signal respectively
2. Acc is data from the Accelerometer
3. Gyro is data from the Gyroscope
4. Mag stands for magnitude of signal
To improve readability we also want to add spaces, remove parenthesis and rearrange the terms to be more readable.

### Applying textual changes to improve readability of column names
```
colnames(selected_data) <- gsub("Body", "Body ", colnames(selected_data))
colnames(selected_data) <- gsub("Gravity", "Gravity ", colnames(selected_data))
colnames(selected_data) <- gsub("Jerk", "jerk ", colnames(selected_data))
colnames(selected_data) <- gsub("Acc", "accelerometer ", colnames(selected_data))
colnames(selected_data) <- gsub("Gyro", "gyroscope ", colnames(selected_data))
colnames(selected_data) <- gsub("Mag", "magnitude ", colnames(selected_data))
colnames(selected_data) <- gsub("std()", "standard deviation ", colnames(selected_data))
colnames(selected_data) <- gsub("mean()", "mean value ", colnames(selected_data))
colnames(selected_data) <- gsub(" \\(\\)$", "", colnames(selected_data))

time_freq_rename <- function(column_name){
    if(grepl("^t", column_name)){
      column_name <- paste(substring(column_name,2), "of time")
    }
    else if(grepl("^f", column_name)){
      column_name <- paste(substring(column_name,2), "of frequency domain signal")
    }
  else {column_name}
}
colnames(selected_data) <- lapply(colnames(selected_data), time_freq_rename)
```

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

```
summarized <- selected_data %>% group_by(subject, activity_label) %>% summarize_all(mean)
```


## Submission
Upload your data set as a txt file created with write.table() using row.name=FALSE






## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
