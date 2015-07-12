##Reading the data from the downloaded text file
x <- read.csv(
        "household_power_consumption.txt", 
        header=T, sep=';', na.strings="?", ##setting the na values to ?
        nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"'
)
##Setting the date formate
x$Date <- as.Date(x$Date, format="%d/%m/%Y")

##subset the whole data to two days only
subData <- subset(x, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))


## creating an new column named datetime
datetime <- paste(as.Date(subData$Date), subData$Time)
subData$Datetime <- as.POSIXct(datetime)

## generating Plot 3
with(subData, {
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## creating plot3.png and saving it to the working directory
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()