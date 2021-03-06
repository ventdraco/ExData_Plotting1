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

#creating histogram
par(mfrow=c(1,1))
with(xhpc,{
        hist(as.numeric(as.character(Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
                title(main="Global Active Power")
})
##saving the plot in a png extension
dev.copy(png,file = 'plot1.png',width = 480, height = 480)
dev.off()
