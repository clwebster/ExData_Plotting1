#plot4
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

#write plot4 to file

png(file="plot4.png",bg="transparent")

#4 panel chart display, 2x2 matrix
par(mfrow = c(2,2))

with( hpower_sub, {
  
  plot(x=DateTime, 
       y=Global_active_power, 
       type="l", 
       xlab="", 
       ylab="Global Active Power"
  )
})

with( hpower_sub, {
  
  plot(x=DateTime, 
       y=Voltage, 
       type="l", 
       xlab="datetime" 
       
  )
})

legend_txt <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend_col <- c("black","red","blue")

with( hpower_sub, {
  
  plot(x=DateTime, 
       y=Sub_metering_1, 
       type="l", 
       xlab="", 
       ylab="Energy sub metering"
  )
  lines(x=DateTime,y=Sub_metering_2,type="l",col="red")
  lines(x=DateTime,y=Sub_metering_3,type="l",col="blue")
  legend("topright",bty = "n", col=legend_col, legend=legend_txt, lty=1)
})

with( hpower_sub, {
  
  plot(x=DateTime, 
       y=Global_reactive_power, 
       type="l", 
       xlab="datetime"
  )
})

dev.off()
