# Getting data from raw file
data<- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subsetting period of time and converting date 
datasubset <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)
datetime <- paste(as.Date(datasubset$Date), datasubset$Time)
datasubset$Datetime <- as.POSIXct(datetime)

# Plotting plot4 and save to png file
par(mfrow=c(2,2), mar=c(4,5,2,1))
with(datasubset, {
        plot(Global_active_power ~ Datetime, type="l", ylab="Global Active Power", xlab="")
        plot(Voltage ~ Datetime, type="l", ylab="Voltage", xlab="")
        plot(Sub_metering_1 ~ Datetime, type="l", ylab="Energy sub metering", xlab="")
          lines(Sub_metering_2 ~ Datetime, col='Red')
          lines(Sub_metering_3 ~ Datetime, col='Blue')
          legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l", ylab="Global_rective_power",xlab="")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
