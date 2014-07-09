#Read data from file
powerDat<-read.table("household_power_consumption.txt", header=T, sep=";")

#Change Date column data type to Date
powerDat$Date<-as.Date(powerDat$Date,format="%d/%m/%Y")

#Add new column with combined Date/Time
powerDat$DateTimeCombo<-strptime(paste(powerDat$Date,powerDat$Time),"%Y-%m-%d %H:%M:%S")

#Add column with weekday
powerDat$weekday<-weekdays(powerDat$Date)

#Set boundary dates for subsetting data 
afterDate<-as.Date("31/1/2007", format="%d/%m/%Y")
beforeDate<-as.Date("3/2/2007", format="%d/%m/%Y")

#Subset data using afterDate and beforeDate defined above
powerDatSelect<-powerDat[afterDate < powerDat$Date & powerDat$Date < beforeDate,]

#plot 3
par(mfrow = c(1,1))
plot(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Sub_metering_1)
lines(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Sub_metering_2, col="Red")
lines(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Sub_metering_3, col="Blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5),col=c("black","red","blue"), cex=0.5, pt.cex=1)

#Print plot 3
dev.copy(png, file = "plot3.png")
dev.off()