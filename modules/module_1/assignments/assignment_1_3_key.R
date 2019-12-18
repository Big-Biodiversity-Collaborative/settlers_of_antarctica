# Assignment 1-3 Key
# Keaton Wilson
# keatonwilson@me.com
# 2019-12-5

# packages
library(tidyverse)

# loading in the data
df = read_csv("./modules/module_1/data/aggregated_station_data.csv")

# QC
glimpse(df)

#13 columns and 138,920 rows 

# Unique Stations
unique(df$station_id)

# Mean for Jan for each station
df %>%
  filter(month == 1) %>%
  group_by(station_id) %>%
  summarize(mean_temp = mean(temp)) %>%
  arrange(mean_temp)
