# read data file
# if file stored locally
# x <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
# if file stored remotely
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
x <- read.table(unz(temp, "household_power_consumption.txt", header=TRUE, sep=";"))
unlink(temp)

# make sure date column is in the proper format
x$Date = as.Date(x$Date, format="%d/%m/%Y")
# extract relevant data
y <- x[x$Date <= as.Date("02/02/2007", format="%d/%m/%Y"), ]
y <- y[y$Date >= as.Date("01/02/2007", format="%d/%m/%Y"), ]

#format data
y$Global_active_power <- as.numeric(as.character(y$Global_active_power))
y$dtm <- strptime(paste(y$Date, y$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")
y$Sub_metering_1 <- as.numeric(as.character(y$Sub_metering_1))
y$Sub_metering_2 <- as.numeric(as.character(y$Sub_metering_2))
y$Sub_metering_3 <- as.numeric(as.character(y$Sub_metering_3))

#plot graph 3
png("plot3.png")

with(y, plot(y$dtm, y$Sub_metering_1, pch=".", xlab="", ylab="Energy sub metering"), type=n)
with(y, lines(y$dtm, y$Sub_metering_1, col=1))
with(y, lines(y$dtm, y$Sub_metering_2, col=2))
with(y, lines(y$dtm, y$Sub_metering_3, col=4))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
