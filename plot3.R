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

# creating the line plot
with(Data2, plot(datetime, Sub_metering_1, type="l", xlab=" ", ylab="Energy sub metering"))
with(Data2, lines(datetime, Sub_metering_2, col="red"))
with(Data2, lines(datetime, Sub_metering_3, col="blue"))

# The legend
legend("topright", fill, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=1)

## generating a PNG plot called "Plot3.png"
dev.copy(png, file = "plot3.png")
dev.off() 