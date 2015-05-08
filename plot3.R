# reading the file directly from the web
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
household_power_consumption <- read.csv(unz(temp, "household_power_consumption.txt"),header=T, sep=";", na.strings="?", colClasses= c("character","character", "numeric", "numeric","numeric", "numeric","numeric", "numeric","numeric"))
unlink(temp)
# creating a new column with date and time and converting it in date and tima variables
household_power_consumption$date_time <- paste(household_power_consumption$Date, household_power_consumption$Time, sep=" ", collapse= NULL)
household_power_consumption$date_time<- strptime(household_power_consumption$date_time, "%d/%m/%Y %H:%M:%S")
# subsetting data by date 
hpc<-subset(household_power_consumption, date_time >="2007-02-01 00:00:00" & date_time<="2007-02-02 23:59:00")
# plot the energy sub meterings against time
plot3 <-plot(hpc$date_time, hpc$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", cex.lab= 0.8)
lines(hpc$date_time,hpc$Sub_metering_2, col="red")
lines(hpc$date_time,hpc$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.8)
# Copy the plot to a PNG file
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()