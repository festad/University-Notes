library(ggplot2)
library(tidyverse)
library(modelr)

zg <- read_csv("tidy_2001-2020-zgonem.csv") %>% filter(Year > 2013)

pred_m = lm(Suicides ~ Year, data = zg %>% filter(Sex == "Male"))
pred_f = lm(Suicides ~ Year, data = zg %>% filter(Sex == "Female"))

pred <- zg %>% spread_predictions(pred_m, pred_f)

pred$pred_f <- pred$pred_f - pred$pred_f[1]
pred$pred_m <- pred$pred_m - pred$pred_m[1]

ggplot(data = pred) + 
  pred %>% geom_line(mapping = aes(x = Year, y = pred_f), colour = "red") +
  pred %>% geom_line(mapping = aes(x = Year, y = pred_m), colour = "blue") +
  scale_x_continuous(breaks = zg$Year) +
  labs(x = "Years",
       y = "Rate of fatal suicides",
       title = "Rate of fatal suicides in Poland")