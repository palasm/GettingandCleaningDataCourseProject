### A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.

### Introduction

To accomplish the course project here is teh flow of the code and saved under run_analysis.R. The script is parititioned into logical steps as mentioned in step 1 to 5 of the course project. This script also needs the library "plyr" installed.

1. Downloads the data from the prescribed URL of UCI Machine Learning Repository 
2. Read the data from the training & test folders 
3. Merge the training and test sets to create one meged data set with rbind() 
4. Enhance the data readabilty by replacing the activity  values in the dataset with descriptive activity names
5. Filter the measurements (features) on the mean and standard deviation for each measurement
6. Use only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt. 
7. creates a second, independent tidy dataset with an average of each variable for each each activity and each subject. In other words, same type of measurements for a particular subject and activity are averaged into one value and the tidy data set contains these mean values only. The processed tidy data set is also exported as text file called averages_data.txt, and uploaded to this repository.


###Following variables have been used in run_analysis.R

## XtrainData - Stored the data set from the text file Data/UCI HAR Dataset/train/X_train.txt
YtrainData - Stored the data set from the text file Data/UCI HAR Dataset/train/y_train.txt
SubtrainData - Stored the data set from the text file Data/UCI HAR Dataset/train/subject_train.txt
XtestData - Stored the data set from the text file "Data/UCI HAR Dataset/test/X_test.txt"
YtestData - Stored the data set from the text file  "Data/UCI HAR Dataset/test/y_test.txt"
SubtestData - Stored the data set from the text file "Data/UCI HAR Dataset/test/subject_test.txt"
XmergeData - Stored merge data sets with training & test data
YmergeData - Stored merge data sets with training & test data 
SubmergeData - Stored merge data sets with training & test data for subjects 
featuresData - USed to store the data set from the text file "Data/UCI HAR Dataset/features.txt"
meanAndStdFeatures - Stored the columns only with the mean() or std() in their names 
activitiesData - Stored the data set from the text file "Data/UCI HAR Dataset/activity_labels.txt"
combinedAllData - Stored the combined result with mean-std values (X), activities (Y) and subjects into one data frame.  
averagesData - Stored the new tidy data set with combinedAllData
