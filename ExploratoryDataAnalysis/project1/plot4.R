require(sqldf)
data <- read.csv.sql( file='./household_power_consumption.txt',
                      sep=";",
                      sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                      header=TRUE)
data$Timestamp = strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
png("plot4.png",width = 480, height = 480)

par(mfrow=c(2,2))

plot(data$Timestamp,data$Global_active_power,type="l",xlab="",ylab="Global Active Power")
plot(data$Timestamp,data$Voltage,type="l",xlab="datetime",ylab="Voltage")
plot(data$Timestamp,data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(data$Timestamp, data$Sub_metering_2, type = "l", col = "red")
lines(data$Timestamp, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, bty='n',col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data$Timestamp,data$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()

