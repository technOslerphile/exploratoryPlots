temp <- tempfile() ##creating a name for tempfile
##downloading the dataset from server
download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", temp)
##unzipping the tempfile downloaded
con <- unz(temp, "household_power_consumption.txt")
##reading data
data <- read.table(con, header=T, sep=";", na.strings=c("", "NA", "?"))
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- as.POSIXct(data$Time,format="%H:%M:%S")
projectData <- subset(data, Date =="2007-02-01" | Date=="2007-02-02")
##setting the working directory in my computer
setwd("D:/Acads/ExploratoryDataAnalysis/Project01") ##this is my working directory
##PLEASE CHANGE THE WORKING DIRECTORY FOR YOUR R SESSION ACCORDINGLY. OTHERWISE THE ABOVE LINE OF CODE WILL RETURN ERROR
hist(projectData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)" ,col="red")
png(file="plot1.png", width=480, height=480)
hist(projectData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)" ,col="red")
dev.off()
