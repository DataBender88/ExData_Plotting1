# Exploratory Data Analysis
## Peer Graded Assignment: Course Project 1
### Plot 2

# Clear variables
rm(list = ls())

# Create data folder to store files
if(!file.exists("./data")){dir.create("./data")}

# Download raw data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./data/Dataset.zip")

# Unzip file
unzip(zipfile="./data/Dataset.zip", exdir="./data")

# Read to table, only records between 1/2/2007 and 2/2/2007 (d/m/yyyy)
rawData <- file("./data/household_power_consumption.txt")
dataFeb <- read.table(text = grep("^[1,2]/2/2007", readLines(rawData), 
    value = TRUE),col.names = c("Date", "Time", "Global_active_power", 
    "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", 
    "Sub_metering_2", "Sub_metering_3"),sep = ";", header = TRUE)

# Convert date format from d/m/Y to Y/m/d
dateYMD <- as.Date(dataFeb$Date, format = "%d/%m/%Y")

# Concatenate Date and Time
dateTime <- paste(as.Date(dateYMD), dataFeb$Time)
dataFeb$dateTime <- as.POSIXct(dateTime)

# Create line chart: Glboal Active Power (kilowatts)
plot(dataFeb$Global_active_power ~ dataFeb$dateTime, type = "l", 
     ylab = "Glboal Active Power (kilowatts)", xlab = "")

# Create and save .png file to ./data folder
dev.copy(png, file = "./data/plot2.png")
dev.off()