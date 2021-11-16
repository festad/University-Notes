library(ggplot2)
library(tidyverse)
library(modelr)

zg <- read_csv("tidy_zgonem-percs-cities.csv") %>% 
  select(Year, Garnizon, Suicides)       %>% 
  filter(Year >= 2013)                   %>%
  filter(Garnizon == "KSP Warszawa" | Garnizon == "KWP Katowice" |
           Garnizon == "KWP Kraków" | Garnizon == "KWP Opole" |
           Garnizon == "KWP Poznań")

plot <- ggplot(data = zg, mapping = aes(x = Year, y = Suicides)) +
  geom_point(mapping = aes(color = Garnizon)) +
  scale_color_manual(values=c("red", "blue", "green", "blueviolet", "orange"))# +

plot

pred_warz = lm(Suicides ~ Year, data = zg %>% 
                 filter(Garnizon == "KSP Warszawa"));
pred_kato = lm(Suicides ~ Year, data = zg %>% 
                 filter(Garnizon == "KWP Katowice"))
pred_krak = lm(Suicides ~ Year, data = zg %>% 
                 filter(Garnizon == "KWP Kraków"))
pred_opol = lm(Suicides ~ Year, data = zg %>% 
                 filter(Garnizon == "KWP Opole"))
pred_pozn = lm(Suicides ~ Year, data = zg %>% 
                 filter(Garnizon == "KWP Poznań"))


pred <- zg %>% spread_predictions(pred_warz,
                                  pred_kato, 
                                  pred_krak, 
                                  pred_opol, 
                                  pred_pozn)

plot <- plot + 
  pred %>% geom_line(mapping = aes(x = Year, y = pred_warz), colour = "red")        +
  pred %>% geom_line(mapping = aes(x = Year, y = pred_kato), colour = "blue")       +
  pred %>% geom_line(mapping = aes(x = Year, y = pred_krak), colour = "green")      +
  pred %>% geom_line(mapping = aes(x = Year, y = pred_opol), colour = "blueviolet") +
  pred %>% geom_line(mapping = aes(x = Year, y = pred_pozn), colour = "orange")

plot <- plot + labs(x = "Years",
                    y = "Fatal suicides (%)",
                    title = "Fatal suicides over population in different cities of Poland")

plot