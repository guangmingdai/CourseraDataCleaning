## Getting and Cleaning Data Course Project
## Author: George Dai
## Date: April 26, 2020

## Task One: Merge the training and testing datasets into one
# get features, activities, etc.
library(dplyr)
dir <- 'UCI HAR Dataset/'
features <- read.table(paste0(dir, 'features.txt'), 
                       col.names = c('n', 'functions'))
activities <- read.table(paste0(dir, 'activity_labels.txt'), 
                         col.names = c('code', 'activity'))

# Training set
dir <- 'UCI HAR Dataset/train/'
subject_train <- read.table(paste0(dir, 'subject_train.txt'),
                            col.names = 'subject')
X_train <- read.table(paste0(dir, 'X_train.txt'),
                      col.names = features$functions)
Y_train <- read.table(paste0(dir, 'Y_train.txt'),
                      col.names = 'code')

# Test set
dir <- 'UCI HAR Dataset/test/'
subject_test <- read.table(paste0(dir, 'subject_test.txt'),
                           col.names = 'subject')
X_test <- read.table(paste0(dir, 'X_test.txt'),
                     col.names = features$functions)
Y_test <- read.table(paste0(dir, 'Y_test.txt'),
                     col.names = 'code')

subject <- rbind(subject_train, subject_test)
X <- rbind(X_train, X_test)
Y <- rbind(Y_train, Y_test)
dataset <- cbind(subject, Y, X)

## Task Two: Extract only the measurements on the mean and standard
##           deviation for each measurement

tidyset <- select(dataset, subject, code, contains('mean'), contains('std'))

## Task Three: Use descriptive activity names to name the activities
##             in the dataset
tidyset$code <- activities[tidyset$code, 2]
        
## Task Four: Appropriately labels the dataset with descriptive variable
##            names
names(tidyset)[2] <- 'activity'
names(tidyset) <- gsub('Acc', 'Accelerometer', names(tidyset))
names(tidyset) <- gsub('angle', 'Angle', names(tidyset))
names(tidyset) <- gsub('BodyBody', 'Body', names(tidyset))
names(tidyset) <- gsub('gravity', 'Gravity', names(tidyset))
names(tidyset) <- gsub('Gyro', 'Gyroscope', names(tidyset))
names(tidyset) <- gsub('Mag', 'Magnitude', names(tidyset))
names(tidyset) <- gsub('^t', 'Time', names(tidyset))
names(tidyset) <- gsub('^f', 'Frequency', names(tidyset))
names(tidyset) <- gsub('tBody', 'TimeBody', names(tidyset))
names(tidyset) <- gsub('-mean()', 'Mean', names(tidyset))
names(tidyset) <- gsub('-std()', 'STD', names(tidyset))
names(tidyset) <- gsub('-frqe()', 'Frequency', names(tidyset))

## Task Five: From above, create a second, independent tidy dataset with
##            the average of each variable for each activity and each 
##            subject
finalset <- tidyset %>%
        group_by(subject, activity) %>%
        summarize_all(mean)
write.table(finalset, 'finalset.txt', row.name = FALSE)

