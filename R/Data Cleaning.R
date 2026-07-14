# Explore
# Clean
# Manipulate
# Describe and summarise
# Visualise
# Analyse
library(tidyverse)
# what itidyverse
# what is clean data?---------------------------------------------------------
  #
# Variable types---------------------------------------------------------------
glimpse(starwars)
class(starwars$gender)
unique(starwars$gender)

starwars$gender <- as.factor(starwars$gender)
class(starwars$gender)

levels(starwars$gender)

starwars$gender <- factor((starwars$gender), levels = c("masculine", "feminine"))
levels(starwars$gender)

# Select----------------------------------------------------------------------
names(starwars) # call outs the variable names a.k.a columns

starwars %>%
  select(name, height, ends_with("color")) %>%
  names()
  #remove %>% names() to see the dataframes
starwars %>% select(name, height, ends_with("color"))

# Filter Observations---------------------------------------------------------
unique(starwars$hair_color)

starwars %>%
  select(name, height, ends_with("color")) %>%
  filter(hair_color %in% c("blond", "brown") &
           height < 180)

# Find and deal with missing data----------------------------------------------
mean(starwars$height, na.rm = TRUE) # removes empty values to get the mean

starwars %>%
  select(name, gender, hair_color, height) # shows all values in the selected variable
                                           # including empty values
starwars %>%
  select(name, gender, hair_color, height) %>%
  na.omit() # na.omit() removes the rows with NAs in the data frame

starwars %>%
  select(name, gender, hair_color, height) %>%
  na.exclude() # na.exclude removes the rows with NAs but retains the alignment
               # often better to use if you wanna plot or compare the data frame

starwars %>%
  select(name, gender, hair_color, height) %>%
  filter(!complete.cases(.)) # this is also another way to deal with missing data

starwars %>%
  select(name, gender, hair_color, height) %>%
  filter(!complete.cases(.)) %>%
  drop_na(height) # this shows all the rows with missing data except the selected variable

starwars %>%
  select(name, gender, hair_color, height) %>%
  filter(!complete.cases(.)) %>%
  mutate(hair_color = replace_na(hair_color, "none"),
         gender = replace_na(gender, "perfer not to say")) %>%
  view() # this replaces the missing values with prefered replacement

# Find and deal with duplicates----------------------------------------------

name <- c("Peter", "John", "Andrew", "Peter")
age <- c(22, 33, 44, 22)
friends <- data.frame(name, age)
duplicated(friends) # analyses if there are duplicated values in TRUE/FALSE

friends %>%
  duplicated() %>%
  view()

# Re-codding values
starwars %>% select(name, gender) %>%
  mutate(gender_coded= recode(gender, "masculine" = 1, "feminine" = 2)) %>%
  view()

library(tidyverse)
view(starwars)
