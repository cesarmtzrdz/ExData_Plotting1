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

#plot3, dont know why but the f***ng RStudio didn't let me generate the graph, I had to use RConsole..
plot(POSIXltDate, febData$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
points(POSIXltDate, febData$Sub_metering_2, type="l", col="red")
points(POSIXltDate, febData$Sub_metering_3, type="l", col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"),lty = c(1, 1, 1))

#save to png
dev.copy(png,filename="plot3.png",width=480, height=480);

#back to screen
dev.off()