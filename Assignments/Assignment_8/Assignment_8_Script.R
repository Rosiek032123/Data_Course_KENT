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
df_new <- df %>% 
  mutate(model1_pred = add_predictions(df, model1)$pred,
                 model2_pred = add_predictions(df, model2)$pred,
                 model3_pred = add_predictions(df, model3)$pred,
                 model4_pred = add_predictions(df, model4)$pred)




newdf <- data.frame(
  nitrogen = c(20, 45, 30, 35, 15),
  temperature = c(25, 20, 25, 25, 25),
  light = c(0, 20, 10, 0, 10),
  species = c("P.cornucopiae", "P.cornucopiae", "P.cornucopiae", "P.ostreotus", "P.ostreotus"),
  humidity = c("High", "Low", "High", "Low", "High")
)


#7.  plots these predictions alongside the real data

df_new %>%
  pivot_longer(cols = starts_with("model"), names_to = "model") %>%
  ggplot(aes(x = nitrogen, y = growth_rate)) +  
  geom_point(aes(color = "Actual Growth Rate"), data = df_new, show.legend = TRUE) +
  geom_point(aes(y = value, color = model)) +
  facet_wrap(~ model) +
  labs(
    x = "Nitrogen",
    y = "Predicted Growth Rate",
    color = "Model",
    fill = "Actual Growth Rate (black)"
  )
 

#6&7 another interpretation.

pred <- predict(model3, newdata = newdf)

hyp_preds <- data.frame(nitrogen = newdf$nitrogen, pred = pred)

hyp_preds$PredictionType <- "Hypothetical"

fullpreds <- bind_rows(df_new, hyp_preds)

# Plotting predictions on our original graph
ggplot(fullpreds, aes(x = nitrogen, y = pred, color = PredictionType)) +
  geom_point(data = fullpreds %>% filter(PredictionType == "Real"), aes(y = growth_rate), color = "Black") +
  geom_point(data = fullpreds %>% filter(PredictionType == "Hypothetical"), color = "Red") +
  labs(
    x = "Nitrogen",
    y = "Predicted Growth Rate",
    color = "Prediction Type"
  ) +
  theme_minimal()



#+ Upload responses to the following as a numbered plaintext document to Canvas:
#1.  Are any of your predicted response values from your best model scientifically meaningless? Explain.


#My model 3 was the best fit. We fitted a linear model (estimated using ML) to predict growth_rate with temperature, light, species, humidity and nitrogen (formula: growth_rate ~ temperature + light + species + humidity +nitrogen). The model's explanatory power is substantial (R2 =0.47). The model's intercept, corresponding to temperature = 0,light = 0, species = P.cornucopiae, humidity = High and nitrogen =0, is at 216.05 (95% CI [125.06, 307.04], t(210) = 4.65, p < .001).
#Within this model:
  
  #- The effect of temperature is statistically non-significant because the p-value is greater than .05 and negative (beta = -3.84, 95% CI [-7.72, 0.04], t(210) = -1.94, p =0.053; Std. beta = -0.10, 95% CI [-0.20, 1.05e-03])
#- The effect of light is statistically significant and positive(beta = 5.51, 95% CI [4.32, 6.70], t(210) = 9.09, p < .001; Std. beta = 0.46, 95% CI [0.36, 0.55])
#- The effect of species [P.ostreotus] is statistically significant and negative (beta = -48.38, 95% CI [-67.79, -28.98], t(210) =-4.89, p < .001; Std. beta = -0.49, 95% CI [-0.69, -0.29])
#- The effect of humidity [Low] is statistically significant and negative (beta = -86.58, 95% CI [-105.98, -67.17], t(210) = -8.74,p < .001; Std. beta = -0.88, 95% CI [-1.07, -0.68])
#- The effect of nitrogen is statistically non-significant and negative (beta = -0.16, 95% CI [-0.81, 0.49], t(210) = -0.48, p =0.634; Std. beta = -0.02, 95% CI [-0.12, 0.07])


#2.  In your plots, did you find any non-linear relationships?  Do a bit of research online and give a link to at least one resource explaining how to deal with modeling non-linear relationships in R.
##Yes,there were several variables that did not have a linear relationship. This site (https://bookdown.org/anshul302/HE902-MGHIHP-Spring2020/LogitTrans.html) discusses that you can handle non-linear data using, quadratic regression modeling. This would be where you make the formula into a quadratic formula so it better fits the data. There are also log transformations you can do to the data. 



#3.  Write the code you would use to model the data found in "/Data/non_linear_relationship.csv" with a linear model (there are a few ways of doing this)
#using excel to find the quadratic function for the model I was able to find a line that accurately fit the curve
quadratic <- function(x) {
  return(1.1206 * x^3 - 2.5216798 * x^2 + 4.00871039 * x + 0.41537149)
}

ggplot(df.1, aes(x = predictor, y = response)) +
  geom_point() +  # Scatter plot of data points
  stat_function(fun = quadratic, color = "red") +  # Quadratic regression line
  labs(x = "Predictor", y = "Response", title = "Quadratic Regression") +
  theme_minimal()




