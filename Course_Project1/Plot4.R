##Plot4 - Creates a line chart
##of Global Active Power (kilowatts) over time and exports to a .png file

##Checks to see if the file already exists, otherwise creates
##a directory for the data.  Then download the file from fileurl
##and save it as rawfile.zip. 
##then unzip the file ready for reading into R.

if(!file.exists("./plot1data/rawfile.zip")){
  dir.create("./plot1data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  dfile <- "./plot1data/rawfile.zip"
  download.file(fileUrl, destfile=dfile)
  dateDownloaded <- date()
  unzip(dfile, overwrite=TRUE, exdir="./plot1data")
}
##read data - selects only data from dates 2007-02-01 to 2007-02-02 only by reading from line 66637 and 2880 rows only
subdata <- read.table("./plot3data/household_power_consumption.txt", sep=";", col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","sub_metering_1","sub_metering_2","sub_metering_3"), na.strings="?",skip=66637, nrow=2880)
##Pastes the Date and Time columns and converts to a DateTime variable 
subdata$DateTime <- paste(subdata$Date," ",subdata$Time)
subdata$DateTime <- strptime(subdata$DateTime, "%d/%m/%Y %H:%M:%S")

##create 4 charts on one file
##creates Plot4.png file and closes png file device
png(file="plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

##plot chart top left
##Global active power over time
plot(subdata$DateTime,subdata$Global_active_power,type ="l", ylab="Global Active Power", xlab="")

##plot chart top right
##voltage over time
plot(subdata$DateTime,subdata$Voltage,type ="l", ylab="Voltage", xlab="datetime")

##plot chart bottom left
##sub meters over time
plot(subdata$DateTime, subdata$sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab="")
lines(subdata$DateTime, subdata$sub_metering_2, type="l",col="red")
lines(subdata$DateTime, subdata$sub_metering_3, type="l",col="blue")
legend("topright", legend = names(subdata[7:9]), lty = 1, col=c("black","red","blue"))

##plot chart bottom right
##Global reactive power over time
plot(subdata$DateTime,subdata$Global_reactive_power,type ="l", ylab="Global_rective_power", xlab="datetime")

dev.off()
