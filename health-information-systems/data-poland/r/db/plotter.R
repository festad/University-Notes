library(tidyverse)
library(ggplot2)

dw <- read_csv("poland_suicides_full_database.csv") 

dw %>% 
  filter(Garnizon == 'KWP Kielce') %>%
  filter(Year > 2013) %>%
  filter(Result == 'Attempted') -> dw

dw %>%
  ggplot(mapping=aes(x=Year,y=`Suicides by sex`)) +
  geom_point(mapping=aes(color=Sex)) +
  geom_smooth(data = dw %>% filter(Sex == 'Male')) +
  geom_smooth(data = dw %>% filter(Sex == 'Female'))
  