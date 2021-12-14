library(tidyverse)
library(barplot3d)

dw <- read_csv("poland_suicides_full_database.csv")

dw %>% filter(Year >= 2013) %>%
  filter(Garnizon %in% c('KWP Wrocław','KWP Kraków', 
                         'KWP Opole', 'KWP Katowice',
                         'KWP Poznań', 'KWP Szczecin',
                         'KSP Warszawa')) %>%
  filter(Result == 'Attempted') %>%
  filter(Sex == 'Male') %>%
  select(c(1,2,8)) %>% distinct() -> subdw

subdw %>% filter(Garnizon == 'KWP Katowice') -> kato
kato <- kato$`Suicides by sex`
subdw %>% filter(Garnizon == 'KWP Kraków') -> kra
kra <- kra$`Suicides by sex`
subdw %>% filter(Garnizon == 'KWP Opole') -> opo
opo <- opo$`Suicides by sex`
subdw %>% filter(Garnizon == 'KWP Poznań') -> poz
poz <- poz$`Suicides by sex`
subdw %>% filter(Garnizon == 'KWP Szczecin') -> szc
szc <- szc$`Suicides by sex`
subdw %>% filter(Garnizon == 'KSP Warszawa') -> war
war <- war$`Suicides by sex`
subdw %>% filter(Garnizon == 'KWP Wrocław') -> wroc
wroc <- wroc$`Suicides by sex`

ve <- c(kato,kra,opo,poz,szc,war,wroc)

garnizon <- c('Katowice', 'Kraków', 'Opole', 'Poznań',
              'Szczecin', 'Warszawa', 'Wrocław')

barplot3d(rows=7,cols=8,z=ve, scalexy=300,theta=60,phi=30,alpha=0.1,
          topcolors=rainbow(8), ylabels = garnizon, xlabels=2013:2020)
