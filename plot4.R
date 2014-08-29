temp <- tempfile() ##creating a name for tempfile
##downloading the dataset from server
download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", temp)
##unzipping the tempfile downloaded
con <- unz(temp, "household_power_consumption.txt")
##reading data
data <- read.table(con, header=T, sep=";", na.strings=c("", "NA", "?"))
datetime <- paste(data$Date, data$Time)
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
data$datetime <- datetime
data$Date <- as.Date(data$Date, "%d/%m/%Y")
projectData <- subset(data, Date =="2007-02-01" | Date=="2007-02-02")
projectData$datetime <- as.Date(projectData$datetime)
x <- 1:2880
projectData$index <- x
png(file="plot4.png", width=480, height=480)
par(mfcol=c(2,2), mar=c(4,4,0.5,0.5))
plot(projectData$Global_active_power~x, xlab="", type="l", xaxt="n", ylab="Global Active Power")
axis(side=1, at=c(x[1],x[1440], x[2880]), labels=c("Thu", "Fri", "Sat"))
plot(projectData$Sub_metering_1~projectData$index, xlab="", ylab="Energy sub metering", type="l", xaxt="n")
points(projectData$Sub_metering_2, col="red", type="l")
points(projectData$Sub_metering_3, col="blue", type="l")
axis(side=1, at=c(x[1],x[1440], x[2880]), labels=c("Thu", "Fri", "Sat"))
legend("topright",  bty="n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "blue", "red"), lty=c(1,1,1))
plot(projectData$Voltage~projectData$index, ylab="Voltage", xaxt="n", xlab="datetime", type="l")
axis(side=1, at=c(x[1], x[1440], x[2880]), labels=c("Thu", "Fri", "Sat"))
plot(projectData$Global_reactive_power~projectData$index, ylab="Global_reactive_power", xaxt="n", xlab="datetime", type="l")
axis(side=1, at=c(x[1], x[1440], x[2880]), labels=c("Thu", "Fri", "Sat"))
dev.off()
