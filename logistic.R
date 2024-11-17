library(tidyverse)
library(ROCR)
library(caTools)
library(ggplot2)

# View the mtcars dataset
view(mtcars)

# Split the data into training and testing sets
split <- sample.split(mtcars$vs, SplitRatio = 0.8)  # Ensure using 'vs' for splitting
train <- subset(mtcars, split == TRUE)  # Use TRUE without quotes
test <- subset(mtcars, split == FALSE)  # Use FALSE without quotes

# Build the logistic regression model
logistic_model <- glm(vs ~ wt + disp, data = train, family = binomial)
summary(logistic_model)

# Make predictions
predict_reg <- predict(logistic_model, test, type = "response")

# Convert probabilities to binary outcomes
predict_reg <- ifelse(predict_reg > 0.5, 1, 0)

# Create a confusion matrix
confusion_matrix <- table(test$vs, predict_reg)
print(confusion_matrix)

# Calculate and print classification error and accuracy
missing_classerr <- mean(predict_reg != test$vs)
print(paste("Classification Error = ", missing_classerr))
print(paste("Accuracy = ", (1 - missing_classerr)))

# Plot logistic regression curve
ggplot(train, aes(x = wt + disp, y = vs)) + 
  geom_point(alpha = .5) +
  stat_smooth(method = "glm", se = FALSE, method.args = list(family = binomial), col = "red") +
  labs(title = "Logistic Regression Curve", x = "Weight + Displacement", y = "VS")

# ROC Curve
ROCPred = prediction(predict_reg, test$vs)
ROCPer = performance(ROCPred, measure = "tpr", x.measure = "fpr")
auc <- performance(ROCPred, measure = "auc")
auc_value <- auc@y.values[[1]]
auc_value <- round(auc_value, 4)

# Plot ROC Curve
plot(ROCPer, colorize = TRUE, print.cutoffs.at = seq(0.1, by = 0.1), main = "ROC Curve")
abline(a = 0, b = 1)
legend(0.6, 0.4, paste("AUC =", auc_value), title = "AUC", cex = 1)