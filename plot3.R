temp <- tempfile() ##creating a name for tempfile
##downloading the dataset from server
download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", temp)
##unzipping the tempfile downloaded
con <- unz(temp, "household_power_consumption.txt")
##reading data
data <- read.table(con, header=T, sep=";", na.strings=c("", "NA", "?"))
datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
projectData <- subset(data, Date =="2007-02-01" | Date=="2007-02-02")
projectData$datetime <- as.Date(projectData$datetime)
x <- 1:2880
projectData$index <- x
setwd("D:/Acads/ExploratoryDataAnalysis/Project01") ##PLEASE SET YOUR OWN WORKING DIRECTORY TO SAVE THE PNG FILE
png(file="plot3.png", width=480, height=480)
plot(projectData$Sub_metering_1~projectData$index, xlab="", ylab="Energy sub metering", type="l", xaxt="n")
points(projectData$Sub_metering_2, col="red", type="l")
points(projectData$Sub_metering_3, col="blue", type="l")
axis(side=1, at=c(x[1],x[1440], x[2880]), labels=c("Thu", "Fri", "Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "blue", "red"), lty=c(1,1,1))
dev.off()
