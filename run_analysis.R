# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
# The full description of the data set is available at:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

library(plyr)

# Set working directory - Samsung data must be present here before running the script
setwd("C:/Users/USER NAME/Documents/UCI HAR Dataset")

# Step 1 - Merge the training and test sets to create one data set
# Read data from all the training & test data set

# Reading data from X_train.txt
XtrainData <- read.table("./train/X_train.txt")
# Reading data from y_train.txt
YtrainData <- read.table("./train/y_train.txt")
# Reading data from subject_train.txt
SubtrainData <- read.table("./train/subject_train.txt")
# Reading data from X_test.txt
XtestData <- read.table("./test/X_test.txt")
# Reading data from y_test.txt
YtestData <- read.table("./test/y_test.txt")
# Reading data from subject_test.txt
SubtestData <- read.table("./test/subject_test.txt")

# Create merge data sets with training & test data
XmergeData <- rbind(XtrainData, XtestData)
YmergeData <- rbind(YtrainData, YtestData)
SubmergeData <- rbind(SubtrainData, SubtestData)


# Step 2 - Extract only the measurements on the mean and standard deviation for each measurement

# Read the data from features.txt file
featuresData <- read.table("./features.txt")
# Extract the columns only with the mean() or std() in their names & set variable
meanAndStdFeatures <- grep("-(mean|std)\\(\\)", featuresData[, 2])
# Set the desired columns only
XmergeData <- XmergeData[, meanAndStdFeatures]
# correct the column names with feature
names(XmergeData) <- featuresData[meanAndStdFeatures, 2]


# Step 3 - Use descriptive activity names to name the activities in the data set
# Read the data from activity_labels file
activitiesData <- read.table("./activity_labels.txt")
# Set correct activity names with modified values
YmergeData[, 1] <- activitiesData[YmergeData[, 1], 2]
# correct the column name with activity
names(YmergeData) <- "activity"


# Step 4 - Appropriately label the data set with descriptive variable names
# Column name is corrected with subject
names(SubmergeData) <- "subject"
# Bind all the individual data set with a single data set
# Combine mean-std values (X), activities (Y) and subjects into one data frame.
combinedAllData <- cbind(XmergeData, YmergeData, SubmergeData)


# Step 5 - Create a second, independent tidy data set with the average of each variable for each activity and each subject
# Creating independent tidy data set with existing
averagesData <- ddply(combinedAllData, .(subject, activity), function(x) colMeans(x[, 1:66]))
# Write Data in average_data.txt using write.table()
write.table(averagesData, "new_tidy_average_data.txt", row.name=FALSE)
