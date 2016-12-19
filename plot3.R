setClass('my_Date')
setClass('my_Time')
par(mfrow=c(1,1))

setAs("character","my_Date", function(from) as.Date(from, format="%d/%m/%Y") )
setAs('character', 'my_Time', function(from) as.POSIXct(from, format="%H:%M:%S") )


power_data <- read.csv('household_power_consumption.csv', 
                       header=TRUE, 
                       colClasses = c('my_Date', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'), 
                       na.strings = '?')

power_data$DateTime <- with(power_data, strptime(paste(power_data$Date,power_data$Time), format=("%Y-%m-%d %H:%M:%S")))
time_slice <- as.Date(c("2/1/2007", '2/2/2007'), format="%m/%d/%Y")

power_data_2day <- subset(power_data, power_data$Date %in% time_slice)

plot(power_data_2day$DateTime, 
     power_data_2day$Sub_metering_1,
     type='n',
     ylab="Energy sub Metering",
     xlab="", 
     lty = 'solid', 
     col='black')

points(power_data_2day$DateTime,
       power_data_2day$Sub_metering_1,
       col = 'black', 
       type = 'l')

points(power_data_2day$DateTime,
       power_data_2day$Sub_metering_2,
       col = 'red', 
       type = 'l')

points(power_data_2day$DateTime,
       power_data_2day$Sub_metering_3,
       col = 'blue', 
       type = 'l')

legend("topright", c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black','red','blue'), lty=c(1,1,1))

dev.copy(png,'plot3.png')
dev.off()


