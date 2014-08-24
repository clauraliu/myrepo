#read the data to R
#assume we are under the directory of the extracted input data:./UCI HAR Dataset
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt") 
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
features<-read.table("UCI HAR Dataset/features.txt")

#merge the data
X<-rbind(X_test,X_train) 
y<-rbind(y_train,y_test)
subject<-rbind(subject_train,subject_test)
data<-cbind(X,subject,y)

#assign columns names to the data set from features names, plus Subject and Activity for the last two columns
colnames(data)<-c(as.vector(features[,2]),"Subject","Activity") #column 2 of features contains the feature names

#replace Activity id with descriptive Activity name
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
data$Activity<-factor(data$Activity,labels=as.vector(activity_labels$V2)) #column 2 of activity_labels contains the activity names

#get the subset that contains only mean and standard deviation columns
len<-length(data)
subdata<-subset(data,select=c(grep("mean|std",as.vector(features$V2)),len-1,len)) #keep the last two columns: 
                                                                                  #Subject and Activity

#improve the variable labels
colnames(subdata)<-gsub("-","_",colnames(subdata)) #replace "-" with "_"
colnames(subdata)<-gsub(",",".",colnames(subdata)) #replace "," with "."
colnames(subdata)<-gsub("\\()","B",colnames(subdata)) #replace "()" with "B" (note: there are no other characters in between)
colnames(subdata)<-gsub("\\(|\\)","BR",colnames(subdata)) #replace "(" or ")" to "BR" (note: this has to be after the above step. 
                                                          #It handles the case where "(" and ")" are separated.)

#reshape the above data set. Get the mean of each variable based on each Subject and Actitity combination
library(reshape2)
meltdata<-melt(subdata,id=c("Subject","Activity"),measure.vars=c(1:79)) #measure variables are all the features columns
average<-dcast(meltdata,Subject+Activity ~variable,mean) #get the mean based on each Subject and Activity combination

#write output to a file
write.table(average,"./tidy.txt", row.names=FALSE)
