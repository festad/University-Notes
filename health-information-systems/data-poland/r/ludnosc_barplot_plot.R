library(ggplot2)
library(tidyverse)
library(modelr)

zg <- read_csv("ludnosc.csv") %>%
  filter(Garnizon == "KSP Warszawa" | Garnizon == "KWP Katowice" |
           Garnizon == "KWP Kraków" | Garnizon == "KWP Opole" |
           Garnizon == "KWP Poznań")

zg <- zg[order(zg$Garnizon),]

ggplot(data = zg,
       mapping = aes(x = Garnizon, y = Population, 
                     fill = Garnizon)) +
  geom_col() +
  scale_fill_manual(values=c("red", "blue", "green", "blueviolet", "orange")) +
  labs(x = "Population",
       y = "Garnizon",
       title = "Population of important cities in Poland")