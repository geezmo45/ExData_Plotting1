# read data file
# if file stored locally
# x <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
# if file stored remotely
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
x <- read.table(unz(temp, "household_power_consumption.txt"))
unlink(temp)

# make sure date column is in the proper format
x$Date = as.Date(x$Date, format="%d/%m/%Y")
# extract relevant data
y <- x[x$Date <= as.Date("02/02/2007", format="%d/%m/%Y"), ]
y <- y[y$Date >= as.Date("01/02/2007", format="%d/%m/%Y"), ]

#format data
y$Global_active_power <- as.numeric(y$Global_active_power)


#plot histogram 1
png("plot1.png")
hist(y$Global_active_power, col=2, main="Global Active Power", xlab="Global Active Power (kilowatt)")
dev.off()
