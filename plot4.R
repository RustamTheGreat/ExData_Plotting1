library(dplyr)

dat_0 <- read.csv(unzip('exdata-data-household_power_consumption.zip'), sep = ';', stringsAsFactors = F)

dat <- tbl_df(dat_0)
names(dat) <- tolower(names(dat))
dat <- filter(dat, date %in% c('1/2/2007', '2/2/2007'))
dat$date <- paste(dat$date, dat$time)
dat$date <- as.POSIXct(x = dat$date, format='%d/%m/%Y %H:%M:%S')
dat <- select(dat, -time)

#Plot 4
par(mfrow=c(2,2))
plot(dat$date, dat$global_active_power, ylab = 'Global Active Power (kilowatts)', type = 'l', xlab = '')
plot(dat$date, dat$voltage, xlab = 'datetime', ylab = 'Voltage', type='l')

with(dat, {
    plot(date, sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
    lines(date, sub_metering_2, col='red')
    lines(date, sub_metering_3, col='blue')})
legend('topright', col=c('black', 'red', 'blue'), lty=1, lwd=2, 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), bty='n', cex = 0.5)

plot(dat$date, dat$global_reactive_power, xlab = 'datetime', ylab = 'Global_reactive_power', type = 'l')

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()