setwd("ExData_Plotting1")

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

#Global Active Power(Kilowatts) verses Time

subset$Time1 <- as.POSIXct(paste(subset$Date, subset$Time), format="%Y-%m-%d %H:%M:%S")

#png(file="figure/plot2.png", width=480, height=480)
par(mfrow=c(1,1), bg=NA)
plot(subset$Time1, subset$Global_active_power, ylab="Global Active Power (kilowatts)",xlab="", type="l")
#dev.off()