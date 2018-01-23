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
Now, we add the subject and activity information as new columns to the measurement data sets. As these columns have the same names (V1) we will label them first with subject and activity respectively to avoid confusion when combining columns.table(y)
```
names(subject_train) <- "subject"
names(subject_test) <- "subject"
names(y_train) <- "activity_label"
names(y_test) <- "activity_label"
```

### Combining columns
Now we add the subject and activity columns to both the train and test sets.


### Combining rows


## Extracts only the measurements on the mean and standard deviation for each measurement.

## Uses descriptive activity names to name the activities in the data set

## Appropriately labels the data set with descriptive variable names.

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.




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
