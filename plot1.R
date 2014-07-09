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

#plot 1
par(mfrow = c(1,1))
hist(powerDatSelect$Global_active_power, ylab="Frequency", xlab="Global Active Power (kilowatts)", breaks=seq(from=0, to=8, by=0.5), xlim=c(0,6), ylim=c(0,1200), col="red", main="Global Active Power", xaxt="n", yaxt="n")
axis(1, at=c(0,2,4,6), labels=c(0,2,4,6))
axis(2, at=seq(0,1200,200), labels=seq(0,1200,200))
#Print plot 1
dev.copy(png, file = "plot1.png")
dev.off()