##Getting data ready
#Data download
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#Data set to date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#Filter data  from Feb. 1, 2007 until Feb. 2, 2007
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#Remove any incomplete observation
data <- data[complete.cases(data),]

#Combine the Date and Time column
dateTime <- paste(data$Date, data$Time)

#Name the vector
dateTime <- setNames(dateTime, "DateTime")

#Remove Date and Time column
data <- data[ ,!(names(data) %in% c("Date","Time"))]

#Add DateTime column
data <- cbind(dateTime, data)

#Format dateTime Column
data$dateTime <- as.POSIXct(dateTime)

##Making the third plot
with(data, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#File is saved
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()