##### Download the dataset if not already downloaded #####

 filename<-"household_data.zip"
 if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename,mode="wb")
 }  
 if(!file.exists("household_power_consumption.txt")){ 
  unzip(zipfile=filename, exdir=".") 
 }

 ##### Making file connection using sqldf package #####
householdpower<-"household_power_consumption.txt"
fi<-file(householdpower)
install.packages("sqldf")
library(sqldf)

 ##### Reading only the required data #####
query<- "select * FROM fi WHERE Date=='1/2/2007' OR Date=='2/2/2007'"
df <- sqldf(query,file.format = list(header = TRUE, sep = ";",na.strings="?"))
close(fi)

### Create histogram #####
hist(as.numeric(df$Global_active_power), main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

### Copy to png file #####
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
