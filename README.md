Getting-and-cleaning-data
=========================
Project Description
=========================

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project.

Following are to be submitted as part of the project

A tidy data set as described below

A link to a Github repository with your script for performing the analysis

A  code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This file explains how all of the scripts work and how they are connected.

Project Details and Requirements
================================

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
 
1.Merges the training and the test sets to create one data set.

2.Extracts only the measurements on the mean and standard deviation for each measurement. 

3.Uses descriptive activity names to name the activities in the data set

4.Appropriately labels the data set with descriptive variable names. 

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

You find following objects in the repository
============================================

1.README.md: this file

2.CodeBook.md: information about raw and tidy data set and elaboration made to transform them

3.run_analysis.R: R script to transform raw data set in a tidy one

Assumptions
===========

1.Package plyr is already installed 

2.From requirments#3 onwards, assumed the result of requirment#2 has to be used.

Approach 
========

1. created two functions 

    i.for download of the data if not present 
   
    ii. main fucntion for all five requirments
    
2.Reading all the data files into data set variables

3.using Rbind and Cbind combination to combine the data sets to accomplish the requirment#1 and save to "merge.data"

4.Extracts only the measurements on the mean and standard deviation for each measurement to accomplish requirment#2 and save to "data_std_mean"

5.To accomplish requirment#3 , used Join function to combine the data sets and the result is saved to "data_std_mean_actvity_label"

6.To make appropriate label names, rename function is used and the "data_std_mean_actvity_label" is modified.

7.And for the last requirment#5 , average of the variables is calculated by activity id and subject id and saved to "avg_data_activity_subject" and the same was written to a file "DataSet_Avg.txt"

Steps to Replicate the output
=============================

1.Create a folder called Getting_Data in your local and set this as working directory using setwd()

2. Save the run_analysis.R file  from the repository to Getting_Data folder
3. 
3. Run source("run_analysis.R") and then execute run_analysis() and you will see tidy data set"DataSet_Avg.txt" in the Getting_Data folder.

