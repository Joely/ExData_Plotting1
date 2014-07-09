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

#plot 2
par(mfrow = c(1,1))
plot(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Global_active_power,type="n",xlab="",ylab="Global Active Power (kilowatts)")
lines(x=powerDatSelect$DateTimeCombo,y=powerDatSelect$Global_active_power)

#Print plot 2
dev.copy(png, file = "plot2.png")
dev.off()