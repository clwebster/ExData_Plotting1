#plot1
fileName <- "household_power_consumption.txt"

hpower <-read.table(fileName,sep=";",header=TRUE)

#recast to Date class so we can subselect on a date range
hpower$Date <- as.Date(hpower$Date, format='%d/%m/%Y')
hpower_sub <- subset(hpower, Date >= "2007-02-01" & Date <="2007-02-02")

#remove hpower to release from memory
remove(hpower)

#add combo date/time variable
hpower_sub$DateTime <- strptime(paste(format(hpower_sub$Date,"%Y-%m-%d"),as.character(hpower_sub$Time)),"%Y-%m-%d %H:%M:%S")

#recast variables to numeric
hpower_sub$Global_active_power <- as.numeric(as.character(hpower_sub$Global_active_power))
hpower_sub$Global_reactive_power <- as.numeric(as.character(hpower_sub$Global_reactive_power))
hpower_sub$Voltage <- as.numeric(as.character(hpower_sub$Voltage))
hpower_sub$Sub_metering_1 <- as.numeric(as.character(hpower_sub$Sub_metering_1))
hpower_sub$Sub_metering_2 <- as.numeric(as.character(hpower_sub$Sub_metering_2))
hpower_sub$Sub_metering_3 <- as.numeric(as.character(hpower_sub$Sub_metering_3))

#plot1 - create histogram plot and write to file

png(file="plot1.png",bg="transparent")
par(mfrow = c(1,1))

with(hpower_sub, {
hist(Global_active_power, 
     col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power"
    )
})

dev.off()
