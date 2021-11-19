library(ggplot2)
library(tidyverse)
library(modelr)

zg <- read_csv("tidy_2001-2020-niezgonem.csv") %>% filter(Year >= 2013)

pred_m = lm(Suicides ~ Year, data = zg %>% filter(Sex == "Male"))
pred_f = lm(Suicides ~ Year, data = zg %>% filter(Sex == "Female"))

pred <- zg %>% spread_predictions(pred_m, pred_f)

pred$pred_f <- pred$pred_f - pred$pred_f[1]
pred$pred_m <- pred$pred_m - pred$pred_m[1]

plot <- ggplot(data = pred) + 
  pred %>% geom_line(mapping = aes(x = Year, y = pred_f), colour = "red") +
  pred %>% geom_line(mapping = aes(x = Year, y = pred_m), colour = "blue")

plot <- plot + labs(x = "Years",
                    y = "Rate of attempted suicides",
                    title = "Rate of attempted suicides in Poland")

plot