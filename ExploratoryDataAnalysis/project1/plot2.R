require(sqldf)
data <- read.csv.sql( file='./household_power_consumption.txt',
                      sep=";",
                      sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                      header=TRUE)
data$Timestamp = strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
png("plot2.png",width = 480, height = 480)
plot(data$Timestamp,data$Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)")
dev.off()
