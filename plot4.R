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

#plot 4
png("plot4.png")
  par(mfrow = c(2,2))
  par(mar=c(5.1, 4.1, 4.1, 2.1))
  #1st plot
  plot(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Global_active_power,type="n",xlab="",ylab="Global Active Power (kilowatts)")
  lines(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Global_active_power)
  
  #2nd plot
  plot(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Voltage,type="n",xlab="datetime",ylab="Voltage")
  lines(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Voltage)
  
  #3rd plot
  plot(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  lines(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Sub_metering_1)
  lines(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Sub_metering_2, col="Red")
  lines(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Sub_metering_3, col="Blue")
  legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black","red","blue"), bty = "n")
  
  #4th plot
  plot(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Global_reactive_power,type="n",xlab="datetime",ylab="Global_reactive_power")
  lines(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Global_reactive_power)

dev.off()