require(sqldf)
data <- read.csv.sql( file='./household_power_consumption.txt',
                      sep=";",
                      sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                      header=TRUE)
data$Timestamp = strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
png("plot3.png",width = 480, height = 480)
plot(data$Timestamp,data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(data$Timestamp, data$Sub_metering_2, type = "l", col = "red")
lines(data$Timestamp, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
