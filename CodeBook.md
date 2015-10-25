
CodeBook

Study Design
Data were collected by extracting data from the Human Activity Recognition Using Smartphones Data Set. This dataset was built from the recordings of 30 subjects 
performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

Data were collected using this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The original dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

Files used to generate datasetJR.txt by running the R script 'run_analysis.R' include:
	Files from training data:
	subject_train.txt 
	X_train.txt 
	y_train.txt
	
	Files from test data:
	subject_test.txt 
	X_train.txt 
	y_train.txt

These datafiles were merged to generate one dataset (for a detailed description on merging see README.md file).
Furthermore, file features.txt was used to add appropriate labels  with descriptive variable names to the data set.
activity_labels.txt was used to give descriptive activity names to the activities in the data set.

Files within directories 'Inertial Signals' were not used.

All variables describing means and standard deviations were extracted from the dataset (see CodeBook below).
All other variables were excluded.

The mean of each variable for each activity and each subject was computed and saved in datasetJR.txt


CodeBook

Variable "subject"
Subject describes a unique identifier for each subject. No units.

Variable "activity"
Values are descriptive labels of the activity ("Walking", "Walking_upstairs", "Walking_downstairs", "Sitting", "Standing" or "Laying") No units.

All measurement variables
The mean and standard deviation for each measurement in the original dataset were extracted. 
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions of each measurement.
The following variables were computed by taking the mean value for each measurement for every subject + activity combination:
(no units as the data has been normalized).

"tBodyAcc-mean()-X"          
"tBodyAcc-mean()-Y"           
"tBodyAcc-mean()-Z"           
"tBodyAcc-std()-X"           
"tBodyAcc-std()-Y"            
"tBodyAcc-std()-Z"            
"tGravityAcc-mean()-X"       
"tGravityAcc-mean()-Y"        
"tGravityAcc-mean()-Z"        
"tGravityAcc-std()-X"        
"tGravityAcc-std()-Y"         
"tGravityAcc-std()-Z"         
"tBodyAccJerk-mean()-X"      
"tBodyAccJerk-mean()-Y"       
"tBodyAccJerk-mean()-Z"       
"tBodyAccJerk-std()-X"       
"tBodyAccJerk-std()-Y"        
"tBodyAccJerk-std()-Z"        
"tBodyGyro-mean()-X"         
"tBodyGyro-mean()-Y"          
"tBodyGyro-mean()-Z"          
"tBodyGyro-std()-X"          
"tBodyGyro-std()-Y"           
"tBodyGyro-std()-Z"           
"tBodyGyroJerk-mean()-X"     
"tBodyGyroJerk-mean()-Y"      
"tBodyGyroJerk-mean()-Z"      
"tBodyGyroJerk-std()-X"      
"tBodyGyroJerk-std()-Y"       
"tBodyGyroJerk-std()-Z"       
"tBodyAccMag-mean()"         
"tBodyAccMag-std()"           
"tGravityAccMag-mean()"       
"tGravityAccMag-std()"       
"tBodyAccJerkMag-mean()"      
"tBodyAccJerkMag-std()"       
"tBodyGyroMag-mean()"        
"tBodyGyroMag-std()"          
"tBodyGyroJerkMag-mean()"     
"tBodyGyroJerkMag-std()"     
"fBodyAcc-mean()-X"           
"fBodyAcc-mean()-Y"           
"fBodyAcc-mean()-Z"          
"fBodyAcc-std()-X"            
"fBodyAcc-std()-Y"            
"fBodyAcc-std()-Z"           
"fBodyAccJerk-mean()-X"       
"fBodyAccJerk-mean()-Y"       
"fBodyAccJerk-mean()-Z"      
"fBodyAccJerk-std()-X"        
"fBodyAccJerk-std()-Y"        
"fBodyAccJerk-std()-Z"       
"fBodyGyro-mean()-X"          
"fBodyGyro-mean()-Y"          
"fBodyGyro-mean()-Z"         
"fBodyGyro-std()-X"           
"fBodyGyro-std()-Y"           
"fBodyGyro-std()-Z"          
"fBodyAccMag-mean()"          
"fBodyAccMag-std()"           
"fBodyBodyAccJerkMag-mean()" 
"fBodyBodyAccJerkMag-std()"   
"fBodyBodyGyroMag-mean()"     
"fBodyBodyGyroMag-std()"     
"fBodyBodyGyroJerkMag-mean()" 
"fBodyBodyGyroJerkMag-std()"