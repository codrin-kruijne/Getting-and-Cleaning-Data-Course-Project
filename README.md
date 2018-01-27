# Getting-and-Cleaning-Data-Course-Project

This is a README file for the Coursera Data Science Getting and Cleaning Data Course project
https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

## Files in Git repository

run_analysis.R holds the scipt I have written for the assignment following the steps suggested
tidy_data.txt is the resulting data set after applying run_analysis.R to the extracted data.
CodeBook.md describes the variables of the resulting tidy data set and all the steps I took to get to the tidy data set.

## Please note
For the script to work you need to extract the zipfile from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into your working directory, using the zip internal structure.

## Review criteria

1) The submitted data set is tidy.
Yeas it is, according to the guidelines from the course. Let's check!
- Each variable you measure should be in one column. Yes; we have columns for identifying the subject, the activity and means of measurements (18), alltogether 20.
- Each different observation of that variable should be in a different row. Yes; we have rows for each subject (30) and each activity (6) totalling 180 observations.
- There should be atable for each "kind" of variable. Yes; it is a table with smartphone movement measures.
- If you have multiple tables ... not required.

2) The Github repo contains the required scripts.
Yes you can find all the details here:
https://github.com/codrinkruijne/Getting-and-Cleaning-Data-Course-Project/blob/master/run_analysis.R

3) GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
https://github.com/codrinkruijne/Getting-and-Cleaning-Data-Course-Project/blob/master/CodeBook.md

4) The README that explains the analysis files is clear and understandable.
https://github.com/codrinkruijne/Getting-and-Cleaning-Data-Course-Project/blob/master/README.md

5) The work submitted for this project is the work of the student who submitted it.
Sure; check out all my commits :-)!