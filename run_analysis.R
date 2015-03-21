#Project script

#Preparation steps to run the R script created for the project.

  #Step 1. Set the working directory for the script.  If it does not exist then create it.
  if (!file.exists("Z:\\Coursera\\CleaningData")) {
        dir.create("Z:\\Coursera\\CleaningData")
  }
  setwd("Z:\\Coursera\\CleaningData")

  #Step 2. Check to see if the required packages are installed.  If not then install them.
  packages <- c("downloader","plyr","dplyr","utils")
  if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
    install.packages(setdiff(packages, rownames(installed.packages())))  
  }

  #Step 3. Load the libraries for the non base R packages
  library(downloader)
  library(plyr)
  library(dplyr)
  library(utils)


  #Step 4. Download the Samsung data to the working directory
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download(url, dest = ".\\Dataset.zip", mode = "wb")
  unzip (".\\Dataset.zip")

#Project phase 1: Merge the training and the test sets to create one data set.

  #Step 1: read each file into a data frame with a column added that contains the name of the file the data came from (without the .txt extension)

  # Train File
  train <- read.table(".\\UCI HAR Dataset\\train\\x_train.txt")
  trainActivity <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
  trainSubject <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
  trainData <- data.frame(train,trainActivity,trainSubject)
  trainData <- mutate(trainData, dataSet = "train")

  # Test File
  test <- read.table(".\\UCI HAR Dataset\\test\\x_test.txt")
  testActivity <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
  testSubject <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
  testData <- data.frame(test,testActivity,testSubject)
  testData <- mutate(testData, dataSet = "test")


  #Step 2: Merge the data sets into a single data set

  accelData <- bind_rows(trainData,testData)

  #Step 3: Read file of column names and add 'dataSet' to the vector for the column added above

  label <- read.table(".\\UCI HAR Dataset\\features.txt")
  labels <- as.vector(label$V2)
  labels <- c(labels,"activityKey","subject","dataSet")

  #Step 4: Identify duplicate column names 
  dupe <- duplicated(labels)

  #Step 5: Apply labels as column names
  colnames(accelData) <- labels

  #Step 6: Eliminate columns with duplicate names.  A manual examination did not find any 'mean' or 'sdt' duplicate columns.
  AData <- accelData[, !duplicated(colnames(accelData))]

#Project phase 2: Extract only the measurements on the mean and standard deviation for each measurement. 

  #Step 1: Create a new data set with only the columns that have mean or std in the column names along with the grouping columns
  meanStdData <- select(AData, contains("mean"), contains("std"), activityKey, subject, dataSet)

#Phase 3: Use descriptive activity names to name the activities in the data set

  #Step 1: Read file of activity names.
  activity <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")

  #Step 2: Merge activity names into meanStdData.
  colnames(activity) <- c("activityKey","activity")
  meanStdData <- merge(meanStdData, activity)

#Project phase 4: Appropriately label the data set with descriptive variable names. 

  #Step 1: make the column names syntactically valid
  colnames(meanStdData) <- make.names(colnames(meanStdData))

  #Step 2: replace t prefix with time in the column names
  colnames(meanStdData) <- gsub("^t", "time", colnames(meanStdData))

  #Step 3: replace f prefix with frequency in the column names.
  colnames(meanStdData) <- gsub("^f", "frequency", colnames(meanStdData))

  #step 4: remove periods from the column names.
  colnames(meanStdData) <- gsub("\\.", "", colnames(meanStdData))

#Project phase 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.

  #Step 1: Apply grouping to activity and subject
  groupedMeanStdData <- group_by(meanStdData, activity, subject)

  #Step 2: Summarize by averaging each variable by group
  dataSummary <- summarize(groupedMeanStdData, 
                  mean(timeBodyAccmeanX),
                  mean(timeBodyAccmeanY),
                  mean(timeBodyAccmeanZ),
                  mean(timeGravityAccmeanX),
                  mean(timeGravityAccmeanY),
                  mean(timeGravityAccmeanZ),
                  mean(timeBodyAccJerkmeanX),
                  mean(timeBodyAccJerkmeanY),
                  mean(timeBodyAccJerkmeanZ),
                  mean(timeBodyGyromeanX),
                  mean(timeBodyGyromeanY),
                  mean(timeBodyGyromeanZ),
                  mean(timeBodyGyroJerkmeanX),
                  mean(timeBodyGyroJerkmeanY),
                  mean(timeBodyGyroJerkmeanZ),
                  mean(timeBodyAccMagmean),
                  mean(timeGravityAccMagmean),
                  mean(timeBodyAccJerkMagmean),
                  mean(timeBodyGyroMagmean),
                  mean(timeBodyGyroJerkMagmean),
                  mean(frequencyBodyAccmeanX),
                  mean(frequencyBodyAccmeanY),
                  mean(frequencyBodyAccmeanZ),
                  mean(frequencyBodyAccmeanFreqX),
                  mean(frequencyBodyAccmeanFreqY),
                  mean(frequencyBodyAccmeanFreqZ),
                  mean(frequencyBodyAccJerkmeanX),
                  mean(frequencyBodyAccJerkmeanY),
                  mean(frequencyBodyAccJerkmeanZ),
                  mean(frequencyBodyAccJerkmeanFreqX),
                  mean(frequencyBodyAccJerkmeanFreqY),
                  mean(frequencyBodyAccJerkmeanFreqZ),
                  mean(frequencyBodyGyromeanX),
                  mean(frequencyBodyGyromeanY),
                  mean(frequencyBodyGyromeanZ),
                  mean(frequencyBodyGyromeanFreqX),
                  mean(frequencyBodyGyromeanFreqY),
                  mean(frequencyBodyGyromeanFreqZ),
                  mean(frequencyBodyAccMagmean),
                  mean(frequencyBodyAccMagmeanFreq),
                  mean(frequencyBodyBodyAccJerkMagmean),
                  mean(frequencyBodyBodyAccJerkMagmeanFreq),
                  mean(frequencyBodyBodyGyroMagmean),
                  mean(frequencyBodyBodyGyroMagmeanFreq),
                  mean(frequencyBodyBodyGyroJerkMagmean),
                  mean(frequencyBodyBodyGyroJerkMagmeanFreq),
                  mean(angletBodyAccMeangravity),
                  mean(angletBodyAccJerkMeangravityMean),
                  mean(angletBodyGyroMeangravityMean),
                  mean(angletBodyGyroJerkMeangravityMean),
                  mean(angleXgravityMean),
                  mean(angleYgravityMean),
                  mean(angleZgravityMean),
                  mean(timeBodyAccstdX),
                  mean(timeBodyAccstdY),
                  mean(timeBodyAccstdZ),
                  mean(timeGravityAccstdX),
                  mean(timeGravityAccstdY),
                  mean(timeGravityAccstdZ),
                  mean(timeBodyAccJerkstdX),
                  mean(timeBodyAccJerkstdY),
                  mean(timeBodyAccJerkstdZ),
                  mean(timeBodyGyrostdX),
                  mean(timeBodyGyrostdY),
                  mean(timeBodyGyrostdZ),
                  mean(timeBodyGyroJerkstdX),
                  mean(timeBodyGyroJerkstdY),
                  mean(timeBodyGyroJerkstdZ),
                  mean(timeBodyAccMagstd),
                  mean(timeGravityAccMagstd),
                  mean(timeBodyAccJerkMagstd),
                  mean(timeBodyGyroMagstd),
                  mean(timeBodyGyroJerkMagstd),
                  mean(frequencyBodyAccstdX),
                  mean(frequencyBodyAccstdY),
                  mean(frequencyBodyAccstdZ),
                  mean(frequencyBodyAccJerkstdX),
                  mean(frequencyBodyAccJerkstdY),
                  mean(frequencyBodyAccJerkstdZ),
                  mean(frequencyBodyGyrostdX),
                  mean(frequencyBodyGyrostdY),
                  mean(frequencyBodyGyrostdZ),
                  mean(frequencyBodyAccMagstd),
                  mean(frequencyBodyBodyAccJerkMagstd),
                  mean(frequencyBodyBodyGyroMagstd),
                  mean(frequencyBodyBodyGyroJerkMagstd)
                  )

  #Step 3: clean up column names by replacing the "(" with a period and removing the ")"
  colnames(dataSummary) <- gsub("\\(", ".", colnames(dataSummary))
  colnames(dataSummary) <- gsub("\\)", "", colnames(dataSummary))
  
  #Step 4: Export the dataSummary data set to a .txt file
  write.table(dataSummary, file = ".\\dataSummary.txt", row.name=FALSE)

#Project Complete
