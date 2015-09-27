# Introduction of the "run_analysis.R" script
* "run_analysis.R" is an R script with a function which can process the "UCI HAR Dataset" and create a new tidy data set from it. 
The script process the data according to the following steps: 

__1. Download and merge data set:__
* First of all, the UCI HAR Dataset is downloaded with download( ) function. Since the UCI HAR Dataset will not change with time, the file.exists( ) function is used to check whether the data set is already existed; if the data set had been downloaded, this step will be skip. 
* Then the UCI HAR Dataset is unzipped with unzip( ) function. The file.exist( ) function is also applied here to prevent repeating unzip.
* The following data files are selected for data merging based on the requirement of the course project:
   + "subject_test.txt" 
   + "X_test.txt"        
   + "y_test.txt""
   + "subject_train.txt"
   + "X_train.txt"
   + "y_train.txt"
* The paths of the selected data files are exctracted through list.dirs( ) and list.files( ) functions within a for loop. Then the data files are read by fread( ) function and varibles in the data tables are properly labelled with the descriptive names according to the "README.txt" and "feature_info.txt" in the original data set. 
* The datas that loaded in R are firstly merged into two data sets named as "test" and "train". After adding an additional column "Group", filled with character string "test" or "train", to both "test" and "train" data sets, the two data sets are merged into a single data set called "Data_Merged".
   
__2. Exctract the mean and standard deviation of the measurements:__
* In this script the mean and standard deviation is defined as the varible with desriptive name containing "-mean" and "std". The "meanFreq" varibles, which is the weighted average of the frequency components to obtain a mean frequency, are not considered as mean value of the measurements.
* select( ) function from the dplyr package is applied to filtering the data set and the result is save into a new data set call "Data_MeanAndDev".
   
__3. Label the activities with the activity descriptive name:__
* The descriptive names of the activities is obtained from the file "activity_labels.txt" and save into a character vector. 
* The activity codes is substituted by the activity descriptive names with the character vector via the mutate( ) function from the dplyr package and the result save into a new data set call "Data_Activitylabelled".
   
__4. creates a tidy data set with the average of each variable for each activity and each subject:__
* The data set passing through the former step is grouped up by the columns "activity", "subject" and "Group". Then the summarise_each( ) function applies the mean( ) function to the data set based on the groups. The result is saved into the data set "TidyData" and output to a txt file "TidyData.txt" in working directory by write.table( ).
