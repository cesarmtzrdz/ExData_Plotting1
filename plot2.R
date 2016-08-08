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

#plot2
plot(POSIXltDate, febData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#save to png
dev.copy(png,filename="plot2.png",width=480, height=480);

#back to screen
dev.off()