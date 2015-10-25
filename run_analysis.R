## Opening files from current working directory (dir = UCI HAR Dataset)
testsub <- read.table(file=file.path("test", "subject_test.txt"))
Xtest <- read.table(file=file.path("test", "X_test.txt"))
Ytest <- read.table(file=file.path("test", "y_test.txt"))
trainsub <- read.table(file=file.path("train", "subject_train.txt"))
Xtrain <- read.table(file=file.path("train", "X_train.txt"))
Ytrain <- read.table(file=file.path("train", "y_train.txt"))

##step 1: merging the data sets
test <- cbind(Xtest, testsub, Ytest)
train <- cbind(Xtrain, trainsub, Ytrain)
total <- rbind(test, train)

##step 2: extract means and standard deviations
variable_names <- read.table("features.txt")
logicalvector <- grepl("(-std\\(\\)|-mean\\(\\))", variable_names$V2)
DataMeanStd <- total[, which(logicalvector == TRUE)]
TidyData <- cbind(DataMeanStd, total[, (562:563)])

##step 3: using descriptive activity names to name the activities in the data set
TidyData$V1.1[TidyData $V1.1 == 1] <- "Walking"
TidyData$V1.1[TidyData$V1.1 == 2] <- "Walking_upstairs"
TidyData$V1.1[TidyData$V1.1 == 3] <- "Walking_downstairs"
TidyData$V1.1[TidyData$V1.1 == 4] <- "Sitting"
TidyData$V1.1[TidyData$V1.1 == 5] <- "Standing"
TidyData$V1.1[TidyData$V1.1 == 6] <- "Laying"

##step 4: Add appropriate labels  with descriptive variable names to the data set. 
i <- grep("(-std\\(\\)|-mean\\(\\))", variable_names$V2)
NeededvarNames <- variable_names[i, 2]
colnames(TidyData) <- NeededvarNames
colnames(TidyData)[67: 68] <- c("subject", "activity")

##step 5: create a second independent tidy data set with the average of each 
## variable for each activity and each subject.
library(reshape2)
moltenData <- melt(TidyData,id.vars=c("subject","activity"))
IndepTidyData <- dcast(moltenData, subject + activity ~ variable,mean)
write.table(IndepTidyData, "datasetJR.txt", row.name=FALSE)

