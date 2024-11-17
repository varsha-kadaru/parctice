# Load necessary libraries
library(caTools)
library(ggplot2)

# Create the data frame
data <- data.frame(
  Years_Exp = c(1.1, 1.3, 1.5, 2.0, 2.2, 2.9, 3.0, 3.2, 3.2, 3.7),
  Salary = c(39343.00, 46205.00, 37731.00, 43525.00,
             39891.00, 56642.00, 60150.00, 54445.00, 64445.00, 57189.00)
)

# Split the data into training and testing sets
set.seed(123)  # Set seed for reproducibility
split = sample.split(data$Salary, SplitRatio = 0.7)
train = subset(data, split == TRUE)
test = subset(data, split == FALSE)

# Fit the linear model
lm.r = lm(formula = Salary ~ Years_Exp, data = train)

# Print the coefficients
print(coef(lm.r))

# Create the ggplot
ggplot() + 
  geom_point(aes(x = train$Years_Exp, y = train$Salary), col = 'red') + 
  geom_line(aes(x = train$Years_Exp, y = predict(lm.r, newdata = train)), col = "blue") + 
  ggtitle("Salary vs Experience") + 
  xlab("Years of Experience") + 
  ylab("Salary")