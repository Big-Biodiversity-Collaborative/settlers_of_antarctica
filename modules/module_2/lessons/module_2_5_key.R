# Putting it all together 2_5
# Keaton Wilson
# keatonwilson@me.com
# 2020-01-07

# Packages
library(tidyverse)

# Data
fish_tank_data = read_csv("https://tinyurl.com/tbyskxl")
sick_fish = read_csv("https://tinyurl.com/yf3pv3am")

# Let's hone in on the problem - tilapia or trout
sick_fish %>%
  ggplot(aes(x = num_sick/num_fish, fill = species)) +
  geom_density(alpha = 0.7) +
  xlab("Percentage Sick/Tank") +
  ylab("Density")

# So trout are clearly the problem
# Let's isolate the trout data and figure out what tank parameters are wonky?

troutski = fish_tank_data %>%
  filter(species == "trout")

glimpse(troutski)
glimpse(sick_fish)

# Perhaps density is the issue...

# Making a true density column
fish_tank_data %>%
  mutate(density = num_fish/tank_volume) %>%
  group_by(species) %>%
  summarize(mean_dens = mean(density))

sick_fish %>%
  mutate(density = num_fish/tank_volume) %>%
  group_by(species) %>%
  summarize(mean_dens = mean(density))

fish_tank_data_trout = fish_tank_data %>%
  mutate(density = num_fish/tank_volume) %>%
  filter(species == "trout")

sick_fish_trout = sick_fish %>%
  mutate(density = num_fish/tank_volume) %>%
  filter(species == "trout")

# Looks like density of trout is higher in the tanks with sick fish, let's 
# visualize this.  

hist(fish_tank_data_trout$density)
hist(sick_fish_trout$density)


     