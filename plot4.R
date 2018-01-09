#load data
dat<-read.table("household_power_consumption.txt",sep = ";", header = TRUE)
#format date
dat$Date<-as.Date(dat$Date,"%d/%m/%Y")
#subset 2 days data
dat2<-subset(dat,dat$Date=="2007-02-01"|dat$Date=="2007-02-02")
#transform time format
dat2$DateTime<-strptime(paste(dat2$Date,dat2$Time),"%Y-%m-%d %H:%M:%S")
#replace "?"
dat2[,3:9]<-lapply(dat2[,3:9], gsub, pattern="?", replacement=NA, fixed=TRUE)
#convert char to numberic
dat2[,3:9]<-lapply(dat2[,3:9],as.numeric)
#open png device
png(filename = "plot4.png", width = 480, height = 480, units = "px")
#plot 
par(mfrow=c(2,2))
#chart 1
plot(dat2$DateTime,dat2$Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)", xlab=" ")
#chart2
plot(dat2$DateTime,dat2$Voltage,type = "l", ylab = "Voltage", xlab="datetime")
#chart3
plot(dat2$DateTime,dat2$Sub_metering_1,type = "n", ylab = "Energy sub metering", xlab = " ")
lines(dat2$DateTime,dat2$Sub_metering_1)
lines(dat2$DateTime,dat2$Sub_metering_2,col="red")
lines(dat2$DateTime,dat2$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1), col=c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n",cex = 0.9)
#chart4
plot(dat2$DateTime,dat2$Global_reactive_power,type = "l",ylab = "Global_reactive_power", xlab="datetime")
#close device
dev.off()