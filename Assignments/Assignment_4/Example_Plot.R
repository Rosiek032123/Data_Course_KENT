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