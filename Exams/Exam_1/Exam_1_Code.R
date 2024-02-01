# YOUR TASKS:
#   I. Read the cleaned_covid_data.csv file into an R data frame. (20 pts)
df <- read.csv("./data/cleaned_covid_data.csv",header=TRUE)
names(df)
# II. Subset the data set to just show states that begin with “A” and save this as an object called A_states. (20 pts)
library(tidyverse)
A_states <- df %>% 
  filter(grepl("^A",df$Province_State))


# III. Create a plot of that subset showing Deaths over time, with a separate facet for each state. (20 pts)
## Create a scatterplot
## Add loess curves WITHOUT standard error shading
##Keep scales “free” in each facet

A_states %>%
  ggplot(mapping=aes(x=as.Date(Last_Update),
                     y=Deaths,color=Province_State)) +
  geom_jitter(height=.5,width=2)+
  geom_point()+
  facet_wrap(~Province_State, scales="free")+
  geom_smooth(method="loess",se=FALSE, color='black')



# IV. (Back to the full dataset) Find the “peak” of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate. (20 pts)
# I’m looking for a new data frame with 2 columns:
# “Province_State”
# “Maximum_Fatality_Ratio”
# Arrange the new data frame in descending order by Maximum_Fatality_Ratio
# This might take a few steps. Be careful about how you deal with missing values!



state_max_fatality_rate <- df %>%
  filter(!is.na(Case_Fatality_Ratio))%>%
  group_by(Province_State) %>%
  summarize(Maximum_Fatality_Ratio=max(Case_Fatality_Ratio)) %>%
  arrange(desc(Maximum_Fatality_Ratio))


#V. Use that new data frame from task IV to create another plot. (20 pts)
# X-axis is Province_State
# Y-axis is Maximum_Fatality_Ratio
# bar plot
# x-axis arranged in descending order, just like the data frame (make it a factor to accomplish this)
# X-axis labels turned to 90 deg to be readable
# Even with this partial data set (not current), you should be able to see that (within these dates), different states had very different fatality ratios.


state_max_fatality_rate %>%ggplot(mapping=aes(x=factor(Province_State, levels=as.character(Province_State, sep=",")),
                                              y=Maximum_Fatality_Ratio)) +
  geom_col()+
  theme(axis.text.x = element_text(angle = 90) )





# VI. (BONUS 10 pts) Using the FULL data set, plot cumulative deaths for the entire US over time
# You’ll need to read ahead a bit and use the dplyr package functions group_by() and summarize() to accomplish this.


deaths <- df %>% group_by(as.Date(df$Last_Update)) %>% summarise(TotalDeaths = sum(Deaths))

deaths %>% 
  ggplot(aes(x =`as.Date(df$Last_Update)`, y = TotalDeaths)) +
  geom_point()+
  labs(x="Last Update", y="Total Deaths")




