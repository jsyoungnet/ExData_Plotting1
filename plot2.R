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
     power_data_2day$Global_active_power,
     type='l',
     ylab="Global Active Power (kilowatts)",
     xlab="", 
     lty = 'solid')


dev.copy(png,'plot2.png')
dev.off()

