library(tidyverse)
library(ggplot2)

poland <- read_csv("csvs/1999_2021_sex.csv")
ludnosc <- read_csv("csvs/ludnosc.csv")

poland <- poland %>%
  filter(year == 2021) %>%
  filter(outcome == 'Attempted') %>%
  filter(sex == 'Male')

poland <- poland %>% 
  left_join(ludnosc) %>%
  mutate(perc = suicides / population)

plt <- ggplot(poland, mapping=aes(x=perc, y=garnizon)) +
  geom_bar(stat="identity") +
  labs(
    title = "Suicides in Polish areas",
    subtitle = "(2021)",
    caption = "Data from statystyczna ...",
    x = "Suicides",
    y = "Garnizon"
    # colour = "Sex",
    # shape = "Fatality"
  )

plt

# ggsave("plt_1999_2021_poland.eps", plt, device="eps")