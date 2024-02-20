library(ggplot2)
library(ggimage)
library(stevedata)
library(tidyverse)
Presidents$Term_Length.days=as.numeric(Presidents$end-Presidents$start)
Presidents %>% 
  ggplot(aes(x =president, y = Term_Length.days)) +
  geom_point(shape = 8, size = 10, color="Yellow") + 
  labs(title = "Presidential Term Lengths",
       x = "President",
       y = "Term Length (Days)")+
  geom_bgimage("/Users/rosie/Downloads/aWM6jZ4_700bwp.jpeg")+
  theme(axis.text = element_text(color = "yellow"), axis.title = element_text(color = "blue"),plot.title = element_text(color = "yellow"), plot.background = element_rect(fill = "red"))+
  theme(axis.text.x=element_text(angle=90, hjust=1,vjust=.5,size=8))

