library(dplyr)

dat_0 <- read.csv(unzip('exdata-data-household_power_consumption.zip'), sep = ';', stringsAsFactors = F)

dat <- tbl_df(dat_0)
names(dat) <- tolower(names(dat))
dat <- filter(dat, date %in% c('1/2/2007', '2/2/2007'))
dat$date <- paste(dat$date, dat$time)
dat$date <- as.POSIXct(x = dat$date, format='%d/%m/%Y %H:%M:%S')
dat <- select(dat, -time)

#Plot 2
plot(dat$date, dat$global_active_power, ylab = 'Global Active Power (kilowatts)', type = 'l', xlab = '')
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()