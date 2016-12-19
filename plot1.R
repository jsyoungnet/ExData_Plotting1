setClass('my_Date')
setClass('my_Time')

par(mfrow=c(1,1))
setAs("character","my_Date", function(from) as.Date(from, format="%d/%m/%Y") )
setAs('character', 'my_Time', function(from) as.POSIXct(from, format="%H:%M:%S") )


power_data <- read.csv('household_power_consumption.csv', 
                       header=TRUE, 
                       colClasses = c('my_Date', 'my_Time', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'), 
                       na.strings = '?')

time_slice <- as.Date(c("2/1/2007", '2/2/2007'), format="%m/%d/%Y")

power_data_2day <- subset(power_data, power_data$Date %in% time_slice)

hist(power_data_2day$Global_active_power, 
     col='red', 
     ylab="Frequency", 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power")

dev.copy(png,'plot1.png')
dev.off()