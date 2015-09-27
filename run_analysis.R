run_analysis <- function() {
        library(dplyr)
        library(data.table)
        ## data.table package in 1.9.6 version is used in the function
        ## Please run the function with R in version 3.2.2
        
        ## STEP 1: Merges the training and the test sets to create one data set.
        if (!file.exists("./UCI HAR Dataset.zip")) {
                download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                      destfile = "./UCI HAR Dataset.zip")
        }
        ## Download the UCI HAR Dataset.zip
        
        if (!file.exists("./UCI HAR Dataset")) {
                unzip("./UCI HAR Dataset.zip")
        }
        ## Unzip the UCI HAR Dataset
        
        alldirs <- list.dirs("./UCI HAR Dataset")
        ## Extract all directories from the UCI HAR Dataset file
        ## Save the output into the vector "alldir"
        
        allpaths <- character()
        
        for (i in c(1,2,4)) {
                if (length(list.files(alldirs[i])>=1)) {
                        filebuffer <- list.files(alldirs[i], pattern = ".txt")
                }
                ## loop through the selected directories (alldir[1], alldir[2], alldir[4])
                ## exctract names of the files from the selected directories
                ## save the output into the vector "filebuffer"
                for (j in 1:length(filebuffer)) {
                        path <- paste(alldirs[i], filebuffer[j], sep = "/")
                        allpaths <- c(allpaths, path)
                }
                ## combine the directories and the names of files into paths, 
                ## save the output into the vector "allpaths"  
        }
        
        features <- read.table(allpaths[2])
        ## Read the "feature.txt" file into the "feature" data frame
        
        subject_test <- fread(allpaths[5], col.names = "Subjects")
        ## Read the "subject_test.txt" file into the "subject_test" data table
        ## Name the only column in "subject_test" as "Subjects"
        
        X_test <- fread(allpaths[6], col.names = as.character(features[, 2]))
        ## Read the "X_test.txt" file into the "X_test" data table
        ## label the variables in the "X_test" with the descriptive variable names
        
        y_test <- fread(allpaths[7], col.names = "Activities")
        ## Read the "y_test.txt" file into the "y_test" data table
        ## Name the only column in "y_test" as "Activities"
        
        subject_train <- fread(allpaths[8], col.names = "Subjects")
        X_train <- fread(allpaths[9], col.names = as.character(features[, 2]))
        y_train <- fread(allpaths[10], col.names = "Activities")
        ## Read the "subject_train.txt", "X_train.txt" and "y_train.txt" 
        ## into data tables of "subject_train", "X_train" and "y_train", respectively
        ## label all columns with proper descriptive names as what has been done for the "test" data files  
        
        test <- cbind(subject_test, y_test, X_test)
        ## Combine the test data tables, "subject_test", "y_test" and "X_test", column-wise into data table "test"
        train <- cbind(subject_train, y_train, X_train)
        ## Combine the training data tables, "subject_train", "y_train" and "X_train", column-wise into data table "train"
        
        tbl_test <- tbl_dt(test)
        tbl_train <- tbl_dt(train)
        ## Wrap the data tables "test" and "train" 
        ## into data table tbl "tbl_test" and "tbl_train"
        
        tbl_test <- mutate(tbl_test, Group = "test")
        tbl_train <- mutate(tbl_train, Group = "train")
        ## An additonal column "Group" is added in both "tbl_test" and "tbl_train"
        ## and filled with charater strings of "test" and "train"
        ## in order to idenify the data from test and training group
        ## after merging them into a single data set.
        
        Data_Merged <- rbind(tbl_test, tbl_train)
        ## Merge the test and training data as one data set (STEP 1 done) 
        
        
        ## STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
        Data_MeanAndDev <- select(Data_Merged, Subjects, Activities, Group, contains("-mean"), contains("std"), -contains("-meanFreq"))
        ## Select the columns "Subjects", "Activities", "Group"
        ## and the columns with descriptive names containing "-mean" and "std"
        ## and excluding those with descriptive names containing "-meanFreq"
        ## from "Data_Merge" and into a new data set called "Data_MeanAndDev"(STEP 2 done)
        
        ## STEP 3: Uses descriptive activity names to name the activities in the data set
        activity_labels <- as.character(read.table(allpaths[1])[ ,2])
        ## Read the activities labels from the file "activity_labels.txt" in UCI HAR Dataset
        Data_Activitylabelled <- mutate(Data_MeanAndDev, Activities = activity_labels[Activities])
        ## Label the activities with the activity names (STEP 3 done)
        
        ## STEP 4: Appropriately labels the data set with descriptive variable names. 
        ## This step has been done during the data merging
        ## Line 45: X_test <- fread(allpaths[6], col.names = as.character(features[, 2]))
        ## Line 54: X_train <- fread(allpaths[9], col.names = as.character(features[, 2]))
        
        ## STEP 5: From the data set in step 4, creates a second, 
        ## independent tidy data set with the average of each variable 
        ## for each activity and each subject.
        ActivitiesAndSubjects <- group_by(Data_Activitylabelled, Activities, Subjects, Group)
        TidyData <- summarise_each(ActivitiesAndSubjects, "mean")
        ## The "TidyData" is a data set with 180 rows and 69 columns 
        write.table(TidyData, file = "./TidyData.txt",  row.names = FALSE)
        ## Create a txt file called "TidyData.txt" and the result in this file (STEP 5 done)
}