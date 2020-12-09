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

##Converting Time variables to Time
xhpc$Time <- strptime(xhpc$Time, format="%H:%M:%S")
xhpc[1:1440,"Time"] <- format(xhpc[1:1440,"Time"],"2007-02-01 %H:%M:%S")
xhpc[1441:2880,"Time"] <- format(xhpc[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

##Creating plot
par(mfrow=c(1,1))
with(xhpc,{
        plot(Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
                lines(Time,as.numeric(as.character(Sub_metering_1)))
                lines(Time,as.numeric(as.character(Sub_metering_2)),col="red")
                lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue")
                legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub metering 1","Sub metering 2","Sub metering 3"))
})
##saving the plot in a png extension 
dev.copy(png,'plot3.png')
dev.off()
