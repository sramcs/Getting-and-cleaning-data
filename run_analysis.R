#This R script gets data and process further to extract the data to a tidy dataset
#based on the recordings of activities performed by the subjects using smartphone
#The description of the can be found from the URL :http://archive.ics.uci.edu/ml/
#datasets/Human+Activity+Recognition+Using+Smartphones

#following snippet checks if dataset is already available in the folder and if not downloads from
#URL and unzips the data
library(plyr)
#setwd("~/Programs/Coursera/Getting_Data")
downloadData <- function() 
  {
  if(!file.exists("./Getting_Data/FUCI_HAR_Dataset.zip"))
  {
  data_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zip_file <- "./Getting_Data/FUCI_HAR_Dataset.zip"
  download.file(data_URL,destfile= zip_file,method = "curl")
  download_date <- date()
  unzip(zip_file)
  }
}
#Main function
runAnalysis <- function () {
  #Reading label data
  features <- read.table("./Getting_Data/UCI HAR Dataset/features.txt")
  activityType <- read.table("./Getting_Data/UCI HAR Dataset/activity_labels.txt")
  
  # Reading test data
  test.x <- read.table("./Getting_Data/UCI HAR Dataset/test/X_test.txt")
  test.y <- read.table("./Getting_Data/UCI HAR Dataset/test/y_test.txt")
  test.sub <- read.table("./Getting_Data/UCI HAR Dataset/test/subject_test.txt")
  
  # Reading train data
  train.x <- read.table("./Getting_Data/UCI HAR Dataset/train/X_train.txt")
  train.y <- read.table("./Getting_Data/UCI HAR Dataset/train/y_train.txt")
  train.sub <- read.table("./Getting_Data/UCI HAR Dataset/train/subject_train.txt")
  
  #Assigning column names to test and train data
  colnames(activityType) <- c('activityId','activityType')
  colnames(test.sub) <- "subjectId"
  colnames(test.x) <- features[,2]
  colnames(test.y) <- "activityId"
  colnames(train.sub) <- "subjectId"
  colnames(train.x) <- features[,2]
  colnames(train.y) <- "activityId"
  
  ###############################################################
  #1.Merges the training and the test sets to create one data set.
  ###############################################################
  # Merge X data of  train and test
  merge.x <- rbind(train.x ,test.x)
  
  #Merge y data fo train and test
  merge.y <- rbind(train.y ,test.y)
  
  #Merge the train and test subject data
  merge.sub <- rbind(train.sub,test.sub)
  
  #Merge X,y,subject 
  merge.data <- cbind(merge.x,merge.y,merge.sub)
  
  #########################################################################################
  #2.Extracts only the measurements on the mean and standard deviation for each measurement.
  #########################################################################################
  
  #loading column names of merged data to a variable
  col_names <- colnames(merge.data)
  #choosing the STD , MEAN,Subject and Activity id column names into a variable
  col_std_mean <- sort(c(grep("std\\(\\)",col_names),grep("mean\\(\\)",col_names),grep("subjectId",col_names),grep("activityId",col_names)))
  
  # Filtering from the data set measurments based on the STD and MEAN column names
  data_std_mean <- merge.data[,col_std_mean]
  
  ##############################################################
  #3.Uses descriptive activity names to name the activities in the data set
  ##############################################################
  
  #Joining the data set result from #2 (data_std_mean) and Actvity data set 
  data_std_mean_actvity_label <- join(data_std_mean,activityType,by="activityId")
  
  ##############################################################
  # 4. Appropriately labels the data set with descriptive names.
  ##############################################################
  
  # removing paranthesis from the column names of the data set
  names(data_std_mean_actvity_label) <- gsub('\\(|\\)',"",names(data_std_mean_actvity_label))
  
  # Renaming 'Acc' to Accelaration
  names(data_std_mean_actvity_label) <- gsub('Acc',"Accelaration",names(data_std_mean_actvity_label))
  
  # Renaming mean to Mean, Std to Standard deviation, Mag to Magnintude
  names(data_std_mean_actvity_label) <- gsub('mean',"Mean",names(data_std_mean_actvity_label))
  names(data_std_mean_actvity_label) <- gsub('std',"StandardDeviation",names(data_std_mean_actvity_label))
  names(data_std_mean_actvity_label) <- gsub('Mag',"Magnitude",names(data_std_mean_actvity_label))
  
  #And lastly making syntactically valid names
  names(data_std_mean_actvity_label) <- make.names(names(data_std_mean_actvity_label))
  
  ######################################################################################################################
  # 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  ######################################################################################################################
  
  #using ddply function to calcualte average of each column by activity id and subject id from the data set of #4 as per requirment
  avg_data_activity_subject <- ddply(data_std_mean_actvity_label,c("activityId","subjectId"), numcolwise(mean))
  write.table(avg_data_activity_subject,file="DataSet_Avg.txt",row.names = FALSE)
  
}

run_analysis <- function()
{
  #download the data
  downloadData()
  #writing 5 requirments into a seperate function.
  runAnalysis()
}



