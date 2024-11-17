View(airquality) 
barplot(airquality$Ozone,  
        main = 'Ozone Concenteration in air',  
        xlab = 'ozone levels', horiz = TRUE)  
hist(airquality$Temp, main ="La Guardia Airport's\  
Maximum Temperature(Daily)",  
     xlab ="Temperature(Fahrenheit)")  
boxplot(airquality[, 0:4],   
        main ='Box Plots for Air Quality Parameters')  
plot(airquality$Ozone, airquality$Month,  
     main ="Scatterplot Example",  
     xlab ="Ozone Concentration in parts per billion",  
     ylab =" Month of observation ", pch = 19)  

data <- matrix(rnorm(50, 0, 5), nrow = 5, ncol = 5)  

# Column names  
colnames(data) <- paste0("col", 1:5)  
rownames(data) <- paste0("row", 1:5)  

# Draw a heatmap  
heatmap(data) 
