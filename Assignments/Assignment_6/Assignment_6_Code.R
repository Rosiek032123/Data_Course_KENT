library(tidyverse)
library(janitor)
library(readxl)
library(gganimate)
library(ggplot2)

dat<-read_csv("../../Data/BioLog_Plate_Data.csv")
#1.Cleans this data into tidy (long) form
#2 Creates a new column specifying whether a sample is from soil or water
dat <- dat %>% 
  clean_names()

dat_clean <- dat %>% 
  pivot_longer(starts_with("hr"), names_to = "time", values_to = "absorbance" ) %>%
  mutate(time=case_when(time=="hr_24"~24,
                         time=="hr_48"~48,
                         time=="hr_144"~144)) %>% 
  mutate(sample_type=case_when(sample_id=="Clear_Creek"| sample_id=="Waste_Water"~"Water",
sample_id=="Soil_1"|sample_id=="Soil_2"~"Soil"))




#3.Generates a plot that matches this one (note just plotting dilution == 0.1):

plot <- dat_clean %>%
  filter(substrate == 'Itaconic Acid') %>%
  group_by(time, sample_id, dilution) %>%
  summarize(mean_absorbance = mean(absorbance)) %>%
  ggplot(aes(x = time, y = mean_absorbance, color = sample_id)) +
  geom_line() +
  facet_grid(~dilution) +
  transition_reveal(time)

animate(plot)
