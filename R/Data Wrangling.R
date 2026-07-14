# Data Wrangling with tidyverse
library(tidyverse)
library(ggplot2)
library(dplyr) 

?diamonds
data("diamonds")

# subset by row with filter()------------------------------------------

?select

diamonds_sm <- filter(diamonds, cut == "Ideal")
diamonds_sm <- filter(diamonds, price > 10000)
diamonds_sm <- filter(diamonds, cut == "Ideal",
                                price > 10000)
diamonds_sm <- filter(diamonds, cut == "Ideal" |
                      price > 10000)
diamonds_missing <- filter(diamonds, is.na(depth))

  #filter for missing values using is.na or !is.na

# subset by column with select()---------------------------------------

diamonds_sm <- select(diamonds, cut, color) # shows selected columns
diamonds_sm <- select(diamonds, 3:7) # shows the selected column within range
diamonds_sm <- select(diamonds, starts_with("c")) # shows all columns that starts with the selected letter
diamonds_sm <- select(diamonds, contains("c")) # shows all columns that contains selected letter
diamonds_sm <- select(diamonds,
                      price,
                      everything()) # puts the selected column in front
diamonds_sm <- select(diamonds, -price) # removes specific column

# using the pipe
diamonds_sm <- diamonds %>%
  select(-price) 

# reorder rows with arrange()-------------------------------------------

?arrange

diamonds_arr <- diamonds %>%
  arrange(color)
diamonds_arr <- diamonds %>%
  arrange(carat)
view(diamonds_arr)
diamonds_arr <- diamonds %>%
  arrange(carat, color)
diamonds_arr <- diamonds %>%
  arrange(desc(carat))

glimpse(diamonds_arr)

# add or modify columns with mutate()--------------------------------------

diamonds_mod <- diamonds %>%
  mutate(mass_g = 0.20 * carat)
view(diamonds_mod)
glimpse(diamonds_mod)

diamonds_mod <- diamonds %>%
  mutate(mass_g = 0.20 * carat,
         price_per_carat = price / carat)

diamonds_mod <- diamonds %>%
  mutate(mass_g = 0.20 * carat,
         price_per_carat = price / carat,
         cut = tolower(cut))

diamonds_mod <- diamonds %>%
  mutate(mass_g = 0.20 * carat,
         price_per_carat = price / carat,
         cut = tolower(cut),
         expensive = price > 10000)

# other smaller verbs ------------------------------------------------------------

?slice_max
?bind_rows
?left_join
?rename
?case_when

# grouped summaries with group_by() and summarize()---------------------------------------------------

diamonds %>%
  group_by(cut) %>%
  summarize(average_price = mean(price),
            sd_price = sd(price))
 
diamonds %>%
  group_by(cut,
           color) %>%
  summarize(average_price = mean(price),
            sd_price = sd(price))

diamonds %>%
  group_by(cut,
           color) %>%
  summarize(average_price = mean(price),
            sd_price = sd(price),
            count = n())

diamonds %>%
  count(cut, color) # counts only.

diamonds %>%
  group_by(expensive = price > 10000) %>%
  summarize(avg_price = mean(price),
            sd_price = sd(price),
            count = n())
