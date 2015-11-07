#########################################################################
## Cousera Exploratory Data Analysis Course - Project 1 Week 1
## Plot4 genaration file Script
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

#Plot 4
#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12,bg = "white")

par(mfrow=c(2,2), mar=c(4,4,2,2))

plot(RawDataSet$Time, RawDataSet$Global_active_power, ylab ="Global Active Power", xlab="", type = "l")

plot(RawDataSet$Time, RawDataSet$Voltage, ylab ="Voltage", xlab="datetime", type = "l")

plot(RawDataSet$Time, RawDataSet$Sub_metering_1, type = "l", ylab ="Energy sub metering", xlab="")

points(RawDataSet$Time, RawDataSet$Sub_metering_2, type = "l", col="red")

points(RawDataSet$Time, RawDataSet$Sub_metering_3, type = "l", col="blue")


legend("topright",cex=0.6,lty=1:1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))



plot(RawDataSet$Time, RawDataSet$Global_reactive_power, ylab ="Global_reactive_power", xlab="datetime", type = "l")
     

dev.off() 