# Load required libraries
library(partykit)
library(caTools)

# Set seed for reproducibility
set.seed(123)

# Create a sample weather dataset with some correlation
weatherdata <- data.frame(
  Temperature = rnorm(200, mean = 20, sd = 5),       # Random temperatures around 20 degrees
  Humidity = rnorm(200, mean = 75, sd = 10),         # Random humidity percentages around 75%
  WindSpeed = rnorm(200, mean = 10, sd = 3),         # Random wind speeds around 10 km/h
  RainToday = sample(c("Yes", "No"), 200, replace = TRUE)  # Random yes/no for rain today
)

# Create RainTomorrow with some dependency on Humidity and Temperature
weatherdata$RainTomorrow <- with(weatherdata, ifelse(Humidity > 70 & Temperature < 22, "Yes", "No"))
weatherdata$RainTomorrow <- as.factor(weatherdata$RainTomorrow)

# Convert RainToday to a factor as well
weatherdata$RainToday <- as.factor(weatherdata$RainToday)

# Split the data into training and testing sets
sample <- sample.split(weatherdata$Temperature,SplitRatio=0.8)
train <- subset(weatherdata,sample==TRUE)
test <- subset(weatherdata,sample==FALSE)

# Ensure 'RainTomorrow' is a factor (target variable)
train$RainTomorrow <- as.factor(train$RainTomorrow)
test$RainTomorrow <- as.factor(test$RainTomorrow)

# Build the decision tree model
control <- ctree_control(mincriterion = 0.95, minsplit = 10) # Adjust control for better splitting
model <- ctree(RainTomorrow ~ Temperature + Humidity + WindSpeed + RainToday, data = train, control = control)

# Plot the decision tree
plot(model, main = "Decision Tree for Predicting RainTomorrow")

# Make predictions on the test set
predict_model <- predict(model, newdata = test)

# Create a confusion matrix
mat <- table(test$RainTomorrow, predict_model)
print("Confusion Matrix:")
print(mat)

# Calculate accuracy
accuracy <- sum(diag(mat)) / sum(mat)
print(paste("Accuracy:", round(accuracy * 100, 2), "%"))
