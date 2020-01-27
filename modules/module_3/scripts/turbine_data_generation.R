# Script to create wind turbine data
# Keaton Wilson
# keatonwilson@me.com
# 2020-01-27 

# packages
library(tidyverse)
library(truncnorm)

# The basic idea here is to create a dataframe on 67 wind turbines, from two 
# different manufacturers, with two columns of data: power output 
# (efficiency) at the turbine and wind speed. Also a column 
#  to mark a turbine as problematic.

complement <- function(y, rho, x) {
  if (missing(x)) x <- rnorm(length(y)) # Optional: supply a default if `x` is not given
  y.perp <- residuals(lm(x ~ y))
  rho * sd(y.perp) * y + y.perp * sd(y) * sqrt(1 - rho^2)
}

wind_turbines = data.frame(collar_id = seq(1:67),
                     maker = c(rep("Turbines turbines turbines Inc", 47), 
                               rep("Turbo turbines", 20)), 
                     wind_speed = c(rtruncnorm(n = 47, 
                                               mean = 10, 
                                               sd = 5, 
                                               a = 0),
                                         rtruncnorm(n = 20, 
                                                    mean = 10, 
                                                    sd = 5,
                                                    a = 0))) %>%
  group_by(maker) %>%
    mutate(power_output = complement(wind_speed, 0.68)) %>%
  ungroup() %>%
  mutate(power_output = ifelse(maker == "Turbines turbines turbines Inc", 
                               abs(power_output*5.2), abs(power_output*2))) 

#writing to csv
write_csv(wind_turbines, path = "./modules/module_3/data/wind_turbines.csv")
