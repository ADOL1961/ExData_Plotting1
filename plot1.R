##  OPTION1 (NOT USED) Reading the entire table and selecting the two days of interest
        ## Data <- read.table("household_power_consumption.txt", header=TRUE, sep =";")
        ## Data <- subset(Data, Date=="1/2/2007" | Date=="2/2/2007")


# OPTION2: Alternative way of reading only relevant dates
library(sqldf)
Data2 <- read.csv.sql("household_power_consumption.txt", header=TRUE, sep=";", 
                      sql="select * from file where Date ='1/2/2007' OR Date ='2/2/2007' ")

## Creating the histogram 
hist(Data2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (Kilowatts)")

## generating a PNG plot called "Plot1.png"
dev.copy(png, file = "plot1.png") ## Copy plot to a PNG file
dev.off() 

