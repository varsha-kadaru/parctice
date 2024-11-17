library(tidyverse)
library(ROCR)
library(caTools)
library(ggplot2)


split <- sample.split(mtcars$vs, SplitRatio = 0.8) 
train <- subset(mtcars, split == TRUE)  
test <- subset(mtcars, split == FALSE)  
logistic_model <- glm(vs ~ wt + disp, data = train, family = binomial)
summary(logistic_model)

predict_reg <- predict(logistic_model, test)

predict_reg <- ifelse(predict_reg > 0.5, 1, 0)

missing_classerr <- mean(predict_reg != test$vs)
print(paste("Classification Error = ", missing_classerr))
print(paste("Accuracy = ", (1 - missing_classerr)))

ggplot(train, aes(x = wt + disp, y = vs)) + 
  geom_point(alpha = .5) +
  stat_smooth(method = "glm", se = FALSE, method.args = list(family = binomial), col = "red") +
  labs(title = "Logistic Regression Curve", x = "Weight + Displacement", y = "VS")
