library(tidyverse) 
x <- sample(1:21, 20, replace = TRUE)  
y <- sample(1:10, 20, replace = TRUE) 
for(i in 1:20) 
{ 
  a <- x[i] 
  b <- y[i] 
  mtcars[a, b] = NA 
} 
which(is.na(mtcars)) 
sum(is.na(mtcars)) 
na.exclude(mtcars) 
view(mtcars) 
dispna <- apply(mtcars["disp"], 2, mean, na.rm=TRUE) 
view(dispna) 
newcars <- mtcars %>% 
  mutate(disp = ifelse(is.na(disp), dispna, disp), ) 
View(newcars) 
