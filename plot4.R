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
hpc<- read.table("household_power_consumption.txt", sep = ";" ,header = TRUE, na.strings = '?')
xhpc <- subset(hpc,Date=="1/2/2007" | Date =="2/2/2007")

##Converting Time variables to Time
xhpc$Time <- strptime(paste(xhpc$Date, xhpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

##creating plots
par(mfrow=c(2,2))
with(xhpc,{
        plot(Time,as.numeric(as.character(Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
        plot(Time,as.numeric(as.character(Voltage)), type="l",xlab="datetime",ylab="Voltage")
        plot(Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
                lines(Time,as.numeric(as.character(Sub_metering_1)))
                lines(Time,as.numeric(as.character(Sub_metering_2)),col="red")
                lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue")
                legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
        plot(Time,as.numeric(as.character(Global_reactive_power)),type="l",xlab="datetime",ylab="Global reactive power")
})
##saving the plot in a png extension
dev.copy(png,file = 'plot4.png',width = 480, height = 480)
dev.off()
