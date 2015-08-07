## Load in necessary libraries
library(dplyr)
library(data.table)

## Read data from file then subsets data for specified dates
dataFile <- fread("./data/household_power_consumption.txt", na.strings="?",stringsAsFactors = FALSE)
data <- filter(dataFile, grep("^[1,2]/2/2007", Date))

## Convert Global_active_power to numberic
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

## Create histogram graph for Global Active Power
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

## Saving to file png format 480x48
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
