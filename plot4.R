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

#### plotting multiple plots #####
par(mfrow=c(2,2), mar=c(4,4,2,1))
#plot 1
plot(df$Global_active_power~df$Datetime, type="l", ylab="Global Active Power", xlab="")
#plot 2
plot(df$Voltage~df$Datetime, type="l",ylab="Voltage", xlab="datetime")
#plot 3
plot(df$Sub_metering_1~df$Datetime, type="l",ylab="Energy sub metering", xlab="")
    lines(df$Sub_metering_2~df$Datetime,col='Red')
    lines(df$Sub_metering_3~df$Datetime,col='Blue')
# add legends
legend("topright", col=c("black", "red", "blue"),bty = "n", lty=1, lwd=2, cex=0.8,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#cex is used to adjust the text width
#bty="n" gives no border on legends
#plot 4
plot(df$Global_reactive_power~df$Datetime, type="l",ylab="Global_reactive_power",xlab="datetime")

##### copy plot to png device #####
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
