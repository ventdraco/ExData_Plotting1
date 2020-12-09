library(dplyr)
filename <- "Dataset.zip"
##checking if the file already exists, if it doesn't it will download it
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, filename, method="curl")
} 
##unzip the file, if it doesn't exists on the path.
if (!file.exists("Exploratory Analisys")) { 
        unzip(filename) 
}
##checking files
list.files("./", recursive=TRUE)

##Reading data
hpc<- read.table("household_power_consumption.txt", sep = ";" ,header = TRUE)
xhpc <- subset(hpc,Date=="1/2/2007" | Date =="2/2/2007")

xhpc$Time <- strptime(xhpc$Time, format="%H:%M:%S")
xhpc[1:1440,"Time"] <- format(xhpc[1:1440,"Time"],"2007-02-01 %H:%M:%S")
xhpc[1441:2880,"Time"] <- format(xhpc[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

##creating plots
par(mfrow=c(2,2))
plot(xhpc$Time,as.numeric(as.character(xhpc$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
plot(xhpc$Time,as.numeric(as.character(xhpc$Voltage)), type="l",xlab="datetime",ylab="Voltage")
plot(xhpc$Time,xhpc$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(xhpc,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(xhpc,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(xhpc,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
plot(xhpc$Time,as.numeric(as.character(xhpc$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")

