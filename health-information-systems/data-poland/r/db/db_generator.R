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
  
  i1 <- with(tib, Garnizon == "KWP Gorzów Wielk.")
  tib$Garnizon[i1] <- "KWP Gorzów Wlkp."
  
  tib$Year <- as.integer(tib$Year)
  tib <- tib %>%gather(`0-6`:`85+`,key='Age', value='Suicides by age' )
  return(tib)
}

tidying1316 <- function(tib) {
  return(tidying(tib %>% rename(Garnizon = KWP)))
}


sex_tidying <- function(tib) {
  tib <- tib %>% select(Rok, Garnizon, starts_with("W tym "))
  tib <- tib %>% setNames(gsub("W tym ", "", names(.))) %>%
    setNames(gsub("mężczyzn", "Male", names(.))) %>%
    setNames(gsub("kobiet", "Female", names(.)))
  tib <- tib %>% rename(Year = Rok)
  
  # tib <- tib %>% filter(Garnizon == "KSP Warszawa" | Garnizon == "KWP Katowice" |
  #          Garnizon == "KWP Kraków" | Garnizon == "KWP Opole" |
  #          Garnizon == "KWP Poznań" | Garnizon == "Polska")
  
  i1 <- with(tib, Garnizon == "KWP Gorzów Wielk.")
  tib$Garnizon[i1] <- "KWP Gorzów Wlkp."
  
  tib$Year <- as.integer(tib$Year)
  return(tib)
}

sex_tidying1316 <- function(tib) {
  return(sex_tidying(tib %>% rename(Garnizon = KWP)))
}


nie9912 <- readxl::read_xls('niezgonem-1999_2012.xls')
nie1316 <- readxl::read_xlsx('niezgonem-2013_2016.xlsx')
nie1720 <- readxl::read_xlsx('niezgonem-2017_2020.xlsx')

nie9912 <- tidying(nie9912)
nie1316 <- tidying1316(nie1316)
nie1720 <- tidying1316(nie1720)

nie <- nie9912 %>% add_row(nie1316) %>% add_row(nie1720)

zg9912 <- readxl::read_xls('zgonem-1999_2012.xls')
zg1316 <- readxl::read_xlsx('zgonem-2013_2016.xlsx')
zg1720 <- readxl::read_xlsx('zgonem-2017_2020.xlsx')

zg9912 <- tidying(zg9912)
zg1316 <- tidying1316(zg1316)
zg1720 <- tidying1316(zg1720)

zg <- zg9912 %>% add_row(zg1316) %>% add_row(zg1720)

# nie %>% write_csv("tidy_niezgonem-age-garnizon.csv")
# zg %>% write_csv("tidy_zgonem-age-garnizon.csv")

nie %>% add_column(Result = "Attempted") -> nie
zg %>% add_column(Result = "Fatal") -> zg

dw <- nie %>% add_row(zg)

sexnie9912 <- readxl::read_xls('sex-niezgonem-1999_2012.xls')
sexnie1316 <- readxl::read_xlsx('sex-niezgonem-2013_2016.xlsx')
sexnie1720 <- readxl::read_xlsx('sex-niezgonem-2017_2020.xlsx')

sexnie9912 <- sex_tidying(sexnie9912)
sexnie1316 <- sex_tidying1316(sexnie1316)
sexnie1720 <- sex_tidying1316(sexnie1720)

sexnie <- sexnie9912 %>% add_row(sexnie1316) %>% add_row(sexnie1720)

sexzg9912 <- readxl::read_xls('sex-zgonem-1999_2012.xls')
sexzg1316 <- readxl::read_xlsx('sex-zgonem-2013_2016.xlsx')
sexzg1720 <- readxl::read_xlsx('sex-zgonem-2017_2020.xlsx')

sexzg9912 <- sex_tidying(sexzg9912)
sexzg1316 <- sex_tidying1316(sexzg1316)
sexzg1720 <- sex_tidying1316(sexzg1720)

sexzg <- sexzg9912 %>% add_row(sexzg1316) %>% add_row(sexzg1720)

sexnie %>% add_column(Result = "Attempted") -> nie
sexzg %>% add_column(Result = "Fatal") -> zg

sexdw <- nie %>% add_row(zg)

full_dw <- dw %>% left_join(sexdw) %>% 
  gather(`Male`, `Female`, key='Sex', value='Suicides by sex' )

full_dw %>% write_csv("poland_suicides_full_database.csv")