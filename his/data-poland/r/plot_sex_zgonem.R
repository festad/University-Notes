library(ggplot2)
library(tidyverse)
library(modelr)

zg <- read_csv("tidy_2001-2020-zgonem.csv") %>% filter(Year >= 2013)

plot <- ggplot(data = zg, mapping = aes(x = Year, y = Suicides)) +
  geom_point(mapping = aes(color = Sex)) # +
  # geom_smooth(data = zg %>% filter(Sex == "Male"))  +
  # geom_smooth(data = zg %>% filter(Sex == "Female"))

pred_m = lm(Suicides ~ Year, data = zg %>% filter(Sex == "Male"))
pred_f = lm(Suicides ~ Year, data = zg %>% filter(Sex == "Female"))

pred <- zg %>% spread_predictions(pred_m, pred_f)

plot <- plot + 
  pred %>% geom_line(mapping = aes(x = Year, y = pred_f), colour = "red") +
  pred %>% geom_line(mapping = aes(x = Year, y = pred_m), colour = "blue") +
  scale_x_continuous(breaks = zg$Year)
  

plot <- plot + labs(x = "Years",
                    y = "Fatal suicides",
                    title = "Fatal suicides in Poland")

plot