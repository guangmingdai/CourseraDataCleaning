The R code *run_analysis.R* performs data preparation and cleaning with 5 required
steps as defined in the course project.

### Download the dataset
* Dataset is downloaded from [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) as a zip file, which after extraction creates a couple of layers of folders.

### Assign variables to each individual subset of data
* Loading library **dplyr** for data processing functions
* features <- features.txt : 561 rows, 2 columns
* activities <- activity_labels.txt : 6 rows, 2 columns
* subject_train <- train/subject_train.txt : 7352 rows, 1 column
* X_train <- train/X_train.txt : 7352 rows, 561 columns
* Y_train <- train/Y_train.txt : 7352 rows, 1 column
* subject_test <- test/subject_test.txt : 2947 rows, 1 column
* X_test <- test/X_test.txt : 2947 rows, 561 columns
* Y_test <- test/Y_test.txt : 2947 rows, 1 column
        
### Merge the training and test datasets into a combined dataset
* Subject <- subject_train + subject_test : 10299 rows, 1 column
* X <- X_train + X_test : 10299 rows, 561 columns
* Y <- Y_train + Y_test : 10299 rows, 1 column
* dataset <- Subject + Y + X : 10299 rows, 563 columns
        
### Extract only the measurements with mean and standard deviation for each measurement
* tidyset <- select(dataset, subject, code, contains('mean'), contains('std'))
        
### Use descriptive activity names instead of codes in the dataset
* tidyset$code <- activities[tidyset$code, 2]

### Appropriately labels the dataset with descriptive vairable names
* ename the *code* column name to *activity*
* All *Acc* column names substituted by *Accelerometer*
* All *angle* column names substituted by *Angle*
* All *BodyBody* column names substituted by *Body*
* All *gravity* column names substituted by *Gravity*
* All *Gyro* column names substituted by *Gyroscope*
* All *Mag* column names substituted by *Magnitude*
* All column names start with *t* substituted by *Time*
* All column names start with *f* substituted by *Frequency*
* All *tBody* column names substituted by *TimeBody*
* All *-mean()* column names substituted by *Mean*
* All *-std()* column names substituted by *STD*
* All *-freq()* column names substituted by *Frequency*
        
### From the set above, create a second, independent tidy dataset with the average of each variable for each actitivity and each subject
* *finalset* (180 rows, 88 columns) is created by summarizing *tidyset*
* Export *finalset* to *finalset.txt* file