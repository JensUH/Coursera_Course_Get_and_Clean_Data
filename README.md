# Coursera_Course_Get_and_Clean_Data

This is a repo for the project of the Coursera course "Getting and Cleaning Data". In this readme file the functioning of the R script "run_analysis.R" and the codebook "Codebook.md" are briefly described.

Based on the "Human Activity Recognition Using Smartphones Data Set" (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#) from the UCI Machine Learning Repository the "run_analysis.R" script creates a new tidy data set written to the file "Tidy DataSet.txt". The script assumes that the current working directory is the "UCI HAR Dataset" folder of the downloaded data set. 

First the script reads in the training part of the data set, adds columns for subject id and activity. Then it does the same for the test part of the data set. Afterwards the training and test data sets are merged into one data set. Following this, the data set is subsetted to a new data set only containing variables involving means and standard deviations and variables are properly named. Finally, a tidy data set with the average of each variable for each activity and each subject is created and written to the file "TidyDataSet.txt".

For a detailed description of the script see the comments in the script file "run_analysis.R".

To read back the tidy data file produced "TidyDataSet.txt" use following R code (assuming that the file is placed in your current working directory:
> read.table("./TidyDataSet.txt", header = TRUE)

Concerning the final data set a few assumptions are made. As I am unaware of the physics involved in producing the data set, some potentially naive design choices have been made concerning: 1) Choosing the columns involving data on means and standard deviations, and 2) the creation of descriptive variable names. For 1) the design choice have been to only include columns involving "mean()" or "std()" in their name. For 2) the design choice have been to use "tocamel" to get rid of "-", "()" and other illegal name characters.

The codebook "Codebook.md" describes each of the remaining variables in the tidy data set and their units.