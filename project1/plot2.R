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

datetime <- paste(as.Date(df$Date,format="%d/%m/%Y"), df$Time)
df$Datetime <- as.POSIXct(datetime)

#### make plot between global active power and datetime #####
plot(df$Global_active_power~df$Datetime, type="l",
    ylab="Global Active Power (kilowatts)", xlab="")

#### copy plot to png device #####
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
