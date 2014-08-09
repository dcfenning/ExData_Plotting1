
##Plot1 - Creates a histogram that shows the frequency
##grouped by Global Active Power (kilowatts) and exports a .png file

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
subdata <- read.table("./plot1data/household_power_consumption.txt", sep=";", col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","sub_metering1","sub_metering2","sub_metering3"), na.strings="?",skip=66637, nrow=2880)

##create histogram of Global Active Power
##Labels X axis, adds title, colours bars to red
##creates Plot1.png file and closes png file device
png(file="plot1.png", width = 480, height = 480)
hist(subdata$Global_active_power, col ="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()


