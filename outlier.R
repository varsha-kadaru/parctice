# Install and load necessary packages
install.packages("tidyr")  # For drop_na function
library(tidyr)

# Set seed for reproducibility
set.seed(123)

# Create a sample dataset
day <- data.frame(
  temp = rnorm(100, mean = 20, sd = 5),       # Random temperatures
  hum = rnorm(100, mean = 60, sd = 10),        # Random humidity percentages
  windspeed = rnorm(100, mean = 10, sd = 3)    # Random wind speeds
)

# Add some outliers
day$temp[c(10, 20, 30)] <- c(40, 45, 50)      # Adding extreme temperatures
day$hum[c(15, 25, 35)] <- c(10, 5, 0)         # Adding extreme humidity values
day$windspeed[c(40, 50, 60)] <- c(25, 30, 35) # Adding extreme wind speeds

# Add some missing values
day$temp[c(5, 15)] <- NA
day$hum[c(10, 20)] <- NA
day$windspeed[c(30, 40)] <- NA

# View the first few rows of the dataset
print(head(day))

# Check for missing values in the dataset
print(sum(is.na(day)))

# Create boxplots for initial data inspection
boxplot(day[, c("temp", "hum", "windspeed")], main = "Boxplots of Raw Data")

# Handle outliers in specific columns
for(i in c("hum", "windspeed")) {
  data <- unlist(day[i])
  outliers <- boxplot.stats(data)$out
  data[data %in% outliers] <- NA
  day[i] <- data
}

# Check for missing values after handling outliers
print(sum(is.na(day)))

# Drop rows with missing values
day_clean <- drop_na(day)

# Create boxplots for cleaned data
boxplot(day_clean[, c("temp", "hum", "windspeed")], main = "Boxplots of Cleaned Data")