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
  
  tib <- tib %>% mutate(garnizon = gsub("KWP ", "", garnizon))
  tib <- tib %>% mutate(garnizon = gsub("KSP ", "", garnizon))
  
  
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
  
  tib <- tib %>% mutate(garnizon = gsub("KWP ", "", garnizon))
  tib <- tib %>% mutate(garnizon = gsub("KSP ", "", garnizon))

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


nie9912 <- readxl::read_xls('./excels/niezgonem-1999_2012.xls')
nie1316 <- readxl::read_xlsx('./excels/niezgonem-2013_2016.xlsx')
nie1721 <- readxl::read_xlsx('./excels/niezgonem-2017_2021.xlsx')

nie9912 <- tidying(nie9912)
nie1316 <- tidying1316(nie1316)
nie1721 <- tidying1721(nie1721)

nie <- nie9912 %>% add_row(nie1316) %>% add_row(nie1721)

zg9912 <- readxl::read_xls('./excels/zgonem-1999_2012.xls')
zg1316 <- readxl::read_xlsx('./excels/zgonem-2013_2016.xlsx')
zg1721 <- readxl::read_xlsx('./excels/zgonem-2017_2021.xlsx')

zg9912 <- tidying(zg9912)
zg1316 <- tidying1316(zg1316)
zg1721 <- tidying1721(zg1721)

zg <- zg9912 %>% add_row(zg1316) %>% add_row(zg1721)

nie %>% add_column(outcome = "Attempted") -> nie
zg %>% add_column(outcome = "Fatal") -> zg

age <- nie %>% add_row(zg)

age <- age %>% filter(garnizon != "Polska")
age %>% write_csv("./csvs/1999_2021_age.csv")

sexnie9912 <- readxl::read_xls('./excels/sex-niezgonem-1999_2012.xls')
sexnie1316 <- readxl::read_xlsx('./excels/sex-niezgonem-2013_2016.xlsx')
sexnie1721 <- readxl::read_xlsx('./excels/sex-niezgonem-2017_2021.xlsx')

sexnie9912 <- sex_tidying(sexnie9912)
sexnie1316 <- sex_tidying1316(sexnie1316)
sexnie1721 <- sex_tidying1721(sexnie1721)

sexnie <- sexnie9912 %>% add_row(sexnie1316) %>% add_row(sexnie1721)

sexzg9912 <- readxl::read_xls('./excels/sex-zgonem-1999_2012.xls')
sexzg1316 <- readxl::read_xlsx('./excels/sex-zgonem-2013_2016.xlsx')
sexzg1721 <- readxl::read_xlsx('./excels/sex-zgonem-2017_2021.xlsx')

sexzg9912 <- sex_tidying(sexzg9912)
sexzg1316 <- sex_tidying1316(sexzg1316)
sexzg1721 <- sex_tidying1721(sexzg1721)

sexzg <- sexzg9912 %>% add_row(sexzg1316) %>% add_row(sexzg1721)

sexnie %>% add_column(outcome = "Attempted") -> nie
sexzg %>% add_column(outcome = "Fatal") -> zg

sex_p_poland <- nie %>% add_row(zg)
sex <- sex_p_poland %>% filter(garnizon != "Polska")
sex %>% write_csv("./csvs/1999_2021_sex.csv")

sex_poland <- sex_p_poland %>% 
  filter(garnizon == "Polska") %>%
  select(-(garnizon))
# sex_poland %>% write_csv("./csvs/1999_2021_sex_poland.csv")


polska <- sex_poland %>%
  spread(key = sex, value = suicides) %>%
  mutate(`suicides` = Male + Female) %>%
  select(-(c(Male, Female)))
polska %>% write_csv("./csvs/1999_2021_poland.csv")

sex_perc_poland <- sex_poland %>%
  spread(key = sex, value = suicides) %>%
  mutate(`suicides total` = Male + Female) %>%
  gather(Male, Female, key = 'sex', value = 'suicides') %>%
  mutate(percentage = suicides / `suicides total`) %>%
  select(-(`suicides total`))
sex_perc_poland %>% write_csv("./csvs/1999_2021_sex_perc_poland.csv")

lud <- read_csv("ludnosc.csv")
sex %>% 
  spread(key = sex, value = suicides) %>%
  mutate(total = Male + Female) %>%
  left_join(lud) %>%
  mutate(percentage = total / population) %>%
  select(-(c(Male, Female, population))) -> kwp_perc
kwp_perc %>% write_csv("./csvs/1999_2021_kwp_perc.csv")

