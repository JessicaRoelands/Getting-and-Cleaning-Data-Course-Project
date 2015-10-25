# Getting-and-Cleaning-Data-Course-Project
Github repository with my script for performing the analysis, a code book that describes the variables, 
the data, and work that I performed to clean up the data (called CodeBook.md) and a README.md file that 
explains how all of the scripts work and how they are connected. 

Explanation of how the scripts work and how they are connected:

Before running the run_analysis.R script, the provided file from the Coursera website
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
should be unzipped at the local computer and working directory should be set at directory UCI HAR Dataset.
If not yet installed R package reshape2 and its dependencies should be installed on your computer (install.packages("reshape2")).

The following read.table functions will save the datafiles as local R objects (testsub, Xtest.. etc).
File paths are specified because files are contained in the subdirectories "test" and "train" within current
working directory ("UCI HAR Dataset").

	testsub <- read.table(file=file.path("test", "subject_test.txt"))
	Xtest <- read.table(file=file.path("test", "X_test.txt"))
	Ytest <- read.table(file=file.path("test", "y_test.txt"))
	trainsub <- read.table(file=file.path("train", "subject_train.txt"))
	Xtrain <- read.table(file=file.path("train", "X_train.txt"))
	Ytrain <- read.table(file=file.path("train", "y_train.txt"))


To merge all of the datasets, first a dataset 'test' will be created by column binding of Xtest, testsub and Ytest.
(reason: testsub and Ytest are variables with each 2947 observations, the same number of observations is seen in Xtest)
The same will be done for the 'train' dataset. 
The final function within this step is to row bind 'test' and 'training' datasets together, creating 'total'.
(reason: 'test' and 'training' are similar datasets, with the same variables but different observations. Observations
are added as rows.)

	##step 1: merging the data sets
	test <- cbind(Xtest, testsub, Ytest)
	train <- cbind(Xtrain, trainsub, Ytrain)
	total <- rbind(test, train)


Variable names are documented in "features.txt" and will be saved within variable_names.
A logical vector indicating TRUE when a variable name contains std or mean and FALSE when it does not, is created by the 
grepl function.
This logical vector is than used to subset the data leaving only the variables with mean and std.
As the final columns (subjectid and activity) are lost during subsetting, these will be added back to dataset resulting to
'TidyData'.

	##step 2: extract means and standard deviations
	variable_names <- read.table("features.txt")
	logicalvector <- grepl("(-std\\(\\)|-mean\\(\\))", variable_names$V2)
	DataMeanStd <- total[, which(logicalvector == TRUE)]
	TidyData <- cbind(DataMeanStd, total[, (562:563)])


The final column of 'TidyData'contains the Ytest/Ytrain variable which describes activity. 
In the "activity_labels.txt" file can be found what the values (1,2,3,4,5 and 6) in this column represent. 
To give descriptive names instead of numbers in this column, basic subsetting is used.
The name of the activity column at this point is V1.1 (found by checking str(TidyData)). 
Following functions will change the numbers(1-6) into "Walking", "Walking_upstairs".. etc.

	##step 3: using descriptive activity names to name the activities in the data set
	TidyData$V1.1[TidyData $V1.1 == 1] <- "Walking"
	TidyData$V1.1[TidyData$V1.1 == 2] <- "Walking_upstairs"
	TidyData$V1.1[TidyData$V1.1 == 3] <- "Walking_downstairs"
	TidyData$V1.1[TidyData$V1.1 == 4] <- "Sitting"
	TidyData$V1.1[TidyData$V1.1 == 5] <- "Standing"
	TidyData$V1.1[TidyData$V1.1 == 6] <- "Laying"


To add appropriate descriptive variable names to the data set, the variable names containing mean and std will be subsetted
from variable_names. First indices for subsetting are created by the grep function. i indicates at which positions within variable_names
the mean/std variables are located.
After subsetting only the needed variable names for TidyData are stored within NeededvarNames.
These names are added with the colnames() function.
Finally the colnames for the final 2 columns are added ("subject" and "activity").
	
	##step 4: Add appropriate labels  with descriptive variable names to the data set. 
	i <- grep("(-std\\(\\)|-mean\\(\\))", variable_names$V2)
	NeededvarNames <- variable_names[i, 2]
	colnames(TidyData) <- NeededvarNames
	colnames(TidyData)[67: 68] <- c("subject", "activity")


To create an independent tidy data set with the average of each variable for each activity and each subject, load R package reshape2.
First a molten dataset with id variables subject and activity is created. 
This format allows subsequent computation of the mean for each individual activity-and-subject combination.
The dcast function computates the mean for each individual activity-and-subject combination and returnes the results in a dataframe.
This dataframe is saved as a .txt file using the write.table function.

	##step 5: create a second independent tidy data set with the average of each 
	## variable for each activity and each subject.
	library(reshape2)
	moltenData <- melt(TidyData,id.vars=c("subject","activity"))
	IndepTidyData <- dcast(moltenData, subject + activity ~ variable,mean)
	write.table(IndepTidyData, "datasetJR.txt", row.name=FALSE)
