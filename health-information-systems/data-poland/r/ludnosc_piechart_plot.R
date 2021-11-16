library(ggplot2)
library(tidyverse)
library(modelr)

zg <- read_csv("ludnosc.csv") %>%
  filter(Garnizon == "KSP Warszawa" | Garnizon == "KWP Katowice" |
           Garnizon == "KWP Kraków" | Garnizon == "KWP Opole" |
           Garnizon == "KWP Poznań")

zg <- zg[order(zg$Garnizon),]

ggplot(data = zg,
       mapping = aes(x = "", y = Population, 
                     fill = Garnizon)) +
  geom_col(width = 1) +
  scale_fill_manual(values=c("red", "blue", "green", "blueviolet", "orange")) +
  coord_polar(theta = "y") +
  labs(x = "Population",
       y = "Garnizon",
       title = "Population of important cities in Poland")