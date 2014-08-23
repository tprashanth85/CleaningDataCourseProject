#This code reads the test and training sets and combines them to form one data set. 
#Columns with mean and SD in the names are extracted out from the data set
#The first column is the Subject ID, the second column is the Activity to which activity labels
#will be given. The remaining columns are the feature measurements. The mean of the columns is 
#taken and presented as the second data set.

#Set the working directory
setwd("D:/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset")

#Read the test data set
xtestdata <- read.table("./test/X_test.txt",header=FALSE,sep="")
ytestdata <- read.table("./test/y_test.txt",header=FALSE,sep="")
subtest <- read.table("./test/subject_test.txt",header=FALSE,sep="")

#Read the training data set
xtraindata <- read.table("./train/X_train.txt",header=FALSE,sep="")
ytraindata <- read.table("./train/y_train.txt",header=FALSE,sep="")
subtrain <- read.table("./train/subject_train.txt",header=FALSE,sep="")

#Make the test data frame with Test subject, test activity number and test metrics
#Make the train data frame with Training subject, training activity number and training metrics
testdf <- data.frame(subtest,ytestdata,xtestdata)
traindf <- data.frame(subtrain,ytraindata,xtraindata)

#Combine the testing and training data frames, first column has subject, second column has activity
#remaining columns are the metrics
totaldf <- rbind(testdf,traindf)

#Read the second column and replace the activity numbers with activity names 
actlabel <- read.table("activity_labels.txt",header=FALSE,sep="")
for(i in 1:nrow(actlabel))
{
  index <- totaldf[,2] %in% actlabel[i,1]
  totaldf[index,2] <- as.character(actlabel[i,2])
}

#Read the features.txt file and provide them as column names to the measurements columns
varnames <- read.table("features.txt",header=FALSE,sep="")
colnames(totaldf) <- c("Subject","Activity",as.character(varnames[,2]))

#Create a data frame by extracting the columns with mean and std in the column names
extractdf <- data.frame("Subject"=totaldf$Subject,"Activity"=totaldf$Activity)
extractdf <- cbind(extractdf,totaldf[,grep("(.*)\\-mean(.*|\\(\\))(-*)(.*)",colnames(totaldf),value=TRUE)])
extractdf <- cbind(extractdf,totaldf[,grep("(.*)\\-std(.*|\\(\\))(-*)(.*)",colnames(totaldf),value=TRUE)])

#Start creating a new data frame that will give mean for each measurement for each activity of
#each subject
summarydf <- data.frame()
#Split extracted data frame on subject
subjectdf <- split(extractdf,extractdf$Subject)
for(i in 1:length(subjectdf))
{
  #for each subject data, split it based on activity
  activitydf <- split(subjectdf[[i]],subjectdf[[i]]$Activity)
  for(j in 1:length(activitydf))
  {
    #for each activity data, calculate the mean for all the measurements
    #and append it to final data frame
    summarylist <- c(activitydf[[j]][1,1],activitydf[[j]][1,2],colMeans(activitydf[[j]][3:ncol(activitydf[[j]])]))
    summarydf <- rbind(summarydf,summarylist)
    
  }
}

#Since the activity labels are lost in the extraction, provide activity labels again in column 2
for(i in 1:nrow(actlabel))
{
  index <- summarydf[,2] %in% actlabel[i,1]
  summarydf[index,2] <- as.character(actlabel[i,2])
}
colnames(summarydf) <- colnames(extractdf)

#Write new data frame to a text file
write.table(summarydf,file="analysis_summary.txt",row.names=FALSE)


