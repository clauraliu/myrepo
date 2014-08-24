The task is broken down into below steps:


1. Read the data into R

Assume the input data are under working directory.

>X_train<-read.table("UCI HAR Dataset/train/X_train.txt")

>y_train<-read.table("UCI HAR Dataset/train/y_train.txt")

>subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt") 

>X_test<-read.table("UCI HAR Dataset/test/X_test.txt")

>y_test<-read.table("UCI HAR Dataset/test/y_test.txt")

>subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")

>features<-read.table("UCI HAR Dataset/features.txt")


2. Merge the data

(1) Merge the training data with the test data

>X<-rbind(X_test,X_train) 

>y<-rbind(y_train,y_test)

>subject<-rbind(subject_train,subject_test)

(2) Associate feature data with Subject and Activity

>data<-cbind(X,subject,y)

(3) Assign columns names to the data set from features names, use "Subject" and "Activity" for the last two columns

>colnames(data)<-c(as.vector(features[,2]),"Subject","Activity")

Column 2 of "features" contains the feature names


3. Replace Activity id with descriptive Activity name

>activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")

>data$Activity<-factor(data$Activity,labels=as.vector(activity_labels$V2)) 

Column 2 of "activity_labels" contains the activity names


4. Generage the subset that contains only mean and standard deviation columns, keep the last two columns: Subject and Activity

>len<-length(data)

>subdata<-subset(data,select=c(grep("mean|std",as.vector(features$V2)),len-1,len))


5. Improve the variable labels

(1) replace "-" with "_"

(2) replace "," with "."

(3) replace "()" with "B" (note: there are no other characters between "(" and ")")

(4) after the above step, replace "(" or ")" to "BR" if there are additional characters between "(" and ")" 

>colnames(subdata)<-gsub("-","_",colnames(subdata))

>colnames(subdata)<-gsub(",",".",colnames(subdata))

>colnames(subdata)<-gsub("\\()","B",colnames(subdata))

>colnames(subdata)<-gsub("\\(|\\)","BR",colnames(subdata))


6. Use reshape2 package to get the mean of each variable based on each Subject and Actitity combination

>library(reshape2)

>meltdata<-melt(subdata,id=c("Subject","Activity"),measure.vars=c(1:79)) #measure variables are all the features columns

>average<-dcast(meltdata,Subject+Activity ~variable,mean) #get the mean based on each Subject and Activity combination


7. Write output to a file

>write.table(average,"./tidy.txt", row.names=FALSE)




