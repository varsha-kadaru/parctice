# Install and load the leaps package (only needs to be installed once)
if (!require(leaps)) install.packages("leaps")
library(leaps)

# Viewing the Titanic dataset (note that Titanic is a built-in table object, not a data frame)
View(as.data.frame(Titanic))

# Converting Titanic to a data frame and removing NAs if any
Titanic <- as.data.frame(Titanic)
sum(is.na(Titanic))
Titanic <- na.omit(Titanic)
dim(Titanic)

# Performing subset selection
fwd <- regsubsets(Freq ~ ., data = Titanic, nvmax = 19, method = "forward")
bwd <- regsubsets(Freq ~ ., data = Titanic, nvmax = 19, method = "backward")
full <- regsubsets(Freq ~ ., data = Titanic, nvmax = 19)

# Summarizing results
summary(fwd)
summary(bwd)
summary(full)

# Extracting coefficients for the model with 3 predictors
coef(fwd, 3)
coef(bwd, 3)
coef(full, 3)
