library(tidyverse)

# install.packages("devtools")
?msleep
glimpse(msleep)
view(msleep)

#reorder columns
msleep %>%
  select(vore, name, everything()) %>%
  glimpse()

# change a variable type
class(msleep$vore)

msleep %>%
  select(vore, name, everything()) %>%
  mutate(vore = as.factor(vore)) %>%
  glimpse()

# select variables to work with
msleep %>%
  select(2:4, awake, starts_with("sleep"), contains("wt")) %>%
  view()

# filter and arrange data
unique(msleep$order)

msleep %>%
  filter((order == "Carnivora" | order == "Primates") & sleep_total > 8) %>%
  select(name, order, sleep_total) %>%
  arrange(order, -sleep_total) %>%
  View()

# change observations (mutate)
msleep %>%
  mutate(brainwt_in_grams = brainwt * 1000) %>%
  View()

#conditional change (if_else)
## logical vector based in a condition
msleep$brainwt
msleep$brainwt > 0.01

size_of_brain <- msleep %>%
  select(name, brainwt) %>%
  drop_na(brainwt) %>%
  mutate(brain_size = if_else(brainwt > 0.01, "large", "small")) %>%
  arrange(-brainwt)

size_of_brain

# recode data and rename a variable
## change observations of "large" and "small" into 1 and 2

size_of_brain %>%
  mutate(brain_size = if_else(brain_size == "large", 1, 2)) %>%
  View()

# reshape data from wide to long or long to wide
View(gapminder)

data <- select(gapminder, country, year, lifeExp)

View(data)

## pivot_wider
wide_data <- data %>%
  pivot_wider(names_from = year, values_from = lifeExp)

View(wide_data)

## pivot_longer
long_data <- wide_data %>%
  pivot_longer(2:13, names_to = "year", values_to = "lifeExp")

View(long_data)