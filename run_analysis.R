# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The full description of the data set is available at: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


library(plyr) 

# "Checking Data directory and creating one if it doesn't exist" 
if (!file.exists("Data")) {        # Check directory exists name as "Data" 
  message("Created new directory named Data under working directory... ") # If file.exists retrun FALSE 
  dir.create("Data") # Create new directory "Data"
  } 

if (!file.exists("Data/UCI HAR Dataset")) {  # Check directory exists name as "Data/UCI HAR Dataset"
  # Course Project data download
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
  zipfileSource="Data/UCI_HAR_data.zip" # Set variable for source zip file
  message("Project data downloading ...") 
  download.file(fileUrl, destfile=zipfileSource) # Downloading project zip file
  unzip(zipfileSource, exdir="Data") # Unzip project file under Data Directory
  } 
 
# Step 1 - Merge the training and test sets to create one data set
# Read data from all the training & test data set 
  # Reading data from X_train.txt
  XtrainData <- read.table("Data/UCI HAR Dataset/train/X_train.txt") 
  # Reading data from y_train.txt
  YtrainData <- read.table("Data/UCI HAR Dataset/train/y_train.txt") 
  # Reading data from subject_train.txt 
  SubtrainData <- read.table("Data/UCI HAR Dataset/train/subject_train.txt") 
  # Reading data from X_test.txt
  XtestData <- read.table("Data/UCI HAR Dataset/test/X_test.txt") 
  # Reading data from y_test.txt
  YtestData <- read.table("Data/UCI HAR Dataset/test/y_test.txt") 
  # Reading data from subject_test.txt
  SubtestData <- read.table("Data/UCI HAR Dataset/test/subject_test.txt") 
  
# Create merge data sets with training & test data 
  XmergeData   <- rbind(XtrainData, XtestData) 
  YmergeData   <- rbind(YtrainData, YtestData) 
  SubmergeData <- rbind(SubtrainData, SubtestData) 


# Step 2 - Extract only the measurements on the mean and standard deviation for each measurement

# Read the data from features.txt file
featuresData <- read.table("Data/UCI HAR Dataset/features.txt")
# Extract the columns only with the mean() or std() in their names & set variable
meanAndStdFeatures <- grep("-(mean|std)\\(\\)", featuresData[, 2])
# Set the desired columns only 
XmergeData <- XmergeData[, meanAndStdFeatures]
# correct the column names with feature
names(XmergeData) <- featuresData[meanAndStdFeatures, 2]

# Step 3 - Use descriptive activity names to name the activities in the data set

# Read the data from activity_labels file
activitiesData <- read.table("Data/UCI HAR Dataset/activity_labels.txt")
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

