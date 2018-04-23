## load the data
dat <- read.table("data/household_power_consumption.txt", sep = ";", header = TRUE,
                  na.strings="?")

## subset the data for Date in "1/2/2007","2/2/2007"
finaldat <- subset(dat, Date %in% c("1/2/2007","2/2/2007"))

## Convert 'Date' and 'Time' to Date/Time variable
SetTime <-with(finaldat, strptime(paste(Date, Time, sep=" "),"%d/%m/%Y %H:%M:%S"))
finaldat <- cbind(SetTime, finaldat)
finaldat <- subset(finaldat, select = c(-Date, -Time))

columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

with(finaldat, {plot(SetTime, Sub_metering_1, type="l", col=columnlines[1], xlab="", ylab="Energy sub metering")
                  lines(SetTime, Sub_metering_2, col=columnlines[2])
                  lines(SetTime, Sub_metering_3, col=columnlines[3])
                  legend("topright", legend=labels, col=columnlines, lty="solid")})

dev.copy(png, file = "plot3.png", width=480,height= 480)
dev.off()
