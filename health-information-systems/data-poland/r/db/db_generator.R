library('tidyverse')
library('readxl')
library('gapminder')



tidying <- function(tib) {
  tib <- tib %>% select(Rok, Garnizon, starts_with("Liczba"), starts_with("Grupa"))
  tib <- tib %>% setNames(gsub("Grupa wiekowa - ", "", names(.))) %>%
    setNames(gsub(" lata", "", names(.))) %>%
    setNames(gsub(" lat", "", names(.))) %>%
    setNames(gsub("- ","-", names(.))) %>%
    setNames(gsub(" ", "", names(.))) %>%
    setNames(gsub("'", "", names(.))) %>%
    setNames(gsub("iwiecej", "+", names(.)))
  colnames(tib)[3] <- "Total"
  tib <- tib %>% rename(Year = Rok)
  tib <- tib %>% select(-(matches("nieustalona")))
  
  # tib <- tib %>% filter(Garnizon == "KSP Warszawa" | Garnizon == "KWP Katowice" |
  #          Garnizon == "KWP Kraków" | Garnizon == "KWP Opole" |
  #          Garnizon == "KWP Poznań" | Garnizon == "Polska")
  
  tib$Year <- as.integer(tib$Year)
  tib <- tib %>%gather(`0-6`:`85+`,key='Age', value='Suicides' )
  return(tib)
}

tidying1316 <- function(tib) {
  return(tidying(tib %>% rename(Garnizon = KWP)))
}

nie9912 <- readxl::read_xls('niezgonem-1999_2012.xls')
nie1316 <- readxl::read_xlsx('niezgonem-2013_2016.xlsx')
nie1720 <- readxl::read_xlsx('niezgonem-2017-2020.xlsx')

nie9912 <- tidying(nie9912)
nie1316 <- tidying1316(nie1316)
nie1720 <- tidying1316(nie1720)

nie <- nie9912 %>% add_row(nie1316) %>% add_row(nie1720)

zg9912 <- readxl::read_xls('zgonem-1999_2012.xls')
zg1316 <- readxl::read_xlsx('zgonem-2013_2016.xlsx')
zg1720 <- readxl::read_xlsx('zgonem-2017-2020.xlsx')

zg9912 <- tidying(zg9912)
zg1316 <- tidying1316(zg1316)
zg1720 <- tidying1316(zg1720)

zg <- zg9912 %>% add_row(zg1316) %>% add_row(zg1720)

nie %>% write_csv("tidy_niezgonem-age-garnizon.csv")
zg %>% write_csv("tidy_zgonem-age-garnizon.csv")

nie %>% add_column(Result = "Attempted") -> nie
zg %>% add_column(Result = "Fatal") -> zg
dw <- nie %>% add_row(zg)
dw %>% write_csv("poland_suicides_database.csv")