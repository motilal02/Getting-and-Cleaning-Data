# Course Project - Getting and Cleaning Data


## Introduction

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

## Purpose

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.


## Github repository contains

* Folder:
+ UCI HAR Dataset

* Files:
+ run_analysis.R 
+ CodeBook.md
+ README.md
+ tidyMeansdata.txt 


## About the CodeBook

The CodeBook.md file talks about brief introduction, data set information, attribute information and variable description


## About tidy dataset

The tidy dataset is downloaded from following website using R script
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

It has test and train data and activity labels and feature information needed for the analysis.


## About run_analysis.R script 

It downloads the UCI HAR Dataset data set and puts the zip file working directrory. After it is downloaded, it unzips the file into the UCI HAR Dataset folder. 
It loads the train and test data sets and appends the two datasets into one data frame. This is done using rbind.

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## About tidyMeansdata.txt file

It an output file of tidy data set created in step 5 

