library(data.table) #to use the fread() function
dat <- fread("household_power_consumption.txt") #Read .txt
dat <- subset(dat, Date == "1/2/2007" | Date == "2/2/2007") #Grab only those 2 days

#Create column and merge together
FullTimeDate <- strptime(paste(dat$Date, dat$Time, sep=" "),
                         "%d/%m/%Y %H:%M:%S")
dat <- cbind(dat, FullTimeDate)

## change class of all columns to correct class
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
dat$Time <- format(dat$Time, format="%H:%M:%S")
dat$Global_active_power <- as.numeric(dat$Global_active_power)
dat$Global_reactive_power <- as.numeric(dat$Global_reactive_power)
dat$Voltage <- as.numeric(dat$Voltage)
dat$Global_intensity <- as.numeric(dat$Global_intensity)
dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)


## plot the 4 graphs
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(dat, plot(FullTimeDate, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(dat, plot(FullTimeDate, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(dat, plot(FullTimeDate, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(dat$FullTimeDate, dat$Sub_metering_2,type="l", col= "red")
lines(dat$FullTimeDate, dat$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(dat, plot(FullTimeDate, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()