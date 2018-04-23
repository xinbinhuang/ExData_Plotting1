## load the data
dat <- read.table("data/household_power_consumption.txt", sep = ";", header = TRUE,
                  na.strings="?")

## subset the data for Date in "1/2/2007","2/2/2007"
finaldat <- subset(dat, Date %in% c("1/2/2007","2/2/2007"))

## Convert 'Date' and 'Time' to Date/Time variable
SetTime <-with(finaldat, strptime(paste(Date, Time, sep=" "),"%d/%m/%Y %H:%M:%S"))
finaldat <- cbind(SetTime, finaldat)
finaldat <- subset(finaldat, select = c(-Date, -Time))

with(finaldat, plot(SetTime, Global_active_power, type="l", 
     col="black", xlab="", ylab="Global Active Power (kilowatts)"))

dev.copy(png, file = "plot2.png", width=480,height= 480)
dev.off()
