
 Code Book
 
 This Code Book describes the variables and data transformation steps performed in the script run_analysis.R
 The script run_analysis.R requires lybrary (plyr)
 
 STEPS:
 1. Download and unzip the dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 2. Setup path and read the files
 3. Merging the training and the test sets to create one data set using the function rbind()
 4. Extracting only the measurements on the mean and standard deviation for each measurement
 5. Using descriptive activity names to name the activities in the data set 
 6. Appropriately labeling the data set with descriptive names; using function gsub()
 7. Creating a second, independent tidy data set with the average of each variable for each activity and each subject.
    The file tidy_data.txt is being created using the function write.table() using row.name=FALSE
 
 VARIABLES:
 
 1. features, activity_labels, x_train, y_train, subject_train, x_test, y_test, subject_test: contain the data from the unzipped file
 2. DataTraining and DataTest: are used to merge the datasets to further analysis
 3. DataSetMerged: merged datasets (DataTraining and DataTest)
 4. DataSetMergedMS: the data set with extract  measurements on the mean and standard deviation for each measurement
 5. tidy_data: contains the relevant averages which will be stored in tidy_data.txt.
 
 
