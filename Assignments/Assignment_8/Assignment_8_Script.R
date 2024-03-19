library(tidyverse)
library(janitor)
library(readxl)
library(ggplot2)
library(performance)
library(modelr)

#+ Make a new Rproj and Rscript in your personal Assignment_8 directory and work from there.
#+ Write a script that:
#1.  loads the "/Data/mushroom_growth.csv" data set
df <- read_csv('./mushroom_growth.csv')
#2.  creates several plots exploring relationships between the response and predictors

df=janitor::clean_names(df)
names(df)
##plot 0
df %>% 
  ggplot(aes(x=species, y=growth_rate))+geom_boxplot()


##plot 1
df %>% 
  ggplot(aes(x=light, y=growth_rate))+geom_boxplot()


##plot 2
df %>% 
  ggplot(aes(x=nitrogen, y=growth_rate, col=species))+geom_smooth()

##plot 3
df %>% 
  ggplot(aes(x=humidity, y=growth_rate))+geom_boxplot()

##plot 4
df %>% 
  ggplot(aes(x=temperature, y=growth_rate))+geom_point()
##plot 5
df %>% 
  ggplot(aes(x=nitrogen, y=growth_rate, col=humidity))+geom_point()+
  geom_smooth()+
  facet_wrap(~temperature)


#3.  defines at least 4 models that explain the **dependent variable "GrowthRate"**
#4.  calculates the mean sq. error of each model
model1 <- df %>% 
  glm(formula=growth_rate~temperature*light+species+humidity, family='gaussian')

model1_rmse <- performance(model1)$RMSE


model2 <- df %>% 
  glm(formula=growth_rate~temperature*light*species*humidity*nitrogen, family='gaussian')

model2_rmse <- performance(model2)$RMSE

model3 <- df %>% 
  glm(formula=growth_rate~temperature+light+species+humidity+nitrogen, family='gaussian')

model3_rmse <- performance(model3)$RMSE

model4 <- df %>% 
  glm(formula=growth_rate~temperature*light+species*humidity+nitrogen, family='gaussian')

model4_rmse <- performance(model4)$RMSE


rmse_table <- data.frame(
  Model = c("Model 1", "Model 2", "Model 3", "Model 4"),
  RMSE = c(model1_rmse, model2_rmse, model3_rmse, model4_rmse)
)

print(rmse_table)




#5.  selects the best model you tried
compare_performance(model1,model2,model3,model4) %>% plot
#based on the plot it appears that the second model is the best. But the model might be overfit. Model two has the lowest RMSE


#6.  adds predictions based on new hypothetical values for the independent variables used in your model

df$pred=df$growth_rate
df$model="Actual"
newdf <- data.frame(
  nitrogen = c(20, 45, 30, 35, 15),
  temperature = c(25, 20, 25, 25, 25),
  light = c(0, 20, 10, 0, 10),
  species = c("P.cornucopiae", "P.cornucopiae", "P.cornucopiae", "P.ostreotus", "P.ostreotus"),
  humidity = c("High", "Low", "High", "Low", "High")
)
library(modelr)
newdf_pred <- gather_predictions(newdf,model1,model2,model3,model4)


df$PredictionType <- "Real"
newdf_pred$PredictionType <- "Hypothetical"
fullpreds <- full_join(df,newdf_pred)



#7.  plots these predictions alongside the real data


ggplot(fullpreds,aes(x=fullpreds$light,y=fullpreds$pred,color=fullpreds$PredictionType)) +
  geom_point() +
  geom_jitter(width = 10, height = 0.5)+
  scale_x_continuous(breaks=c(0,10,20))+
  facet_wrap(~model)



#+ Upload responses to the following as a numbered plaintext document to Canvas:
#1.  Are any of your predicted response values from your best model scientifically meaningless? Explain.


#My model 3 was the best fit. We fitted a linear model (estimated using ML) to predict growth_rate with temperature, light, species, humidity and nitrogen (formula: growth_rate ~ temperature + light + species + humidity +nitrogen). The model's explanatory power is substantial (R2 =0.47). The model's intercept, corresponding to temperature = 0,light = 0, species = P.cornucopiae, humidity = High and nitrogen =0, is at 216.05 (95% CI [125.06, 307.04], t(210) = 4.65, p < .001).
#Within this model there were several growth rates that were negative. A negative growth rate isn't possible, so those points are scientifically meaningless.

#2.  In your plots, did you find any non-linear relationships?  Do a bit of research online and give a link to at least one resource explaining how to deal with modeling non-linear relationships in R.
##Yes,there were several variables that did not have a linear relationship. This site (https://bookdown.org/anshul302/HE902-MGHIHP-Spring2020/LogitTrans.html) discusses that you can handle non-linear data using, quadratic regression modeling. This would be where you make the formula into a quadratic formula so it better fits the data. There are also log transformations you can do to the data. 



#3.  Write the code you would use to model the data found in "/Data/non_linear_relationship.csv" with a linear model (there are a few ways of doing this)
#using excel to find the quadratic function for the model I was able to find a line that accurately fit the curve
df.1 <- read_csv("/Users/rosie/Desktop/Data_Course_KENT/Assignments/Assignment_8/non_linear_relationship.csv")
quadratic <- function(x) {
  return(1.1206 * x^3 - 2.5216798 * x^2 + 4.00871039 * x + 0.41537149)
}

ggplot(df.1, aes(x = predictor, y = response)) +
  geom_point() +  # Scatter plot of data points
  stat_function(fun = quadratic, color = "red") +  # Quadratic regression line
  labs(x = "Predictor", y = "Response", title = "Quadratic Regression") +
  theme_minimal()




