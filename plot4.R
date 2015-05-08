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
# set of plots
par(mfrow=c(2,2), mar=c(4,4,4,1.5))
plota <-plot(hpc$date_time, hpc$Global_active_power, xlab="", ylab="Global Active Power", type="l", cex.lab= 0.8, cex.axis=0.8)
plotc<- plot(hpc$date_time, hpc$Voltage, xlab="datetime", ylab="Voltage", type="l", cex.lab= 0.8,yaxt="n" )
axis(2, at=c(234,236,238,240,242,244,246), labels=c("234"," ","238"," ","242"," ","246"), cex.axis=0.8)
plotb <-plot(hpc$date_time, hpc$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", cex.lab= 0.8, cex.axis=0.8)
lines(hpc$date_time,hpc$Sub_metering_2, col="red")
lines(hpc$date_time,hpc$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty=1,cex=0.5, bty="n")
plotd <-plot(hpc$date_time, hpc$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l", yaxt="n", cex.lab= 0.8)
axis(2, at=c(0.0,0.1,0.2,0.3,0.4,0.5), labels=c("0.0","0.1","0.2","0.3","0.4","0.5"),cex.axis=0.8)
# Copy the plot to a PNG file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

