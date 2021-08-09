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
dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)

#Plot
png("plot3.png", width=480, height=480)
with(dat, plot(FullTimeDate, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering"))
lines(dat$FullTimeDate, dat$Sub_metering_2,type="l", col= "red")
lines(dat$FullTimeDate, dat$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
dev.off()