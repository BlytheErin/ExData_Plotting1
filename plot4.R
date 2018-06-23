setwd("ExData_Plotting1")
getwd()
dataset_url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(dataset_url, "PowerConsumption.zip")
unzip("PowerConsumption.zip", exdir="PowerConsumption")

hpc<- read.table("PowerConsumption/household_power_consumption.txt", sep=";", header=T, dec=".")

#Converting class of Date

hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")

#Subsetting based on Date
subset <- hpc[hpc$Date >= as.Date("2007-02-01") & hpc$Date<as.Date("2007-02-03"), ]

# Change numbers that are read as factor: as.numeric(levels(f))[f]
for (i in 3:8) {subset[, i] <- as.numeric(levels(subset[,i])[subset[, i]])}

#Multiplot

subset$Time1 <- as.POSIXct(paste(subset$Date, subset$Time), format="%Y-%m-%d %H:%M:%S")
getwd()
png(file="ExData_Plotting1/figure/plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0), bg=NA)
 plot(subset$Time1, subset$Global_active_power, ylab="Global Active Power",xlab="", type="l")
        plot(subset$Time1, subset$Voltage, ylab="Voltage",xlab="datetime", type="l")
        plot(subset$Time1, subset$Sub_metering_1, ylab="Energy sub metering",xlab="", type="l")
        lines(subset$Time1, subset$Sub_metering_2,  col="red")
        lines(subset$Time1, subset$Sub_metering_3, col="blue")
        
        legend("topright", col=c("black", "red", "Blue"), lwd=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
        plot(subset$Time1, subset$Global_reactive_power, ylab="Global_reactive_power",xlab="datetime", type="l")
dev.off()
