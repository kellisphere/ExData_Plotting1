## Load in necessary libraries
library(dplyr)
library(data.table)

## Read data and subsets data for specified dates 1/2, 2/2 - d/m
dataFile <- fread("./data/household_power_consumption.txt", na.strings="?",stringsAsFactors = FALSE)
data <- filter(dataFile, grep("^[1,2]/2/2007", Date))

## convert data to numeric
globalActivePower <- as.numeric(data$Global_active_power)
subMetering1 <- as.numeric(data$Sub_metering_1)
subMetering2 <- as.numeric(data$Sub_metering_2)
subMetering3 <- as.numeric(data$Sub_metering_3)

## Set date to correct format
datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

## plot/create graph
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.8, col=c("black", "red", "blue"))

## Saving to file png format 480x480
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
