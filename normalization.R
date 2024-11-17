arr <- c(9.5, 6.2, 8.9, 15.2, 20.0, 10.1, 5.4, 3.2, 1.0, 22.5, 10.0, 16.0) 
#min-max 
minarr <- min(arr) 
maxarr <- max(arr) 
arr2 <- arr 
for (i in 1:12){ 
  arr2[i] = round((arr[i]-minarr)/(maxarr-minarr)) 
} 
print(arr2) 

#z-score 
meanarr <- mean(arr) 
sdarr <- sd(arr) 
for (i in 1:12){ 
  arr2[i] = round((arr[i]-meanarr)/sdarr, 2) 
} 
print(arr2) 