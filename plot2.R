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
setwd("D:/Acads/ExploratoryDataAnalysis/Project01") ##PLEASE SET YOUR OWN WORKING DIRECTORY WHERE THE PNG FILE WILL BE SAVED
png(file="plot2.png", width=480, height=480)
plot(projectData$Global_active_power~x, xlab="", type="l", xaxt="n", ylab="Global Active Power (kilowatts)")
axis(side=1, at=c(x[1],x[1440], x[2880]), labels=c("Thu", "Fri", "Sat"))
dev.off()
