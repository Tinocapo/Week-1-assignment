library(data.table) #to use the fread() function
dat <- fread("household_power_consumption.txt") #Read .txt
dat <- subset(dat, Date == "1/2/2007" | Date == "2/2/2007") #Grab only those 2 days
hist1 <- as.numeric(dat$Global_active_power) #make global active power numeric
hist(hist1,
     col = "red",
     main = "Global Active Power", 
     xlab= "Global Active Power (killowatts)") #Create histogram

dev.copy(png, file = "plot1.png") #take it to your directory as a png
dev.off() 
