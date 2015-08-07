## Load in necessary libraries
library(dplyr)
library(data.table)

## Reads in data from file then subsets data for specified dates
dataFile <- fread("./data/household_power_consumption.txt", na.strings="?",stringsAsFactors = FALSE)
data <- filter(dataFile, grep("^[1,2]/2/2007", Date))

## Convert Global_active_power to numberic
globalActivePower <- as.numeric(data$Global_active_power)

## Set date to correct format
datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

## create graph
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()