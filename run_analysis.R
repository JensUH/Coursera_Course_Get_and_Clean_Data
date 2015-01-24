# This the R script file for project of the Coursera course "Getting and Clearning Data"
# The script assumes that it is placed in the "UCI HAR Dataset" folder with the dataset. 



# Part 1:

# First the variable names are read into "var_names" as a matrix with two columns - the
# first being the number and the section being the name.
var_names <- read.table("./features.txt", header = FALSE, sep=" ", colClasses = "character")

# We now read in the training data set
train_data <- read.table("./train/X_train.txt", header = FALSE)

# We add the variable names as column names to the training data - remember that the names
# are in the second column of "var_names"
names(train_data) <- var_names[, 2]

# We read in the subject id's from "subject_train.txt"
train_subjects <- read.table("./train/subject_train.txt", header = FALSE)

# We name the columns of subject ids, "SubjectID"
names(train_subjects) <- "SubjectID"

# We add the column of subject ids to the training data set
train_data <- cbind(train_data, train_subjects)

# We read in the activity type from "y_train.txt"
train_activity <- read.table("./train/y_train.txt", header = FALSE)

# We name the columns of activity type, "Activity"
names(train_activity) <- "Activity"

# We add the column of activities to the training data set
train_data <- cbind(train_data, train_activity)

# We now do exactly the same steps for the test data set
test_data <- read.table("./test/X_test.txt", header = FALSE)
names(test_data) <- var_names[, 2]
test_subjects <- read.table("./test/subject_test.txt", header = FALSE)
names(test_subjects) <- "SubjectID"
test_data <- cbind(test_data, test_subjects)
test_activity <- read.table("./test/y_test.txt", header = FALSE)
names(test_activity) <- "Activity"
test_data <- cbind(test_data, test_activity)

# We now combine the rows of the training and the test data sets into one data frame wiht the
# same column names
data <- rbind(train_data, test_data)



# Part 2:

# Selecting out the columns invloving means and standard deviations - see the README.md file
# or the Codebook.md file for the reason for the particular choice of columns.
mean_names <- grep("mean()", names(data))
std_names <- grep("std()", names(data))

# We creat a vector of the numbers of the columns we want to subset. Note we also included
# the columns for the subject id and the activity type.
subset <-c(mean_names, std_names, grep("Activity", names(data)), grep("SubjectID", names(data)))

# We subset out the desired columns into a new data frame called "new_data"
new_data <- data[, subset]



# Part 3:

# We read in the names of the activities
activity_names <- read.table("./activity_labels.txt", header = FALSE, colClasses = "character")
activity_names <- activity_names[, 2]

# We make the "Activity" variable into a factor variable
new_data$Activity <- factor(new_data$Activity, labels = activity_names)



# Part 4:

# To make the variable names into valid names in R we use the "tocamel" function - for the
# choice of final column names see the README.md file or the "Codebook.md" file.
library(rapport)
names(new_data) <- tocamel(names(new_data))



# Part 5:

# Loading the dplyr package
library(dplyr)

# Group the data set by subject id and activity
tidyer_data <- group_by(new_data, SubjectID, Activity)

# For each group just created the mean is reported in the new data frame "tidy_data"
tidy_data <- summarise_each(tidyer_data, funs(mean))

# The new data frame is written to the file "TidyDataSet.txt"
write.table(tidy_data, "./TidyDataSet.txt", row.name=FALSE)