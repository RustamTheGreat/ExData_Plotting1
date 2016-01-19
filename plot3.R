library(dplyr)

dat_0 <- read.csv(unzip('exdata-data-household_power_consumption.zip'), sep = ';', stringsAsFactors = F)

dat <- tbl_df(dat_0)
names(dat) <- tolower(names(dat))
dat <- filter(dat, date %in% c('1/2/2007', '2/2/2007'))
dat$date <- paste(dat$date, dat$time)
dat$date <- as.POSIXct(x = dat$date, format='%d/%m/%Y %H:%M:%S')
dat <- select(dat, -time)

#Plot 3
dat$sub_metering_1 <- as.numeric(dat$sub_metering_1)
dat$sub_metering_2 <- as.numeric(dat$sub_metering_2)
dat$sub_metering_3 <- as.numeric(dat$sub_metering_3)


with(dat, {
    plot(date, sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
    lines(date, sub_metering_2, col='red', type='l')
    lines(date, sub_metering_3, col='blue', type='l')})
legend('topright', col=c('black', 'red', 'blue'), lty=1, lwd=2, 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()