library(ggplot2)
library(tidyverse)
library(modelr)

zg <- read_csv("tidy_zgonem-cities.csv") %>% 
  select(Year, Garnizon, Suicides)       %>% 
  filter(Year >= 2013)                   %>%
  filter(Garnizon == "KSP Warszawa" | Garnizon == "KWP Katowice" |
         Garnizon == "KWP Kraków" | Garnizon == "KWP Opole")

plot <- ggplot(data = zg, mapping = aes(x = Year, y = Suicides)) +
  geom_point(mapping = aes(color = Garnizon)) # +
# geom_smooth(data = zg %>% filter(Sex == "Male"))  +
# geom_smooth(data = zg %>% filter(Sex == "Female"))

plot

pred_m = lm(Suicides ~ Year, data = zg %>% filter(Sex == "Male"))
pred_f = lm(Suicides ~ Year, data = zg %>% filter(Sex == "Female"))

pred <- zg %>% spread_predictions(pred_m, pred_f)

plot <- plot + 
  pred %>% geom_line(mapping = aes(x = Year, y = pred_f), colour = "red") +
  pred %>% geom_line(mapping = aes(x = Year, y = pred_m), colour = "blue")

plot <- plot + labs(x = "Years",
                    y = "Fatal suicides",
                    title = "Fatal suicides in Poland")

plot