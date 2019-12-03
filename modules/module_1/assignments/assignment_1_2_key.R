library(tidyverse)

df = read_csv("./modules/module_1/data/mission_team_data.csv")

df$specialties = factor(df$specialties)

df %>%
  count(gender)

df %>%
  group_by(gender) %>%
  summarize(mean_age = mean(age))

df %>%
  group_by(specialties) %>%
  summarize(n = n())

# or 

df %>%
  count(specialties)
