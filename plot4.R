#to convert to date class
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )


#get the file
data <- read.table(file="household_power_consumption.txt",header = TRUE,sep=";", dec=".", colClasses = c('myDate','factor','numeric','numeric','numeric','numeric','numeric','numeric','numeric'), na.strings='?')

#list the col names
names(data)

#subset Feb 1 and 2 only
febData <- subset(data,Date >= "2007-02-01" & Date <= "2007-02-02")

#free space
rm("data")

#but we need the POSIXlt class so we can get the days in the x axis
POSIXltDate <- strptime(paste(as.character(febData$Date), febData$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 

#plot4, set to 2, 2
#same as plot 4, RStudio didn't let me generate the graph, I had to use RConsole..
par(mfrow = c(2, 2))
#upleft
plot(POSIXltDate, febData$Global_active_power, type="l", xlab="", ylab="Global Active Power")

#top right
plot(POSIXltDate, febData$Voltage, xlab="datetime",type="l", ylab="Voltage")

#bottom left
plot(POSIXltDate, febData$Sub_metering_1, ylab="Energy Submetering", xlab="",type="l")
points(POSIXltDate, febData$Sub_metering_2, col="red",type="l")
points(POSIXltDate, febData$Sub_metering_3, col="blue",type="l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = c(1, 1, 1))

#bottom right
plot(POSIXltDate, febData$Global_reactive_power, type="l",xlab="datetime", ylab="Global_reactive_power")



#save to png
dev.copy(png,filename="plot4.png",width=480, height=480);

#back to screen
dev.off()