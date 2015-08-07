## Load in necessary libraries
library(dplyr)
library(data.table)

## Read data from file then subsets data for specified dates
dataFile <- fread("./data/household_power_consumption.txt", na.strings="?",stringsAsFactors = FALSE)
data <- filter(dataFile, grep("^[1,2]/2/2007", Date))

## Set date to correct format
datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

## convert data to numerics
globalActivePower <- as.numeric(data$Global_active_power)
globalReactivePower <- as.numeric(data$Global_reactive_power)
voltage <- as.numeric(data$Voltage)
subMetering1 <- as.numeric(data$Sub_metering_1)
subMetering2 <- as.numeric(data$Sub_metering_2)
subMetering3 <- as.numeric(data$Sub_metering_3)

## create 2x2 for four graphs
par(mfrow = c(2, 2)) 

## upper left Global Active Power graph
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

## upper right Voltage graph
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

## lower left Energy sub metering graph with legend
plot(datetime, subMetering1, type="l", ylab="Energy sub metering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.8, col=c("black", "red", "blue"), bty="o")

## graph lower right Reactive power
plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

## Saving to file png format 480x480
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
