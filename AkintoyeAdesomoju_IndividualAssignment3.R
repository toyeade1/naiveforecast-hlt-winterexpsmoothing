# load the dataset into the Rscript.
souvSales <- read.csv('SouvenirSales.csv')

#load required libraries.
install.packages('forecast')
library(forecast)

#create time series and plot the results, also remove scientific notation.
monthlySales.ts <- ts(souvSales$Sales, start = c(1995, 1), end = c(2001, 12), frequency = 12)
plot(monthlySales.ts, xlab = "Year", ylab = "Monthly Sales", ylim = c(1500,110000))
options(scipen = 999, digits = 5)

#split data into training and validation sets.

valid <- 12
train <- length(monthlySales.ts) - valid
train.ts <- window(monthlySales.ts, start = c(1995, 1), end = c(1995, train))
valid.ts <- window(monthlySales.ts, start = c(1995, train + 1), end = c(1995, valid + train))

# naive forecast
naive.nf <- snaive(train.ts, h = valid)
par(mfrow = c(1, 1))

plot(train.ts, ylim = c(1500, 110000),  ylab = "Monthly Sales", 
     xlab = "Year", bty = "l", 
     xaxt = "n", xlim = c(1995,2002.25), main = "")
axis(1, at = seq(1995, 2002, 1), labels = format(seq(1995, 2002, 1)))
lines(naive.nf$mean, lwd = 2, col = "green", lty = 1)
lines(valid.ts, col = "blue", lty = 3)

accuracy(naive.nf, valid.ts)

#regression model
train.lm <- tslm(train.ts ~ trend + season)
train.pred <- forecast(train.lm, h = valid, level = 0)
accuracy(train.pred, valid.ts )
summary(train.pred)

#Holt-Winter exponential smoothing
hWinter <- ets(train.ts, model = "MAA")

# Make predictions for with the model
hWinter.pred <- forecast(hWinter,h = valid, level = 0)

plot(hWinter.pred, ylim = c(1500, 110000),  ylab = "Monthly Sales", xlab = "Year", 
     bty = "l", xaxt = "n", xlim = c(1995,2002.25), main = "", flty = 2)
axis(1, at = seq(1995, 2002, 1), labels = format(seq(1995, 2002, 1)))
lines(hWinter.pred$fitted, lwd = 2, col = "blue")
lines(valid.ts)

accuracy(hWinter.pred, valid.ts)
accuracy(train.pred, valid.ts)

