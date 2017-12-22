##  OPTION1 (NOT USED) Reading the entire table and selecting the two days of interest
        ## Data <- read.table("household_power_consumption.txt", header=TRUE, sep =";")
        ## Data <- subset(Data, Date=="1/2/2007" | Date=="2/2/2007")


# OPTION2: Alternative way of reading only relevant dates
library(sqldf)
Data2 <- read.csv.sql("household_power_consumption.txt", header=TRUE, sep=";", 
                      sql="select * from file where Date ='1/2/2007' OR Date ='2/2/2007' ")

# creating a new variable with date and time
datetime <- paste(Data2$Date, Data2$Time, sep=" ")

# converting character vector into time format
Data2$datetime <- strptime(datetime, "%e/%m/%Y %H:%M:%S")

# Date in English
Sys.setlocale("LC_TIME", "English")

# preparing layout for 4 plots
par(mfrow=c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

# First plot
        with(Data2, plot(datetime, Global_active_power, type="l", xlab=" ", ylab="Global Active Power (Kilowatts)"))
# Second plot
        with(Data2, plot(datetime, Voltage, type="l", xlab="datetime", ylab="Voltage"))
# Third plot
        with(Data2, plot(datetime, Sub_metering_1, type="l", xlab=" ", ylab="Energy sub metering"))
        with(Data2, lines(datetime, Sub_metering_2, col="red"))
        with(Data2, lines(datetime, Sub_metering_3, col="blue"))
        legend("topright", col=c("black", "red", "blue"), 
               legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.8, bty="n")
# Fourth plot
        with(Data2, plot(datetime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_Power"))
        
## generating a PNG plot called "Plot4.png"
dev.copy(png, file = "plot4.png")
dev.off() 