library(ggplot2)
library(tidyverse)
library(modelr)

zg <- read_csv("tidy_2001-2020-niezgonem.csv") %>% filter(Year >= 2013)

plot <- ggplot(data = zg, mapping = aes(x = Year, y = Suicides)) +
  geom_point(mapping = aes(color = Sex)) # +
# geom_smooth(data = zg %>% filter(Sex == "Male"))  +
# geom_smooth(data = zg %>% filter(Sex == "Female"))

pred_m = lm(Suicides ~ Year, data = zg %>% filter(Sex == "Male"))
pred_f = lm(Suicides ~ Year, data = zg %>% filter(Sex == "Female"))

pred <- zg %>% spread_predictions(pred_m, pred_f)

plot <- plot + 
  pred %>% geom_line(mapping = aes(x = Year, y = pred_f), colour = "red") +
  pred %>% geom_line(mapping = aes(x = Year, y = pred_m), colour = "blue")

plot <- plot + labs(x = "Years",
                    y = "Attempted suicides",
                    title = "Attempted suicides in Poland")

plot