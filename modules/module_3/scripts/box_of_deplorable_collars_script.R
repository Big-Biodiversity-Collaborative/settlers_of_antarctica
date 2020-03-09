# Script to create seal collar data
# Keaton Wilson
# keatonwilson@me.com
# 2020-01-23 

# packages
library(tidyverse)

# creating 

new_collars = tibble(collar_id = seq(101,150, by = 1), 
                     maker = rep(NA, 50),
                     battery_life = c(rnorm(n = 27, mean = 120, sd =10), 
                                        rnorm(n = 23, mean = 86, sd = 10)), 
                     signal_distance = c(rnorm(n = 27, mean = 4200, sd = 35),
                                           rnorm(n = 23, mean = 4300, sd = 35)),
                     antenna_length = c(rnorm(n = 27, mean = 6, sd = 1), 
                                         rnorm(n = 23, mean = 6.2, sd = 1)), 
                     weight = c(rnorm(n = 27, mean = 22.5, sd = 2), 
                                rnorm(n = 23, mean = 21.2, sd = 2)))

old_collars_new_data = tibble(collar_id = seq(1:100),
                              maker = c(rep("Collarium Inc.", 47), 
                                        rep("Budget Collars LLC", 53)),
                              antenna_length = c(rnorm(n = 47, mean = 6, sd = 1), 
                                                 rnorm(n = 53, mean = 6.2, sd = 1)), 
                              weight = c(rnorm(n =47, mean = 22.5, sd = 2), 
                                         rnorm(n = 53, mean = 21.2, sd = 2)))

# scrambling
randomly <- function(x) sample(xtfrm(x))
new_collars = collars %>% arrange(randomly(collar_id))
old_collars_new_data = old_collars_new_data %>% arrange(randomly(collar_id))

#writing to csv
write_csv(new_collars, path = "./modules/module_3/data/new_collars.csv")
write_csv(old_collars_new_data, path = "./modules/module_3/data/old_collars_new_data.csv")
