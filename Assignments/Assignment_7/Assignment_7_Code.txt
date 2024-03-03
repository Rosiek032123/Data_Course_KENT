library(tidyverse)
library(janitor)
library(readxl)
library(ggplot2)

##Import the Assignment_7/Utah_Religions_by_County.csv data set
df <- read_csv('./Utah_Religions_by_County.csv')

##Clean it up into “tidy” shape
dat_clean <- df %>% 
  pivot_longer(cols = -c(County,Pop_2010,Religious),names_to = "Religion",values_to ="Proportion") %>% 
  clean_names()#cleaning the data




##Explore the cleaned data set with a series of figures (I want to see you exploring the data set)

dif.religions=dat_clean$religion %>% unique() #I'm interested into looking at how many different religions are included in this dataset. It looks like there are 13 different religions although two options are "non-religious" and "non denominational"


dat_clean %>% 
  mutate(religion_totals=dat_clean$pop_2010*dat_clean$proportion)#I wanted to look at things by the number not by the proportions so I created a new column that multiplied the population by proportion

dat_clean %>% 
  ggplot(aes(x = TRUE, fill = religion, y = proportion))  +
  geom_bar(stat = 'identity', width = 1, position = 'dodge') +
  facet_wrap(~county)#I was interested in seeing if there is a prominence in religions graphically and it looks like, as expected, the LDS religion dominates.



top_three_religions_by_county <- dat_clean %>%
  group_by(county, religion) %>%
  summarise(total_proportion = sum(proportion)) %>%
  top_n(3, total_proportion) %>%
  arrange(county, desc(total_proportion))# I was interested in finding the top three biggest religions in each county


top_three_religions_by_county %>% 
ggplot(top_three_religions_by_county, aes(x = county, y = total_proportion, fill = religion)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Top Three Biggest Religions in Each County",
       x = "County",
       y = "Total Proportion",
       fill = "Religion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust=1))# Plotting the top three biggest religions in each county




##Q1“Does population of a county correlate with the proportion of any specific religious group in that county?”

correlation_results <- dat_clean %>%
  group_by(religion) %>%
  summarise(correlation = cor(pop_2010, proportion))# it appears population is most highly correlated with the proportion of Muslims with a correlation of0.7592.




##Q2:Does proportion of any specific religion in a given county correlate with the proportion of non-religious people?” Just stick to figures and maybe correlation indices…no need for statistical tests yet


correlation_q2 <- dat_clean %>% mutate(non_religious_prop = 1 -religious) %>% 
  group_by(religion) %>% summarize(correlation = cor(proportion, non_religious_prop)) %>% arrange(abs(correlation))

ggplot(correlation_q2, aes(x = reorder(religion, correlation), y = correlation)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.5) +
  labs(x = "Religion",
       y = "Correlation Coefficient",
       title = "Correlation between Proportion of Religion and Non-Religious People",
       caption = "Data Source: Your Data Source") +
  theme_minimal()#as you can see from the list and the graph that LDS has a high negative correlation with the proportion of non-religious. This makes sense seeing that these are two of the biggest groups for each county. As one rpoportion goes down the other usually goes up. 
