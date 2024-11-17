library(partykit)
library(caTools)

wd<-data.frame(
  temp=rnorm(200,mean=20,sd=5),
  hum=rnorm(200,mean=75,sd=15),
  ws=rnorm(200,mean=50,sd=10),
  rt=sample(c("Yes","No"),200,replace=TRUE)
)

wd$tom<-with(wd,ifelse(hum>70 & temp<22,"Yes","No"))
wd$tom<-as.factor(wd$tom)
wd$rt<-as.factor(wd$rt)

sample<-sample.split(wd$temp,SplitRatio=0.8)
train<-subset(wd,sample==TRUE)
test<-subset(wd,sample==FALSE)

train$tom<-as.factor(train$tom)
test$tom<-as.factor(test$tom)

control<-ctree_control(mincriterion = 0.95,minsplit = 10)
model<-ctree(tom~rt+ws+hum+temp,data=train,control=control)
plot(model,main="Dec tree")

predict_model <- predict(model, newdata = test)

# Create a confusion matrix
mat <- table(test$tom, predict_model)
print("Confusion Matrix:")
print(mat)

# Calculate accuracy
accuracy <- sum(diag(mat)) / sum(mat)
print(paste("Accuracy:", round(accuracy * 100, 2), "%"))
