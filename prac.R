install.packages("partykit")

# Load necessary libraries
library(tidyverse)
library(partykit)
library(caTools)

# download & load dataset:
#https://www.kaggle.com/datasets/petalme/seattle-weather-prediction-dataset

weatherdata <- read.csv("/Users/kadar/Downloads/seattle-weather.csv")

# Inspect the dataset
head(weatherdata)
str(weatherdata)



# Convert 'weather' to a factor for classification
weatherdata$weather <- as.factor(weatherdata$weather)

# Split the dataset into training and testing sets (80-20 split)
split=sample.split(weatherdata$weather, SplitRatio=0.8)
train=subset(weatherdata, split==TRUE)
test=subset(weatherdata, split==FALSE)

# Train a decision tree model to predict 'weather'
model <- ctree(weather ~ precipitation + temp_max + temp_min + wind, data = train)

# Plot the decision tree
plot(model)



# Make predictions on the test set
predict_model <- predict(model, test)

# Generate a confusion matrix to evaluate model performance
mat <- table(test$weather, predict_model)
print(mat)

# Calculate the accuracy of the model
accuracy <- sum(diag(mat)) / sum(mat)
print(paste("Accuracy:", accuracy))
