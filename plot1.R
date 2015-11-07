#########################################################################
## Cousera Exploratory Data Analysis Course - Project 1 Week 1
## Plot1 genaration file Script
#########################################################################
#Liberary call - sqldf
library(sqldf)


# Data Download 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileTmpZip <- "household_power_consumption.zip"
download.file(fileUrl, destfile = fileTmpZip)

# data claesing
RawDataSet <- read.csv.sql(unzip(fileTmpZip),header = TRUE, sep = ";", sql = "select * from file where Date in('1/2/2007','2/2/2007')")
unlink(fileTmpZip)

#Change Data Type from Char to Date
RawDataSet$Date <- as.Date(RawDataSet$Date,"%d/%m/%Y")

#Change Data Type from Char to Time
tmpTime <- paste(RawDataSet$Date, " ", RawDataSet$Time)

RawDataSet$Time <- strptime(tmpTime,"%Y-%m-%d %H:%M:%S")

# remove tmp variable
rm(tmpTime)

#Plot 1
#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12,bg = "white")
hist(RawDataSet$Global_active_power, col = "red", main = "Global Active Power", xlab ="Global Active Power (kilowatts)")
dev.off() 


