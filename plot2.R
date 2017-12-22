##  OPTION1 (NOT USED) Reading the entire table and selecting the two days of interest
        ## Data <- read.table("household_power_consumption.txt", header=TRUE, sep =";")
        ## Data <- subset(Data, Date=="1/2/2007" | Date=="2/2/2007")


# OPTION2: Alternative way of reading only relevant dates
library(sqldf)
Data2 <- read.csv.sql("household_power_consumption.txt", header=TRUE, sep=";", 
                      sql="select * from file where Date ='1/2/2007' OR Date ='2/2/2007' ")

# creating a new variable with date and time
datetime <- paste(Data2$Date, Data2$Time, sep=" ")

# converting vector datetime into time format and put it into the data frame
Data2$datetime <- strptime(datetime, "%e/%m/%Y %H:%M:%S")

# Date in English
Sys.setlocale("LC_TIME", "English")

# creating the line plot
with(Data2, plot(datetime, Global_active_power, type="l", xlab=" ", ylab="Global Active Power (Kilowatts)"))

## generating a PNG plot called "Plot2.png"
dev.copy(png, file = "plot2.png")
dev.off() 
