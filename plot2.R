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

# creating plot
with(xhpc,{
        plot(Time, as.numeric(as.character(Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)") 
                title(main="Global Active Power Vs Time")
})


