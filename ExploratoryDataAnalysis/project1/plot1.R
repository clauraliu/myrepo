require(sqldf)
data <- read.csv.sql( file='./household_power_consumption.txt',
                      sep=";",
                      sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                      header=TRUE)
png("plot1.png",width = 480, height = 480)
 hist(data$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.off()
