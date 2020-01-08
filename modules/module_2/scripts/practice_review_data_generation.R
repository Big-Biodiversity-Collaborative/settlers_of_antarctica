# Practice Data for Review - We're going to need a bigger fish
# Keaton Wilson
# keatonwilson@me.com
# 2020-01-07

# packages
library(tidyverse)
library(truncnorm)

# Data - in general, we want to make a data set that students can work with to 
# practice the main skills learned in this module (simulation, functions, 
# iteration, basic plotting). 

tilapia_growth = data.frame(tank_id = rep(1:16, each = 20),
                            fish_id = 1:320, 
                            perc_soy_protein = rep(seq(0.20, 
                                                       0.80, 
                                                       by = 0.2), 
                                                   each = 80))

complement <- function(y, rho, x) {
  if (missing(x)) x <- rnorm(length(y)) # Optional: supply a default if `x` is not given
  y.perp <- residuals(lm(x ~ y))
  rho * sd(y.perp) * y + y.perp * sd(y) * sqrt(1 - rho^2)
}

tilapia_growth$day_30_weight = abs(complement(y = tilapia_growth$perc_soy_protein, rho = 0.68))*1500

tilapia_growth = as_tibble(tilapia_growth)
tilapia_growth$avg_tank_temp = rnorm(320, mean = 75, sd = 2)

write_csv(tilapia_growth, path = "./modules/module_2/data/tilapia_growth.csv")
