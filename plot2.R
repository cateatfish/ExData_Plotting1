#h <- read.table(
#  "household_power_consumption.txt", header = TRUE,
#  na.strings = "?", sep = ";",
#colClasses = c("character", "character", rep("numeric", 7)))
#h <- h[h$Date %in% c(as.Date("2007-02-01", "%Y-%m-%d"), as.Date("2007-02-02", "%Y-%m-%d")),]

# read all lines into memory
raw_data <- readLines("household_power_consumption.txt")
# keep only two days data per requested
raw_data <- raw_data[grep("^0?[12]/0?2/2007", raw_data)]
h <- read.table(
  text = raw_data, header = FALSE,
  na.strings = "?", sep = ";",
  colClasses = c("character", "character", rep("numeric", 7)),
  col.names = c(
    "Date","Time", "Global_active_power", 
    "Global_reactive_power", "Voltage", "Global_intensity",
    "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
h$Time <- strptime(paste(h$Date, h$Time), "%d/%m/%Y %H:%M:%S")
h$Date <- as.Date(h$Date, "%d/%m/%Y")

png("plot2.png", width = 480, height = 480, units = "px")
plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

dev.off()

