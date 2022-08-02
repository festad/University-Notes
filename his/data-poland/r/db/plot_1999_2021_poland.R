library(tidyverse)
library(ggplot2)

poland <- read_csv("csvs/1999_2021_poland.csv") 

plt <- ggplot(poland, mapping=aes(x=year,y=suicides)) +
geom_point(mapping=aes(colour=outcome)) +
labs(
  title = "Suicides in Poland",
  subtitle = "(1999-2021)",
  caption = "Data from statystyczna ...",
  x = "Year",
  y = "Suicides"
  # colour = "Sex",
  # shape = "Fatality"
)

plt

# ggsave("plt_1999_2021_poland.eps", plt, device="eps")