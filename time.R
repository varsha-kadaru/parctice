# Load libraries
library(lubridate)
library(forecast)

# Define data
positiveCases <- c(580, 7813, 28266, 59287, 75700, 87820, 95314, 126214, 
                   218843, 471497, 936851, 1508725, 2072113) 
deaths <- c(17, 270, 565, 1261, 2126, 2800, 3285, 4628, 8951, 
            21283, 47210, 88480, 138475) 

# Set start date and frequency
start_date <- decimal_date(ymd("2020-01-22"))
frequency <- 365.25 / 7

# Creating multivariate time series object
mts <- ts(cbind(positiveCases, deaths), start = start_date, frequency = frequency)

# Create first plot: Multivariate time series
png(file = "multivariateTimeSeries.png")
print(plot(mts, xlab ="Weekly Data", main ="COVID-19 Cases", col.main = "darkgreen"))
dev.off() # Close the plotting device
message("multivariateTimeSeries.png has been created.")

# Create second plot: ARIMA forecast on positive cases
png(file = "timeseries.png")
mts1 <- ts(positiveCases, start = start_date, frequency = frequency)
fit <- auto.arima(mts1) # Fit ARIMA model
forecast_fit <- forecast(fit, h = 5) # Forecast for 5 periods
print(plot(forecast_fit, xlab = "Weekly Data", ylab = "Positive Cases", main = "COVID-19", col.main = "green"))
dev.off() # Close the plotting device
message("timeseries.png has been created.")
