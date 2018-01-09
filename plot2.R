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
png(filename = "plot2.png", width = 480, height = 480, units = "px")
#plot 
plot(dat2$DateTime,dat2$Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)", xlab=" ")
#close device
dev.off()