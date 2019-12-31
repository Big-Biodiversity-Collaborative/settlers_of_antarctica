# Data set generation for module 2 - food/sickness data
# Keaton Wilson
# keatonwilson@me.com
# 2019-12-24

# packages
library(tidyverse)
library(randomNames)
library(stringr)
library(truncnorm)

# Reading in team data
team_data = read_csv("./modules/module_1/data/mission_team_data.csv")

# subsetting to make our sick sample
team_sub_sick = team_data %>%
  sample_n(size = 400)

# Using the truncnorm package to generate a series of values 
# that represent the percentage of a given team-members diet 
# that contains, fish, or plants (the bulk of plant-based food is grown in greenhouses) 

perc_fish = truncnorm::rtruncnorm(n = 400, a = 0, b = 1, mean = 0.4, sd = 0.5)

team_sub_sick = team_sub_sick %>%
  mutate(perc_fish = perc_fish, 
         perc_plant = 1-perc_fish)

# Function from cross-validated to generate correlated values

complement <- function(y, rho, x) {
  if (missing(x)) x <- rnorm(length(y)) # Optional: supply a default if `x` is not given
  y.perp <- residuals(lm(x ~ y))
  rho * sd(y.perp) * y + y.perp * sd(y) * sqrt(1 - rho^2)
}

# making a vector of transformed and rounded doctor trips that
# is positively correlated with the percentage of fish in a
# given team members diet

doctor_trips = round(complement(y = team_sub_sick$perc_fish, rho = 0.95)*5)

# graphing
team_sub_sick %>% 
  mutate(doctor_trips = doctor_trips) %>%
  ggplot(aes(x = perc_fish, y = doctor_trips)) +
  geom_point()

# binding
team_sub_sick = team_sub_sick %>%
  mutate(doctor_trips = doctor_trips) %>%
  filter(doctor_trips > 0)

# export
write_csv(team_sub_sick, "./modules/module_2/data/sick_data.csv")
