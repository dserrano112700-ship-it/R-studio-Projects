library(tidyverse)

?msleep
data(msleep)
glimpse(msleep)
View(msleep)

# rename a variable
msleep_clean <- msleep %>%
  select(-sleep_cycle, -sleep_rem, -brainwt, -conservation) %>%
  rename("diet" = "vore") %>%
  mutate(diet = recode(diet, "carni" = "carnivore",
                       "omni" = "omnivore",
                       "herbi" = "herbivore",
                       "insecti" = "insectivore"),
         diet = replace_na(diet, "unknown"))

View(msleep_clean)

