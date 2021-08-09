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

## plot globalactivepower vs date&time
png("plot2.png", width=480, height=480)
with(dat, plot(FullTimeDate, Global_active_power, type="l", xlab="Day", 
               ylab="Global Active Power (kilowatts)"))
dev.off()