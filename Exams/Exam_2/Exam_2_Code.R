# 1. Read in the unicef data (10 pts) 
library(tidyverse)
library(janitor)
library(readxl)
library(ggplot2)
library(easystats)
dat <- read_csv("./unicef-u5mr.csv") %>%janitor::clean_names()


#2. Get it into tidy format (10 pts) 
names(dat) <- 
  names(dat) %>% str_remove("u5mr_")

dat_clean <- 
  dat %>% pivot_longer(cols=-c(country_name,continent,region),names_to = "year",values_to = "rate") %>% 
  mutate(rate =as.numeric(rate),
         year = as.numeric(year),
         country = factor(country_name),
         continent = factor(continent), 
         region = factor(region)) %>% 
  select(continent, region, country, year, rate) %>% 
  filter(!is.na(rate))



#3. Plot each country’s U5MR over time (20 points)
plot <- 
  dat_clean %>% 
  ggplot(aes(x=year,y=rate, color=country, group=country))+
  geom_line(show.legend=FALSE)+
  facet_wrap(~continent)+
  theme(axis.text.x=element_text(angle=90, hjust=1,vjust=1,size=4))+
  labs(title = 'Under Five Mortality Rate by Country',
       subtitle = "Faceted by Continent",
       y = 'U5MR',
       x = 'Year') +
  theme_bw() + scale_color_manual(values =  rep('black', nlevels(dat_clean$country)))+theme(axis.text.x=element_text(angle=90, hjust=1,vjust=1,size=4))




# 4. Save this plot as LASTNAME_Plot_1.png (5 pts)
ggsave("KENT_Plot_1.png",plot=plot)




#5.Create another plot that shows the mean U5MR for all the countries within a given continent at each year (20 pts)

plot.2 <- 
  dat_clean %>% group_by(year,continent) %>% summarise(mean_rate = mean(rate, na.rm = TRUE)) %>%
  ggplot(aes(x = year, y = mean_rate, color =continent)) +
  geom_line()+ labs(title = 'Mean Under 5 Mortality Rate by Continent',
                    y = 'Mean U5MR', 
                    x = 'Year', color = 'Continent')




# 6. Save that plot as LASTNAME_Plot_2.png (5 pts) 
ggsave("Kent_Plot_2.png",plot=plot.2)




#7. Create three models of U5MR (20 pts)
# - mod1 should account for only Year
mod1 <- 
glm(data=dat_clean,formula=rate~year)
summary(mod1)


# - mod2 should account for Year and Continent
mod2 <- 
  glm(data=dat_clean, formula = rate~year+continent)
summary(mod2)




# - mod3 should account for Year, Continent, and their interaction term
mod3 <- 
  glm(data=dat_clean,formula=rate~year*continent)
summary(mod3)


# 8. Compare the three models with respect to their performance
compare_models(mod1,mod2,mod3)
compare_performance(mod1,mod2,mod3)
#model 3 has the largest R^2 values meaning this model explains 64% of variation in the data. It also has the lowest Root Mean Square Error, meaning the model fit s the data well and has more percise predictions than the other models. 


# 9. Plot the 3 models’ predictions like so: (10 pts)

dat_modeled <- 
  dat_clean %>% 
  mutate(modfit1 = predict(mod1), 
         modfit2 = predict(mod2), 
         modfit3 = predict(mod3), 
         actual = rate) %>% 
  select(continent, region, country, year, actual, modfit1, modfit2, modfit3) %>% 
  pivot_longer(cols = c(modfit1, modfit2, modfit3), names_to = "model", values_to = "Predicted_U5MR") %>% 
  mutate(model = as.factor(model))

plot.3 <- 
  dat_modeled %>% 
  ggplot(aes(color = continent)) +
  facet_wrap(~model) +
  # geom_point(aes(x = year, y = actual), alpha = .3) + #), color = 'black') +
  geom_line(aes(x = year, y = Predicted_U5MR), size = 1.5) +
  theme_bw()

ggsave("Kent_Plot_3.png",plot=plot.3)





# 10. BONUS - Using your preferred model, predict what the U5MR would be for Ecuador in the year 2020. The real value for Ecuador for 2020 was 13 under-5 deaths per 1000 live births. How far off was your model prediction???
#   Your code should predict the value using the model and calculate the difference between the model prediction and the real value (13).

mod.pred<- predict(mod3,data.frame(year=2020,continent="Americas",country="Ecuador"))


reisd <- 13-mod.pred



# Create any model of your choosing that improves upon this “Ecuadorian measure of model correctness.” By transforming the data, I was able to find a model that predicted Ecuador would have a U5MR of 16.61…not too far off from reality

  mod4 <- glm(data=dat_clean,formula=rate~year*continent+country)
mod.pred.new<- predict(mod4,data.frame(year=2020,region="South America",continent="Americas",country="Ecuador"))

compare_performance(mod3,mod4) %>% plot() 
resid.new <- 13-mod.pred.new

#In the new model I decided to add country, to model three, this created a much better model with a predicted value of 14.93849 which lowered the residual to -1.938492 . 
