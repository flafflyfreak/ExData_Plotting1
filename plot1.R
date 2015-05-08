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
# plot the global active power
plot1 <-hist(hpc$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red", cex.lab= 0.8 )
# Copy the plot to a PNG file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()