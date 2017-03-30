
library (plyr)

## Download and unzip the dataset:

if(!file.exists("./data")) {dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/downloadData.zip", method="auto")

unzip(zipfile="./data/downloadData.zip",exdir="./data")

# setup path and read the files
DataPath <- "./data/UCI HAR Dataset"
featuretxt <- paste(DataPath, "/features.txt", sep = "")
activity_labelstxt <- paste(DataPath, "/activity_labels.txt", sep = "")
x_traintxt <- paste(DataPath, "/train/X_train.txt", sep = "")
y_traintxt <- paste(DataPath, "/train/y_train.txt", sep = "")
subject_traintxt <- paste(DataPath, "/train/subject_train.txt", sep = "")
x_testtxt  <- paste(DataPath, "/test/X_test.txt", sep = "")
y_testtxt  <- paste(DataPath, "/test/y_test.txt", sep = "")
subject_testtxt <- paste(DataPath, "/test/subject_test.txt", sep = "")

# Read the data
features <- read.table(featuretxt, colClasses = c("character"))
activity_labels <- read.table(activity_labelstxt, col.names = c("ActivityId", "Activity"))
x_train <- read.table(x_traintxt)
y_train <- read.table(y_traintxt)
subject_train <- read.table(subject_traintxt)
x_test <- read.table(x_testtxt)
y_test <- read.table(y_testtxt)
subject_test <- read.table(subject_testtxt)


# 1. Merges the training and the test sets to create one data set.

# Merging the data
DataTraining <- cbind(cbind(x_train, subject_train), y_train)
DataTest <- cbind(cbind(x_test, subject_test), y_test)
DataSetMerged <- rbind(DataTraining, DataTest)
colnam <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(DataSetMerged) <- colnam


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

DataSetMergedMS <- DataSetMerged[,grepl("mean|std|Subject|ActivityId", names(DataSetMerged))]


# 3. Uses descriptive activity names to name the activities in the data set


DataSetMergedMS <- join(DataSetMergedMS, activity_labels, by = "ActivityId", match = "first")
DataSetMergedMS <- DataSetMergedMS[,-1]


# 4. Appropriately labels the data set with descriptive names.


names(DataSetMergedMS) <- gsub('\\(|\\)',"",names(DataSetMergedMS), perl = TRUE)
names(DataSetMergedMS) <- make.names(names(DataSetMergedMS))
names(DataSetMergedMS) <- gsub('^t',"Time.",names(DataSetMergedMS))
names(DataSetMergedMS) <- gsub('^f',"FreqClass",names(DataSetMergedMS))
names(DataSetMergedMS) <- gsub('Acc',"Acceleration",names(DataSetMergedMS))
names(DataSetMergedMS) <- gsub('\\.std',".StandardDeviation",names(DataSetMergedMS))
names(DataSetMergedMS) <- gsub('GyroJerk',"AngularAccel",names(DataSetMergedMS))
names(DataSetMergedMS) <- gsub('Gyro',"GyroMagnitude",names(DataSetMergedMS))
names(DataSetMergedMS) <- gsub('Mag',"Magnitude",names(DataSetMergedMS))
names(DataSetMergedMS) <- gsub('\\.mean',".Mean",names(DataSetMergedMS))
names(DataSetMergedMS) <- gsub('Freq\\.',"Frequency.",names(DataSetMergedMS))
names(DataSetMergedMS) <- gsub('Freq$',"Frequency",names(DataSetMergedMS))


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


tidy_data = ddply(DataSetMergedMS, c("Subject","Activity"), numcolwise(mean))
write.table(tidy_data, file = "tidy_data.txt", row.name=FALSE)
