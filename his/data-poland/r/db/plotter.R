library(tidyverse)
library(ggplot2)

dw <- read_csv("poland_suicides_full_database.csv") 

dw %>%
  filter(Garnizon == 'Polska') %>%
  filter(Year > 1998) -> dw

plt <- ggplot(dw, mapping=aes(x=Year,y=`Suicides by sex`)) +
geom_point(mapping=aes(color=Sex, shape=Result)) +
labs(
  title = "Suicides in Poland",
  subtitle = "(1999-2021)",
  caption = "Data from statystyczna ...",
  x = "Year",
  y = "Suicides",
  colour = "Sex",
  shape = "Fatality"
)

plt <- plt + theme_dark()

saving <- function(plt, name) {
  ggsave(name, plt, device="eps")
}

saving(plt, "plot_bla")