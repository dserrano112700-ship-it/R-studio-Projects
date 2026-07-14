library(readxl)
library(tidyverse)
library(lubridate)
library(ggplot2)

rm(list = "boxplot")

data <- read_excel(file.choose())
glimpse(data)
class(data)

head(data)
str(data)
data$chamber <- as.factor(data$chamber)
data$party <- as.factor(data$party)
glimpse(data)


data %>%
  select(-state) %>%
  filter(!complete.cases()) %>%
  view()


#making simple histogram
data_histogram <- data %>%
  ggplot(aes(x = agree_pct))+
  geom_histogram(binwidth = 0.05,
                 fill = "steelblue",
                 color = "black")
data_histogram

#making simple boxplot
data_boxplot <- ggplot(data, aes(x = party,
                 y= agree_pct,
                 fill = party))+
  geom_boxplot()+
  facet_wrap(~party)+
  labs(title = "Agreement with Biden by Party",
       x = "Party",
       y = "Agreement percentage")
data_boxplot

#scatterplot
data_scatterplot <- data %>%
  ggplot(aes(biden_margin, agree_pct, colour = party))+
  geom_point(size = 3, alpha = 0.5)+
  geom_smooth(method = "lm", se = FALSE)+
  facet_wrap(~party)
data_scatterplot


#Bar Chart
data_bar <- data %>%
  ggplot(aes(party, fill = party))+
  geom_bar()+
  theme_bw()+
  labs(title = "Head Count per Partylists",
       x = "Party",
       y = "Head Count")
data_bar

#bar chart by chamber
data_bar.chamber <- data %>%
  ggplot(aes(party, fill = party))+
  geom_bar()+
  facet_wrap(~chamber)+
  theme_bw()+
  labs(title = "Head Count per Partylists",
       x = "Party",
       y = "Head Count")
data_bar.chamber

ggplot(data,
       aes(x = chamber,
           fill = chamber)) +
  geom_bar() +
  labs(
    title = "Legislators by Chamber",
    x = "Chamber",
    y = "Count"
  )

#Violin Plot
data_violin <- data %>%
  ggplot(aes(party, agree_pct, fill = party))+
  geom_violin(trim = FALSE)+
  geom_boxplot(width = 0.1)+
  labs(title = "Distribution of Agreement by Party")
data_violin

#density plot
data_density <- data %>%
  ggplot(aes(agree_pct, fill = party))+
  geom_density(alpha = 0.05)+
  labs(title = "Agreement density by Party",
       x = "Agreement")
data_density

#dot plot
top20 <- data %>%
  arrange(desc(agree_pct)) %>%
  slice(1:20)

data_dotplot <- top20 %>%
  ggplot(aes(x = reorder(name, agree_pct),
             y = agree_pct))+
  geom_point(size = 3, colour = "blue")+
  coord_flip()+
  labs(title = "Top 20 Legislators by Agreement Percentage",
       x = "",
       y = "Agreement Percentage")
data_dotplot
