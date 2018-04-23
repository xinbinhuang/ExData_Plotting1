## load the data
dat <- read.table("data/household_power_consumption.txt", sep = ";", header = TRUE,
                  na.strings="?")

## subset the data for Date in "1/2/2007","2/2/2007"
finaldat <- subset(dat, Date %in% c("1/2/2007","2/2/2007"))

## Convert 'Date' and 'Time' to Date/Time variable
SetTime <-with(finaldat, strptime(paste(Date, Time, sep=" "),"%d/%m/%Y %H:%M:%S"))
finaldat <- cbind(SetTime, finaldat)
finaldat <- subset(finaldat, select = c(-Date, -Time))


labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columnlines <- c("black","red","blue")

with(finaldat, 
     {par(mfrow=c(2,2)) # set up the panel
      # first plot
      plot(SetTime, Global_active_power, type="l", col="red", xlab="", ylab="Global Active Power")
      # second plot
      plot(SetTime, Voltage, type="l", col="coral", xlab="datetime", ylab="Voltage")
      # third plot 
      plot(SetTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
            lines(SetTime, Sub_metering_2, type="l", col="red")
            lines(SetTime, Sub_metering_3, type="l", col="blue")
            legend("topright", bty="n", legend=labels, lty=1, col=columnlines)
      # fourth plot
      plot(SetTime, Global_reactive_power, type="l", col="blue", xlab="datetime", ylab="Global_reactive_power")})

dev.copy(png, file = "plot4.png", width=480,height= 480)
dev.off()
