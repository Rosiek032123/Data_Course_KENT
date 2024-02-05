#2.    In it, describe your idea for a data analysis final project

  #Diamond Prices can be impacted by various things, such as inflation, carat, etc. I will be examining a data set with 53,943 diamonds which includes the variables, carat, cut, color, clarity, x, y, z, depth, table, and price. The images below give a visual explanation of each variable. 
  #The purpose of this analysis is to answer the following questions:
     #1. Does the data follow the checks for normality? is the data linear? If so what adjustment needs to be made to proceed?
     # 2.	Are all the variables in this data set important in explaining diamond prices? If, not which variables are important? 
     # 3.	Is there an interaction between diamond clarity and carat weight? 
     # 4.	Does the fitted model explain diamond prices well?
     # 5.	What are the differences in prediction intervals and confidence intervals, for diamonds of different carat weights, with the best cut, least amount of color, and highest amount to clarity?




#3 Also, Describe the sort of data you will use, potential sources, and what the data might look like
    #The data set I used is from kaggle: https://www.kaggle.com/datasets/enashed/diamond-prices This is where the file will be located
read.csv("./Assignments/Assignment_4/Diamonds_Prices2022.csv", header=TRUE)
    #the data  is in a csv format with categorical and numeric variables. The dataset has the following information: carat size, the cut of the diamond, the clor clarity, depth, table, price, x, y, and z





#5. Generate a plot (using ggplot) using either your real or fake data that shows at least one expected result


  diamonds=read.csv("./Assignments/Assignment_4/Diamonds_Prices2022.csv", header=TRUE);diamonds
  diamonds_new <- diamonds                                     # Duplicate data
  diamonds_new[is.na(diamonds_new) | diamonds_new == "NaN"] <- NA
  attach(diamonds_new)
  diamonds_new$cut=factor(diamonds_new$cut, levels=c("Fair","Good", "Very Good", "Premium", "Ideal"))
  diamonds_new$color=factor(diamonds_new$color, level=c("J","I","H","G","F","E","D"))
  diamonds_new$clarity=factor(diamonds_new$clarity, level=c("I1", "SI2","SI1","VS2","VS1", "VVS2", "VVS1", "IF"))
  mlr1=lm((price)~(carat)+(depth)+(table)+x+y+z+as.factor(color)+as.factor(clarity)+as.factor(cut),data=diamonds_new)
  mlr=lm(log(price)~log(carat)+(depth)+(table)+x+y+z+as.factor(color)+as.factor(clarity)+as.factor(cut),data=diamonds_new)

  # Lets look at the original data
  library(ggplot2)
  original.plot <- ggplot(data =diamonds_new, aes(x = carat, y = price, color = clarity) ) +
  geom_point(alpha = .5, size = 1) +
  guides(color = guide_legend(override.aes = list(size = 3) ) )+ggtitle("Carat Vs. Price- colored by clarity level")

  #the original data appears to be curved, I will attempted to fix it by doing log(x) and log(y)

  library(ggplot2)
  log.plot <- ggplot(data = diamonds_new, aes(x =log(carat), y = log(price), color = clarity) ) +
  geom_point(alpha = .5, size = 1) +
  guides(color = guide_legend(override.aes = list(size = 3) ) )+ggtitle("log(Carat) Vs. log(Price)- colored by clarity level")

  grid.arrange(original.plot,log.plot)

