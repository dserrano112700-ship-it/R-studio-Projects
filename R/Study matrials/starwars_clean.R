library(tidyverse)
library(tidyr)
library(ggplot2)
library(lubridate)
library(dplyr)

data(starwars)

glimpse(starwars)
class(starwars$gender)
unique(starwars$gender)

starwars$gender <- as.factor(starwars$gender)
class(starwars)
starwars$sex <- as.character(starwars$sex)
glimpse(starwars)


#select and filter the missing values
starwars %>%
  select(where(~ !is.list(.)), -birth_year, -height, -mass) %>%
  filter(!complete.cases(.)) %>%
  view()

# deal with the nessessary missing values
starwars_clean <- starwars %>%
  select(where(~ !is.list(.))) %>%
  mutate(hair_color = replace_na(hair_color, "none"),
         sex = replace_na(sex, "unknown"),
         homeworld = replace_na(homeworld, "unknown"),
         species = replace_na(species, "unknown")
         )

view(starwars_clean)
