library('tidyverse')
library('readxl')
library('gapminder')

tidying <- function(tib) {
  tib <- tib %>% select(Rok, Garnizon, starts_with("Grupa"))
  tib <- tib %>% setNames(gsub("Grupa wiekowa - ", "", names(.))) %>%
    setNames(gsub(" lata", "", names(.))) %>%
    setNames(gsub(" lat", "", names(.))) %>%
    setNames(gsub("- ","-", names(.))) %>%
    setNames(gsub("nieustalona", "undetermined", names(.))) %>%
    setNames(gsub("i wiecej", "+", names(.))) %>%
    setNames(gsub(" ", "", names(.))) %>%
    setNames(gsub("'", "", names(.)))
  tib <- tib %>% 
    rename(year = Rok) %>% 
    rename(garnizon = Garnizon)
  
  # tib <- tib %>% filter(Garnizon == "KSP Warszawa" | Garnizon == "KWP Katowice" |
  #          Garnizon == "KWP Kraków" | Garnizon == "KWP Opole" |
  #          Garnizon == "KWP Poznań" | Garnizon == "Polska")
  
  i1 <- with(tib, garnizon == "KWP Gorzów Wielk.")
  tib$garnizon[i1] <- "KWP Gorzów Wlkp."
  
  tib$year <- as.integer(tib$year)
  tib <- tib %>%gather(c(`0-6`:`85+`,undetermined),key='age', value='suicides' )
  return(tib)
}

tidying1316 <- function(tib) { 
  tib %>% rename(Garnizon = KWP) %>%
    setNames(gsub("Wiek nieustalony", 
                  "Grupa wiekowa - nieustalona", names(.))) -> tib
  return(tidying(tib))
}

tidying1721 <- function(tib) { 
  tib %>% rename(Garnizon = KWP) %>%
    setNames(gsub("Wiek nieustalony", 
                  "Grupa wiekowa - nieustalona", names(.))) -> tib
  return(tidying(tib))
}


sex_tidying <- function(tib) {
  tib <- tib %>% select(Rok, Garnizon, starts_with("W tym "))
  tib <- tib %>% setNames(gsub("W tym ", "", names(.))) %>%
    setNames(gsub("mężczyzn", "Male", names(.))) %>%
    setNames(gsub("kobiet", "Female", names(.)))
  tib <- tib %>% 
    rename(year = Rok) %>% 
    rename(garnizon = Garnizon)
  
  # tib <- tib %>% filter(Garnizon == "KSP Warszawa" | Garnizon == "KWP Katowice" |
  #          Garnizon == "KWP Kraków" | Garnizon == "KWP Opole" |
  #          Garnizon == "KWP Poznań" | Garnizon == "Polska")
  
  i1 <- with(tib, garnizon == "KWP Gorzów Wielk.")
  tib$garnizon[i1] <- "KWP Gorzów Wlkp."
  
  tib$year <- as.integer(tib$year)
  tib <- tib %>% gather(`Male`, `Female`, key='sex', value='suicides' )
  return(tib)
}

sex_tidying1316 <- function(tib) {
  return(sex_tidying(tib %>% rename(Garnizon = KWP)))
}

sex_tidying1721 <- function(tib) {
  return(sex_tidying(tib %>% rename(Garnizon = KWP)))
}


nie9912 <- readxl::read_xls('niezgonem-1999_2012.xls')
nie1316 <- readxl::read_xlsx('niezgonem-2013_2016.xlsx')
nie1721 <- readxl::read_xlsx('niezgonem-2017_2021.xlsx')

nie9912 <- tidying(nie9912)
nie1316 <- tidying1316(nie1316)
nie1721 <- tidying1721(nie1721)

nie <- nie9912 %>% add_row(nie1316) %>% add_row(nie1721)

zg9912 <- readxl::read_xls('zgonem-1999_2012.xls')
zg1316 <- readxl::read_xlsx('zgonem-2013_2016.xlsx')
zg1721 <- readxl::read_xlsx('zgonem-2017_2021.xlsx')

zg9912 <- tidying(zg9912)
zg1316 <- tidying1316(zg1316)
zg1721 <- tidying1721(zg1721)

zg <- zg9912 %>% add_row(zg1316) %>% add_row(zg1721)

# nie %>% write_csv("tidy_niezgonem-age-garnizon.csv")
# zg %>% write_csv("tidy_zgonem-age-garnizon.csv")

nie %>% add_column(outcome = "Attempted") -> nie
zg %>% add_column(outcome = "Fatal") -> zg

age <- nie %>% add_row(zg)

age <- age %>% filter(garnizon != "Polska")
age %>% write_csv("1999_2021_age.csv")

sexnie9912 <- readxl::read_xls('sex-niezgonem-1999_2012.xls')
sexnie1316 <- readxl::read_xlsx('sex-niezgonem-2013_2016.xlsx')
sexnie1721 <- readxl::read_xlsx('sex-niezgonem-2017_2021.xlsx')

sexnie9912 <- sex_tidying(sexnie9912)
sexnie1316 <- sex_tidying1316(sexnie1316)
sexnie1721 <- sex_tidying1721(sexnie1721)

sexnie <- sexnie9912 %>% add_row(sexnie1316) %>% add_row(sexnie1721)

sexzg9912 <- readxl::read_xls('sex-zgonem-1999_2012.xls')
sexzg1316 <- readxl::read_xlsx('sex-zgonem-2013_2016.xlsx')
sexzg1721 <- readxl::read_xlsx('sex-zgonem-2017_2021.xlsx')

sexzg9912 <- sex_tidying(sexzg9912)
sexzg1316 <- sex_tidying1316(sexzg1316)
sexzg1721 <- sex_tidying1721(sexzg1721)

sexzg <- sexzg9912 %>% add_row(sexzg1316) %>% add_row(sexzg1721)

sexnie %>% add_column(outcome = "Attempted") -> nie
sexzg %>% add_column(outcome = "Fatal") -> zg

sexwpol <- nie %>% add_row(zg)
sex <- sexwpol %>% filter(garnizon != "Polska")
sex %>% write_csv("1999_2021_sex.csv")

polska_sex <- sexwpol %>% 
  filter(garnizon == "Polska") %>%
  select(-(garnizon))
# polska_sex %>% write_csv("1999_2021_sex_poland.csv")


polska <- polska_sex %>%
  spread(key = sex, value = suicides) %>%
  mutate(`suicides` = Male + Female) %>%
  select(-(c(Male, Female)))
polska %>% write_csv("1999_2021_poland.csv")

polska_sex_perc <- polska_sex %>%
  spread(key = sex, value = suicides) %>%
  mutate(`suicides total` = Male + Female) %>%
  gather(Male, Female, key = 'sex', value = 'suicides') %>%
  mutate(percentage = suicides / `suicides total`) %>%
  select(-(`suicides total`))
polska_sex_perc %>% write_csv("1999_2021_sex_perc_poland.csv")

lud <- read_csv("ludnosc.csv")
sex %>% 
  spread(key = sex, value = suicides) %>%
  mutate(total = Male + Female) %>%
  left_join(lud) %>%
  mutate(percentage = total / population) %>%
  select(-(c(Male, Female, population))) -> polska_perc
polska_perc %>% write_csv("1999_2021_kwp_perc.csv")


# full_dw <- dw %>% left_join(sex)
# 
# lud <- read_csv("ludnosc.csv")
# 
# full_dw <- full_dw %>% left_join(lud)
# 
# full_dw %>% mutate(Percentage = Total / Population) -> full_dw
# 
# full_dw %>% write_csv("poland_suicides_full_database.csv")