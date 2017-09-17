library(dplyr)

#download data
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileUrl, "data.zip")
unzip("data.zip")

#read in test data, test subject labels, and test activity number labels
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_activity_num <- read.table("UCI HAR Dataset/test/y_test.txt")

#read in train data, train subject labels, and train activity number labels
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_activity_num <- read.table("UCI HAR Dataset/train/y_train.txt")

#read in feature list and activity dictionary
features <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

#combine test and training data
data <- rbind(test_data, train_data)

#combine test and training subject labels
subject <- rbind(test_subject, train_subject)
names(subject) <- 'subject'

#combine test and training activity number labels
activity_num <- rbind(test_activity_num, train_activity_num)
names(activity_num) <- 'activity_num'

#label the columns of the combined data with the feature names
names(data) <- features$V2

#select only the columns that correspond to mean() and std() measurements
data <- data[, grepl('mean\\(|std', names(data))]

#clean the variable names by removing '-' and '()' and converting to lowercase
names(data) <- gsub('-', '', names(data))
names(data) <- gsub('\\(\\)', '', names(data))
names(data) <- tolower(names(data))

#convert the activity number labels to character labels
names(activities) <- c('activity_num', 'activity_label')
activity <- left_join(activity_num, activities)
activity <- activity$activity_label

#bind the subject and activity number to the data
data <- cbind(subject, activity, data) 

#use 'aggregate' to split data into subsets by subject and activity and calculate
#the mean of each variable for each subset
averages <- aggregate(data[, -(1:2)], 
                 by = list(subject = data$subject,activity = data$activity), 
                 mean)

#write the averages data frame to a .txt file
write.table(averages, "averages.txt", row.name = FALSE)
