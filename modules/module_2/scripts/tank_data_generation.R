# Tank generation data script (for module 2)
# Keaton Wilson
# keatonwilson@me.com
# 2020-01-01

# packages
library(tidyverse)

# generating tank data frame
fish_tanks = tibble(tank_id = c(1:1000), 
               species = c(rep("tilapia", 750), rep("trout", 250))) %>%
  mutate(avg_daily_temp = ifelse(species == "tilapia", 
                                 rnorm(n = 750, mean = 23.89, sd = 0.5), 
                                 rnorm(n = 250, mean = 15, sd = 0.5)), 
        num_fish = ifelse(species == "tilapia", 
                                 round(rnorm(n = 750, mean = 100, sd = 1)), 
                                 round(rnorm(n = 250, mean = 75, sd = 1))), 
        day_length = ifelse(species == "tilapia", 
                          round(rnorm(n = 750, mean = 10, sd = 1)), 
                          round(rnorm(n = 250, mean = 12, sd = 1))), 
        tank_volume = ifelse(species == "tilapia", 
                          (rnorm(n = 750, mean = 400, sd = 0.8)), 
                          (rnorm(n = 250, mean = 400, sd = 0.8))))
  


